CLASS lcl_ycl_al_messages_converter DEFINITION
  FOR TESTING
  DURATION SHORT
  RISK LEVEL HARMLESS.

  PRIVATE SECTION.
    DATA: converter   TYPE REF TO ycl_al_messages_converter,
          bapirettab  TYPE bapirettab,
          messages    TYPE sxco_t_messages.

    METHODS:
      setup,
      teardown,
      bapirettab_to_sxco_t_messages FOR TESTING.

ENDCLASS.

CLASS lcl_ycl_al_messages_converter IMPLEMENTATION.

  METHOD setup.
    converter = NEW ycl_al_messages_factory( )->converter.
    bapirettab = VALUE #( ( id = 'MSG_CLASS' number = '001' type = 'E' message_v1 = 'Var1' )
                          ( id = 'MSG_CLASS' number = '002' type = 'W' message_v1 = 'Var2' ) ).
  ENDMETHOD.

  METHOD teardown.
    CLEAR: converter, bapirettab, messages.
  ENDMETHOD.

  METHOD bapirettab_to_sxco_t_messages.
    messages = converter->bapirettab_to_sxco_t_messages( bapirettab ).
    cl_abap_unit_assert=>assert_not_initial( act = messages ).
    cl_abap_unit_assert=>assert_equals( act = lines( messages ) exp = 2 ).
  ENDMETHOD.

ENDCLASS.
