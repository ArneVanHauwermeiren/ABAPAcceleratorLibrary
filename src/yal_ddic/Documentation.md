```mermaid

classDiagram
class ycl_al_abap_structdescr {
    +constructor(structure_descriptor: cl_abap_structdescr)
    +add_field(fieldname: abap_compname, fieldtype: abap_compname)
    +get_descriptor() cl_abap_structdescr
    +create_structure() data
    +get_all_subcomp_of_structdescr() abap_component_tab
    -structure_descriptor: cl_abap_structdescr
}
