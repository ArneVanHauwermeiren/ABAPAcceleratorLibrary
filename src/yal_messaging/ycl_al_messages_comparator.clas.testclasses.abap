CLASS lcl_ycl_al_messages_comparator DEFINITION
  FOR TESTING
  DURATION SHORT
  RISK LEVEL HARMLESS.

  PRIVATE SECTION.
    DATA: comparator TYPE REF TO ycl_al_messages_comparator,
          messages1  TYPE REF TO if_xco_messages,
          messages2  TYPE REF TO if_xco_messages,
          message    TYPE REF TO if_xco_message.

    METHODS:
      setup,
      teardown,
      equals FOR TESTING,
      contains FOR TESTING.

ENDCLASS.

CLASS lcl_ycl_al_messages_comparator IMPLEMENTATION.

  METHOD setup.
    comparator = NEW ycl_al_messages_factory( )->comparator.
    message = xco_cp=>message( VALUE #( msgid = 'MSG_CLASS' msgno = '001' msgty = 'E' ) ).
    messages1 = xco_cp=>messages( VALUE #( ( message ) ) ).
    messages2 = xco_cp=>messages( VALUE #( ( message ) ) ).
  ENDMETHOD.

  METHOD teardown.
    CLEAR: comparator, messages1, messages2, message.
  ENDMETHOD.

  METHOD equals.
    DATA(result) = comparator->equals( messages1 = messages1 messages2 = messages2 ).
    cl_abap_unit_assert=>assert_true( act = result ).
  ENDMETHOD.

  METHOD contains.
    DATA(result) = comparator->contains( messages = messages1 message = message ).
    cl_abap_unit_assert=>assert_true( act = result ).
  ENDMETHOD.

ENDCLASS.
