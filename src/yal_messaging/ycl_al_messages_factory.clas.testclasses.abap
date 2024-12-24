CLASS lcl_ycl_al_messages_factory DEFINITION
  FOR TESTING
  DURATION SHORT
  RISK LEVEL HARMLESS.

  PRIVATE SECTION.
    DATA: messages_factory TYPE REF TO ycl_al_messages_factory,
          sxco_t_messages TYPE sxco_t_messages,
          messages        TYPE REF TO if_xco_messages.

    METHODS:
      setup,
      teardown,
      create FOR TESTING,
      create_empty FOR TESTING.

ENDCLASS.

CLASS lcl_ycl_al_messages_factory IMPLEMENTATION.

  METHOD setup.
    messages_factory = NEW ycl_al_messages_factory( ).
    sxco_t_messages = VALUE #( ( xco_cp=>message( VALUE #( msgid = 'MSG_CLASS' msgno = '001' msgty = 'E' ) ) )
                               ( xco_cp=>message( VALUE #( msgid = 'MSG_CLASS' msgno = '002' msgty = 'W' ) ) ) ).
  ENDMETHOD.

  METHOD teardown.
    CLEAR: messages_factory, sxco_t_messages, messages.
  ENDMETHOD.

  METHOD create.
    messages = messages_factory->create( sxco_t_messages ).
    cl_abap_unit_assert=>assert_not_initial( act = messages ).
    cl_abap_unit_assert=>assert_equals( act = lines( messages->value ) exp = 2 ).
  ENDMETHOD.

  METHOD create_empty.
    DATA empty_sxco_t_messages TYPE sxco_t_messages.
    messages = messages_factory->create( empty_sxco_t_messages ).
    cl_abap_unit_assert=>assert_not_bound( act = messages ).
  ENDMETHOD.

ENDCLASS.
