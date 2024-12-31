CLASS lt_abap_strucdescr DEFINITION
  FINAL
  FOR TESTING
  DURATION SHORT
  RISK LEVEL HARMLESS.

  PRIVATE SECTION.

    DATA sut TYPE REF TO ycl_al_abap_structdescr.

    "! Setup method to initialize the instance of the class under test
    METHODS setup.

    "! Test method for the `add_field` method
    METHODS add_field
      FOR TESTING.

    "! Test method for the `get_descriptor` method
    METHODS get_descriptor
      FOR TESTING.

    "! Test method for the `create_structure` method
    METHODS create_structure
      FOR TESTING.

    "! Test method for the `get_all_subcomp_of_structdescr` method
    METHODS get_all_subcomp_of_structdescr
      FOR TESTING.

ENDCLASS.

CLASS lt_abap_strucdescr IMPLEMENTATION.
  METHOD setup.
    TYPES: BEGIN OF include,
             fieldb TYPE c LENGTH 1,
             fieldc TYPE c LENGTH 1,
           END OF include.
    TYPES: BEGIN OF structure,
             fielda TYPE c LENGTH 1.
    TYPES:   include TYPE include,
           END OF structure.

    DATA structure TYPE structure.

    sut = NEW ycl_al_abap_structdescr( CAST #( cl_abap_typedescr=>describe_by_data( structure ) ) ).
  ENDMETHOD.

  METHOD add_field.
    DATA(fieldname) = 'TEST_FIELD'.
    DATA(fieldtype) = 'I'.

    " Add a field to the structure descriptor
    sut->add_field( fieldname = CONV #( fieldname )
                    fieldtype = CONV #( fieldtype ) ).

    " Verify that the descriptor includes the new field
    DATA(descriptor) = sut->get_descriptor( ).
    DATA(components) = descriptor->get_components( ).

    cl_abap_unit_assert=>assert_equals(
      act = components[ 3 ]-name
      exp = fieldname
      msg = 'Field name mismatch after adding a field.' ).

    cl_abap_unit_assert=>assert_equals(
      act = components[ 3 ]-type->absolute_name
      exp = '\TYPE=I'
      msg = 'Field type mismatch after adding a field.' ).
  ENDMETHOD.

  METHOD get_descriptor.
    " Retrieve the structure descriptor
    DATA(descriptor) = sut->get_descriptor( ).

    " Verify that the descriptor is not initial
    cl_abap_unit_assert=>assert_bound( descriptor ).
  ENDMETHOD.

  METHOD create_structure.
    " Create a structure instance from the descriptor
    DATA(structure) = sut->create_structure( ).

    " Verify the structure's components
    ASSIGN structure->* TO FIELD-SYMBOL(<structure>).
    ASSIGN COMPONENT 'FIELDA' OF STRUCTURE <structure> TO FIELD-SYMBOL(<field_a>).
    ASSIGN COMPONENT 'FIELDB' OF STRUCTURE <structure> TO FIELD-SYMBOL(<field_b>).
    ASSIGN COMPONENT 'FIELDC' OF STRUCTURE <structure> TO FIELD-SYMBOL(<field_c>).
    <field_a> = 'A'.
    <field_b> = 'B'.
    <field_c> = 'C'.
    cl_abap_unit_assert=>assert_not_initial( <structure> ).
    cl_abap_unit_assert=>assert_not_initial( <field_a> ).
    cl_abap_unit_assert=>assert_not_initial( <field_b> ).
    cl_abap_unit_assert=>assert_not_initial( <field_c> ).
  ENDMETHOD.

  METHOD get_all_subcomp_of_structdescr.
    DATA(components) = sut->get_all_subcomp_of_structdescr( ).

    " Verify the subcomponents
    cl_abap_unit_assert=>assert_equals( exp = 3
                                        act = lines( components )
                                        msg = 'Incorrect number of components.' ).

    DATA(test) = components[ 1 ]-name.
    cl_abap_unit_assert=>assert_equals( exp = 'FIELDA'
                                        act = components[ 1 ]-name
                                        msg = 'First component name mismatch.' ).

    cl_abap_unit_assert=>assert_equals( exp = 'FIELDB'
                                        act = components[ 2 ]-name
                                        msg = 'Second component name mismatch.' ).

    cl_abap_unit_assert=>assert_equals( exp = 'FIELDC'
                                        act = components[ 3 ]-name
                                        msg = 'Third component name mismatch.' ).
  ENDMETHOD.

ENDCLASS.
