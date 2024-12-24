CLASS lcl_ycl_al_message_comparator DEFINITION
  FOR TESTING
  DURATION SHORT
  RISK LEVEL HARMLESS.

  PRIVATE SECTION.
    DATA: comparator TYPE REF TO ycl_al_message_comparator,
          message1   TYPE REF TO if_xco_message,
          message2   TYPE REF TO if_xco_message.

    METHODS:
      setup,
      teardown,
      equals FOR TESTING.

ENDCLASS.

CLASS lcl_ycl_al_message_comparator IMPLEMENTATION.

  METHOD setup.
    comparator = NEW ycl_al_message_factory( )->comparator.
    message1 = xco_cp=>message( VALUE #( msgid = 'MSG_CLASS' msgno = '001' msgty = 'E' ) ).
    message2 = xco_cp=>message( VALUE #( msgid = 'MSG_CLASS' msgno = '001' msgty = 'E' ) ).
  ENDMETHOD.

  METHOD teardown.
    CLEAR: comparator, message1, message2.
  ENDMETHOD.

  METHOD equals.
    DATA(result) = comparator->equals( message1 = message1 message2 = message2 ).
    cl_abap_unit_assert=>assert_true( act = result ).
  ENDMETHOD.

ENDCLASS.
