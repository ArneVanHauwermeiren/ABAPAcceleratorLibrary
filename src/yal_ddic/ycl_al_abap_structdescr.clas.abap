CLASS ycl_al_abap_structdescr DEFINITION
  PUBLIC FINAL
  CREATE PUBLIC.


  PUBLIC SECTION.
    "!
    "! Constructor for initializing the structure descriptor.
    "!
    "! @parameter structure_descriptor | A reference to an existing structure descriptor.
    METHODS constructor IMPORTING structure_descriptor TYPE REF TO cl_abap_structdescr.

    "!
    "! Adds a field to the structure descriptor.
    "!
    "! @parameter fieldname | The name of the field to be added.
    "! @parameter fieldtype | The type of the field to be added.
    METHODS add_field IMPORTING fieldname TYPE abap_compname
                                fieldtype TYPE abap_compname.

    "!
    "! Retrieves the structure descriptor.
    "!
    "! @parameter result | The structure descriptor.
    METHODS get_descriptor RETURNING VALUE(result) TYPE REF TO cl_abap_structdescr.

    "!
    "! Creates a new structure of the type defined by the structure descriptor.
    "!
    "! @parameter result | The newly created structure instance.
    METHODS create_structure RETURNING VALUE(result) TYPE REF TO data.

    "!
    "! Retrieves <strong>all</strong> components of the structure descriptor, including those nested
    "! in deep structures.
    "! This only works for nested structures/includes, <strong>not tables</strong>.
    "!
    "! @parameter result | A table containing all components (fields and nested structures).
    METHODS get_all_subcomponents RETURNING VALUE(result) TYPE abap_component_tab.

  PRIVATE SECTION.
    "!
    "! The structure descriptor which is either provided or created for this object.
    DATA structure_descriptor TYPE REF TO cl_abap_structdescr.

ENDCLASS.

CLASS ycl_al_abap_structdescr IMPLEMENTATION.
  METHOD add_field.
    DATA components TYPE cl_abap_structdescr=>component_table.

    IF structure_descriptor IS BOUND.
      components = structure_descriptor->get_components( ).
    ENDIF.

    APPEND VALUE #( name = fieldname
                    type = CAST cl_abap_datadescr( cl_abap_typedescr=>describe_by_name( fieldtype ) ) ) TO components.

    structure_descriptor = cl_abap_structdescr=>create( components ).
  ENDMETHOD.

  METHOD constructor.
    me->structure_descriptor = structure_descriptor.
  ENDMETHOD.

  METHOD create_structure.
    CREATE DATA result TYPE HANDLE structure_descriptor.
  ENDMETHOD.

  METHOD get_all_subcomponents.
    LOOP AT structure_descriptor->get_components( ) INTO DATA(component).
      IF component-type IS INSTANCE OF cl_abap_structdescr.
        DATA(sub_component_structdescr) = NEW ycl_al_abap_structdescr( CAST cl_abap_structdescr( component-type ) ).
        APPEND LINES OF sub_component_structdescr->get_all_subcomponents( ) TO result.
      ELSE.
        APPEND component TO result.
      ENDIF.
    ENDLOOP.
  ENDMETHOD.

  METHOD get_descriptor.
    result = structure_descriptor.
  ENDMETHOD.

ENDCLASS.
