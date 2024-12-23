CLASS ycl_al_messaging_demo DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
    "MESSAGE
    METHODS create_message RETURNING VALUE(result) TYPE REF TO if_xco_message.
    METHODS create_message_from_bapiret2 RETURNING VALUE(result) TYPE REF TO if_xco_message.
    METHODS is_message_error RETURNING VALUE(result) TYPE abap_boolean.

    "MESSAGES
    METHODS create_messages RETURNING VALUE(result) TYPE REF TO if_xco_messages.
    METHODS create_messages_frm_bapirettab RETURNING VALUE(result) TYPE REF TO if_xco_messages.
    METHODS messages_has_error RETURNING VALUE(result) TYPE abap_boolean.
    METHODS get_errors RETURNING VALUE(result) TYPE REF TO if_xco_messages.
    METHODS add_message RETURNING VALUE(result) TYPE REF TO if_xco_messages.
    METHODS remove_message RETURNING VALUE(result) TYPE REF TO if_xco_messages.

    "HELPER METHODS
    METHODS get_bapiret2 RETURNING VALUE(result) TYPE bapiret2.
    METHODS get_bapirettab RETURNING VALUE(result) TYPE bapirettab.
    METHODS get_symsg RETURNING VALUE(result) TYPE symsg.
ENDCLASS.



CLASS ycl_al_messaging_demo IMPLEMENTATION.
  METHOD if_oo_adt_classrun~main.
    create_message( ).
    create_message_from_bapiret2( ).
    is_message_error( ).

    create_messages( ).
    create_messages_frm_bapirettab( ).
    messages_has_error( ).
  ENDMETHOD.

  METHOD create_message.
    result = xco_cp=>message( get_symsg( ) ).
  ENDMETHOD.

  METHOD create_message_from_bapiret2.
    DATA(message_factory) = new ycl_al_message_factory( ).
    result = message_factory->create( message_factory->converter->bapiret2_to_symsg( get_bapiret2( ) ) ).
  ENDMETHOD.

  METHOD is_message_error.
    NEW ycl_al_message_factory( )->validator->is_error( create_message( ) ).
  ENDMETHOD.

  METHOD create_messages.
    DATA(message1) = create_message( ).
    DATA(message2) = create_message( ).
    result = xco_cp=>messages( VALUE #( ( message1 )
                                        ( message2 ) ) ).
  ENDMETHOD.

  METHOD create_messages_frm_bapirettab.
    DATA(messages_factory) = new ycl_al_messages_factory( ).
    result = messages_factory->create( messages_factory->converter->bapirettab_to_sxco_t_messages( get_bapirettab( ) ) ).
  ENDMETHOD.

  METHOD messages_has_error.
    result = new ycl_al_messages_factory( )->validator->has_errors( create_messages( ) ).
  ENDMETHOD.

  METHOD get_errors.
    ##TODO
    "result = new ycl_al_messages_validator( create_messages( ) )->get_messages_of_type( xco_cp_message=>type->error ).
  ENDMETHOD.

  METHOD add_message.
  ##TODO
    "new ycl_al_messages( create_messages(  ) )->add_message( create_message( ) ).
  ENDMETHOD.

  METHOD remove_message.
  ##TODO
    "new ycl_al_messages( create_messages(  ) )->remove_message( create_message( ) ).
  ENDMETHOD.

  METHOD get_bapiret2.
    result = VALUE #( id         = 'MyMessageClass'
                      number     = '000'
                      type       = xco_cp_message=>type->error->value
                      message_v1 = 'MyMessageVariable1' ).
  ENDMETHOD.

  METHOD get_bapirettab.
    result = VALUE #( ( get_bapiret2(  ) )
                      ( get_bapiret2( ) ) ).
  ENDMETHOD.

  METHOD get_symsg.
    result = VALUE #( msgid = 'MyMessageClass'
                      msgno = '000'
                      msgty = xco_cp_message=>type->error->value
                      msgv1 = 'MyMessageVariable1' ).
  ENDMETHOD.
ENDCLASS.
