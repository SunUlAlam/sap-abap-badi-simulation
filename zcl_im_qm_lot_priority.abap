*----------------------------------------------------------------------*
* INTERFACE zif_ex_qm_lot_handling
*----------------------------------------------------------------------*
* Simulated SAP Standard Business Add-In (BAdI) Interface
*----------------------------------------------------------------------*
INTERFACE zif_ex_qm_lot_handling.

  TYPES: BEGIN OF ty_inspection_lot,
           prueflos   TYPE n LENGTH 12, " Inspection Lot Number
           matnr      TYPE string,      " Material Number
           charg      TYPE string,      " Batch Number
           gesmng     TYPE quan,        " Total Quantity
           charg_type TYPE string,      " Custom: LIQUID, DRY, etc.
           priority   TYPE char1,       " Priority (1 = High, 2 = Medium, 3 = Low)
         END OF ty_inspection_lot.

  METHODS:
    before_save
      CHANGING
        cs_layout_lot TYPE ty_inspection_lot.

ENDINTERFACE.


*----------------------------------------------------------------------*
* CLASS zcl_im_qm_lot_priority DEFINITION
*----------------------------------------------------------------------*
* Author: Sunzid Ul Alam
* Description: BAdI Implementation Class for Custom QM Priority Logic
*----------------------------------------------------------------------*
CLASS zcl_im_qm_lot_priority DEFINITION PUBLIC FINAL CREATE PUBLIC.

  PUBLIC SECTION.
    INTERFACES: zif_ex_qm_lot_handling.

  PRIVATE SECTION.
    " Constant business rule values
    CONSTANTS: cv_critical_qty  TYPE i VALUE 500,
               cv_high_priority TYPE char1 VALUE '1'.

    METHODS:
      is_critical_fluid
        IMPORTING iv_material_type  TYPE string
        RETURNING VALUE(rv_is_fluid) TYPE abap_bool.

ENDCLASS.


*----------------------------------------------------------------------*
* CLASS zcl_im_qm_lot_priority IMPLEMENTATION
*----------------------------------------------------------------------*
CLASS zcl_im_qm_lot_priority IMPLEMENTATION.

  METHOD zif_ex_qm_lot_handling~before_save.
    " Implements the standard SAP interface method hook
    
    " Check if the material type requires stricter fluid processing controls
    IF me->is_critical_fluid( cs_layout_lot-charg_type ) = abap_true.
      
      " Business Rule: If total lot volume exceeds the defined critical threshold,
      " escalate priority automatically to ensure rapid lab throughput.
      IF cs_layout_lot-gesmng > cv_critical_qty.
        cs_layout_lot-priority = cv_high_priority.
        
        " Message output simulation (mimicking system application log entry)
        " MESSAGE 'QM BAdI: Volume threshold exceeded. Lot set to High Priority.' TYPE 'I'.
      ENDIF.
      
    ENDIF.
  ENDMETHOD.

  METHOD is_critical_fluid.
    " Simulating a table lookup or metadata check
    IF iv_material_type = 'LIQUID' OR iv_material_type = 'FLUID'.
      rv_is_fluid = abap_true.
    ELSE.
      rv_is_fluid = abap_false.
    ENDIF.
  ENDMETHOD.

ENDCLASS.
