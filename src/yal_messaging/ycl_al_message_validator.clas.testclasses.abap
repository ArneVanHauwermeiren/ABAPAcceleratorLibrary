CLASS lcl_ycl_al_message_validator DEFINITION
  FOR TESTING
  DURATION SHORT
  RISK LEVEL HARMLESS.

  PRIVATE SECTION.
    DATA: validator TYPE REF TO ycl_al_message_validator,
          message   TYPE REF TO if_xco_message.

    METHODS:
      setup,
      teardown,
      is_error FOR TESTING,
      is_warning FOR TESTING,
      is_success FOR TESTING,
      is_information FOR TESTING.

ENDCLASS.

CLASS lcl_ycl_al_message_validator IMPLEMENTATION.

  METHOD setup.
    validator = NEW ycl_al_message_factory( )->validator.
    message = xco_cp=>message( VALUE #( msgid = 'MSG_CLASS' msgno = '001' msgty = 'E' ) ).
  ENDMETHOD.

  METHOD teardown.
    CLEAR: validator, message.
  ENDMETHOD.

  METHOD is_error.
    DATA(result) = validator->is_error( message ).
    cl_abap_unit_assert=>assert_true( act = result ).
  ENDMETHOD.

  METHOD is_warning.
    message = xco_cp=>message( VALUE #( msgid = 'MSG_CLASS' msgno = '001' msgty = 'W' ) ).
    DATA(result) = validator->is_warning( message ).
    cl_abap_unit_assert=>assert_true( act = result ).
  ENDMETHOD.

  METHOD is_success.
    message = xco_cp=>message( VALUE #( msgid = 'MSG_CLASS' msgno = '001' msgty = 'S' ) ).
    DATA(result) = validator->is_success( message ).
    cl_abap_unit_assert=>assert_true( act = result ).
  ENDMETHOD.

  METHOD is_information.
    message = xco_cp=>message( VALUE #( msgid = 'MSG_CLASS' msgno = '001' msgty = 'I' ) ).
    DATA(result) = validator->is_information( message ).
    cl_abap_unit_assert=>assert_true( act = result ).
  ENDMETHOD.

ENDCLASS.
