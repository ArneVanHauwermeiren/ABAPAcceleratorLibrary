CLASS ltc_ycl_al_message_factory DEFINITION
  FOR TESTING
  DURATION SHORT
  RISK LEVEL HARMLESS.

  PRIVATE SECTION.
    DATA: message_factory TYPE REF TO ycl_al_message_factory,
          symsg          TYPE symsg,
          message        TYPE REF TO if_xco_message.

    METHODS:
      setup,
      teardown,
      create_message FOR TESTING,
      create_message_from_bapiret2 FOR TESTING.

ENDCLASS.

CLASS ltc_ycl_al_message_factory IMPLEMENTATION.

  METHOD setup.
    message_factory = NEW ycl_al_message_factory( ).
    symsg = VALUE #( msgid = 'MyMessageClass'
                     msgno = '000'
                     msgty = xco_cp_message=>type->error->value
                     msgv1 = 'MyMessageVariable1' ).
  ENDMETHOD.

  METHOD teardown.
    CLEAR: message_factory, symsg, message.
  ENDMETHOD.

  METHOD create_message.
    message = message_factory->create( symsg ).
    cl_abap_unit_assert=>assert_not_initial( act = message ).
    cl_abap_unit_assert=>assert_equals( act = message->get_type( )
                                        exp = xco_cp_message=>type->error ).
  ENDMETHOD.

  METHOD create_message_from_bapiret2.
    DATA: bapiret2 TYPE bapiret2.
    bapiret2 = VALUE #( id = 'MyMessageClass'
                        number = '000'
                        type = xco_cp_message=>type->error->value
                        message_v1 = 'MyMessageVariable1' ).

    message = message_factory->create( message_factory->converter->bapiret2_to_symsg( bapiret2 ) ).
    cl_abap_unit_assert=>assert_not_initial( act = message ).
    cl_abap_unit_assert=>assert_equals( act = message->get_type( )
                                        exp = xco_cp_message=>type->error ).
  ENDMETHOD.

ENDCLASS.
