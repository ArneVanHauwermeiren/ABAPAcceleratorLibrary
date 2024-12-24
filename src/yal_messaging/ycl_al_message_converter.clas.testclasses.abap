CLASS lcl_ycl_al_message_converter DEFINITION
  FOR TESTING
  DURATION SHORT
  RISK LEVEL HARMLESS.

  PRIVATE SECTION.
    DATA: converter TYPE REF TO ycl_al_message_converter,
          bapiret2  TYPE bapiret2,
          symsg     TYPE symsg.

    METHODS:
      setup,
      teardown,
      bapiret2_to_symsg FOR TESTING.

ENDCLASS.

CLASS lcl_ycl_al_message_converter IMPLEMENTATION.

  METHOD setup.
    converter = NEW ycl_al_message_factory( )->converter.
    bapiret2 = VALUE #( id = 'MSG_CLASS' number = '001' type = 'E' message_v1 = 'Var1' ).
  ENDMETHOD.

  METHOD teardown.
    CLEAR: converter, bapiret2, symsg.
  ENDMETHOD.

  METHOD bapiret2_to_symsg.
    symsg = converter->bapiret2_to_symsg( bapiret2 ).
    cl_abap_unit_assert=>assert_equals( act = symsg-msgid exp = bapiret2-id ).
    cl_abap_unit_assert=>assert_equals( act = symsg-msgno exp = bapiret2-number ).
    cl_abap_unit_assert=>assert_equals( act = symsg-msgty exp = bapiret2-type ).
    cl_abap_unit_assert=>assert_equals( act = symsg-msgv1 exp = bapiret2-message_v1 ).
  ENDMETHOD.

ENDCLASS.
