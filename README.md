# SAP Enhancement Framework: Custom BAdI QM Inspection Lot Priority Escalator

## Project Overview
Modifying core SAP source code is against modern architecture guidelines. Instead, custom enhancements are integrated via the **SAP Enhancement Framework**. 

This repository simulates a real-world **BAdI (Business Add-In)** implementation inside the **SAP QM (Quality Management)** module. The code hooks into an inspection lot creation lifecycle interface, dynamically changing business workflow parameters (like priority flags) based on custom inventory thresholds before the data hits the database.

## Key Technical Features Implemented
* **Interface-Driven Design:** The implementation relies on the explicit implementation of an interface structure (`INTERFACES: zif_ex_qm_lot_handling`), aligning with classic SAP modern object-oriented application design patterns.
* **Changing Parameters:** Utilizes `CHANGING` signatures in the interface methods to manipulate standard dataset payloads safely without interrupting structural integrity.
* **Module Segregation:** Keeps custom evaluation parameters encapsulated in private methods (`is_critical_fluid`), ensuring code stays decoupled and modular.

## Practical Application Context
This project addresses real scenarios found in food, beverage, or chemical plants (such as Ehrmann SE processes). For instance, when a bulk shipment of raw liquid material arrives and exceeds 500 units, the system catches the record via the BAdI pre-save loop and forces a "High Priority" lab processing tag to prevent processing delays or inventory spoilage.
