CLASS lcl_al_message_factory DEFINITION FINAL FOR TESTING
  DURATION SHORT
  RISK LEVEL HARMLESS.

  PRIVATE SECTION.
    " Test Methods
    METHODS:
      setup,
      teardown,
      create_from_xco_message FOR TESTING,
      create_from_symsg FOR TESTING,
      create_from_bapiret2 FOR TESTING.

    " Mock Data
    DATA FACTORY TYPE REF TO YCL_AL_MESSAGE_FACTORY.
    DATA XCO_MESSAGE TYPE REF TO IF_XCO_MESSAGE.
    DATA SYMSG TYPE SYMSG.
    DATA BAPIRET2 TYPE BAPIRET2.

ENDCLASS.

CLASS lcl_al_message_factory IMPLEMENTATION.

  METHOD setup.
    " Initialize test class and mock data
    factory = NEW ycl_al_message_factory( ).

    " Mock symsg
    symsg = VALUE #( msgid = 'TEST' msgty = 'E' msgno = '001' msgv1 = 'Parameter1' ).

    " Mock xco_message
    xco_message = xco_cp=>message( symsg ).

    " Mock bapiret2
    bapiret2 = VALUE #( id = 'TEST' type = 'E' number = '001' message_v1 = 'Parameter1' ).
  ENDMETHOD.

  METHOD teardown.
    " Cleanup objects
    CLEAR: factory, xco_message, symsg, bapiret2.
  ENDMETHOD.

  METHOD create_from_xco_message.
    " Test creating a message object from xco_message
    DATA(result) = factory->create_from_xco_message( xco_message ).

    " Assert the result is not initial
    cl_abap_unit_assert=>assert_not_initial( result ).

    " Further assertions to verify result properties
    cl_abap_unit_assert=>assert_equals(
      act = result->get_type( )->value
      exp = xco_message->value-msgty
      msg = 'Message type mismatch from xco_message' ).
  ENDMETHOD.

  METHOD create_from_symsg.
    " Test creating a message object from symsg
    DATA(result) = factory->create_from_symsg( symsg ).

    " Assert the result is not initial
    cl_abap_unit_assert=>assert_not_initial( result ).

    " Further assertions to verify result properties
    cl_abap_unit_assert=>assert_equals(
      act = result->if_xco_message~value-msgid
      exp = symsg-msgid
      msg = 'Message ID mismatch from symsg' ).
  ENDMETHOD.

  METHOD create_from_bapiret2.
    " Test creating a message object from bapiret2
    DATA(result) = factory->create_from_bapiret2( bapiret2 ).

    " Assert the result is not initial
    cl_abap_unit_assert=>assert_not_initial( result ).

    " Further assertions to verify result properties
    cl_abap_unit_assert=>assert_equals(
      act = result->if_xco_message~value-msgv1
      exp = 'Parameter1'
      msg = 'Message text mismatch from bapiret2' ).
  ENDMETHOD.

ENDCLASS.
