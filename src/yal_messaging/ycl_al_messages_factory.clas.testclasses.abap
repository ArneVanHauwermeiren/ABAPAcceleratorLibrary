CLASS lcl_al_messages_factory DEFINITION FINAL FOR TESTING
  DURATION SHORT
  RISK LEVEL HARMLESS.

  PRIVATE SECTION.
    " Test Methods
    METHODS:
      setup,
      teardown,
      create_from_xco_messages FOR TESTING,
      create_from_sxco_t_messages FOR TESTING,
      create_from_bapirettab FOR TESTING.

    " Mock Data
    DATA:
      factory        TYPE REF TO ycl_al_messages_factory,
      xco_messages   TYPE REF TO if_xco_messages,
      sxco_t_messages TYPE sxco_t_messages,
      bapirettab     TYPE bapirettab.

ENDCLASS.

CLASS lcl_al_messages_factory IMPLEMENTATION.

  METHOD setup.
    " Initialize the factory object and mock data
    factory = NEW ycl_al_messages_factory( ).

    " Mock sxco_t_messages
    DATA(message_factory) = new ycl_al_message_factory( ).
    DATA(message1) = message_factory->create_from_symsg( VALUE #( msgid = 'TEST' msgty = 'E' msgno = '001' msgv1 = 'Param1' ) ).
    DATA(message2) = message_factory->create_From_symsg( VALUE #( msgid = 'TEST' msgty = 'W' msgno = '002' msgv1 = 'Param2' ) ).
    sxco_t_messages = VALUE #( ( message1 )
                               ( message2 ) ).

    " Mock xco_messages
    xco_messages = new ycl_al_messages_factory( )->create_from_sxco_t_messages( sxco_t_messages ).

    " Mock bapirettab
    bapirettab = VALUE #(
      ( id = 'TEST' type = 'E' number = '001' message_v1 = 'Param1' )
      ( id = 'TEST' type = 'W' number = '002' message_v1 = 'Param2' )
    ).
  ENDMETHOD.

  METHOD teardown.
    " Clear mock data and factory
    CLEAR: factory, xco_messages, sxco_t_messages, bapirettab.
  ENDMETHOD.

  METHOD create_from_xco_messages.
    " Test creating a collection from xco_messages
    DATA(result) = factory->create_from_xco_messages( xco_messages ).

    " Assert the result is not initial
    cl_abap_unit_assert=>assert_not_initial( result ).

    " Further assertions can validate the collection size and content
    cl_abap_unit_assert=>assert_equals(
      act = lines( result->get_messages( ) )
      exp = 2
      msg = 'Incorrect message count from xco_messages' ).
  ENDMETHOD.

  METHOD create_from_sxco_t_messages.
    " Test creating a collection from sxco_t_messages
    DATA(result) = factory->create_from_sxco_t_messages( sxco_t_messages ).

    " Assert the result is not initial
    cl_abap_unit_assert=>assert_not_initial( result ).

    " Further assertions to verify the collection content
    cl_abap_unit_assert=>assert_equals(
      act = lines( result->get_messages( ) )
      exp = 2
      msg = 'Incorrect message count from sxco_t_messages' ).
  ENDMETHOD.

  METHOD create_from_bapirettab.
    " Test creating a collection from bapirettab
    DATA(result) = factory->create_from_bapirettab( bapirettab ).

    " Assert the result is not initial
    cl_abap_unit_assert=>assert_not_initial( result ).

    " Further assertions to validate content
    cl_abap_unit_assert=>assert_equals(
      act = lines( result->get_messages( ) )
      exp = 2
      msg = 'Incorrect message count from bapirettab' ).
  ENDMETHOD.

ENDCLASS.
