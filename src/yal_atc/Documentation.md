# YAL_ATC Package Documentation

The **YAL_ATC** package contains all necessary objects for executing the recommended ATC checks.

## Purpose

The primary goal of this set of checks is to align with the [Capgemini Belgium SAP Technical Best Practice Guidelines](https://github.com/Capgemini-SAP-BE-Technical-Community/Backend-Development-Best-Practices). These guidelines emphasize adherence to the principles outlined in the **Clean ABAP** initiative.

## Recommended Variant

The recommended ATC variant to use is **YAL_ATC**. This variant incorporates:

1. Subset of standard SAP-provided checks
2. Checks from **Code Pal for ABAP**
3. Custom checks
4. Unit tests

This variant is designed with the guiding principle that priority 1 and 2 errors should not be exempted under any circumstances.
Consequently, it is recommended to block the release of transport tasks if any priority 1 or 2 errors are detected.

---

## Code Pal for ABAP

**Code Pal for ABAP** is an open-source collection of checks designed to facilitate the adoption of Clean ABAP coding standards. Two variants of this tool are available:

- [Cloud Variant](https://github.com/SAP/code-pal-for-abap-cloud)
- [On-premise Variant](https://github.com/SAP/code-pal-for-abap)

**Important!**
Ensure Code Pal for ABAP is installed separately.  The YAL_ATC check variant is dependant upon it.

---

## Custom Checks

Currently, the package includes a single custom check: a verification of DDIC object naming conventions.

