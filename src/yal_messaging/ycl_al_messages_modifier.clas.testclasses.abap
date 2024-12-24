CLASS lcl_ycl_al_messages_modifier DEFINITION
  FOR TESTING
  DURATION SHORT
  RISK LEVEL HARMLESS.

  PRIVATE SECTION.
    DATA: modifier TYPE REF TO ycl_al_messages_modifier,
          messages TYPE REF TO if_xco_messages,
          message  TYPE REF TO if_xco_message.

    METHODS:
      setup,
      teardown,
      add_message FOR TESTING,
      remove_message FOR TESTING,
      remove_duplicates FOR TESTING.

ENDCLASS.

CLASS lcl_ycl_al_messages_modifier IMPLEMENTATION.

  METHOD setup.
    modifier = NEW ycl_al_messages_factory( )->modifier.
    message = xco_cp=>message( VALUE #( msgid = 'MSG_CLASS' msgno = '001' msgty = 'E' ) ).
    messages = xco_cp=>messages( VALUE #( ( message ) ) ).
  ENDMETHOD.

  METHOD teardown.
    CLEAR: modifier, messages, message.
  ENDMETHOD.

  METHOD add_message.
    DATA(new_message) = xco_cp=>message( VALUE #( msgid = 'MSG_CLASS' msgno = '002' msgty = 'W' ) ).
    DATA(result) = modifier->add_message( messages = messages message = new_message ).
    cl_abap_unit_assert=>assert_not_initial( act = result ).
    cl_abap_unit_assert=>assert_equals( act = lines( result->value ) exp = 2 ).
  ENDMETHOD.

  METHOD remove_message.
    DATA(result) = modifier->remove_message( messages = messages message = message ).
    cl_abap_unit_assert=>assert_not_initial( act = result ).
    cl_abap_unit_assert=>assert_equals( act = lines( result->value ) exp = 0 ).
  ENDMETHOD.

  METHOD remove_duplicates.
    DATA(duplicate_message) = xco_cp=>message( VALUE #( msgid = 'MSG_CLASS' msgno = '001' msgty = 'E' ) ).
    DATA(duplicate_messages) = xco_cp=>messages( VALUE #( ( message ) ( duplicate_message ) ) ).
    DATA(result) = modifier->remove_duplicates( messages = duplicate_messages ).
    cl_abap_unit_assert=>assert_not_initial( act = result ).
    cl_abap_unit_assert=>assert_equals( act = lines( result->value ) exp = 1 ).
  ENDMETHOD.

ENDCLASS.
