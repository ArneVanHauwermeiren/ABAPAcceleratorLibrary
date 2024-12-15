CLASS ycl_al_message DEFINITION
    PUBLIC
    CREATE PRIVATE
    GLOBAL FRIENDS ycl_al_message_factory.

  PUBLIC SECTION.
    INTERFACES:
        if_message.

    ALIASES:
        get_text FOR if_message~get_text,
        get_long_text FOR if_message~get_longtext.

    DATA bapiret2 TYPE bapiret2.

    METHODS constructor IMPORTING bapiret2 TYPE bapiret2.
    METHODS is_error RETURNING VALUE(result) TYPE abap_boolean.
  PRIVATE SECTION.

ENDCLASS.

CLASS ycl_al_message IMPLEMENTATION.
  METHOD constructor.
    me->bapiret2 = bapiret2.
  ENDMETHOD.

  METHOD get_text.
    if bapiret2-message is INITIAL.
        CALL FUNCTION 'BAPI_MESSAGE_GETDETAIL'
          EXPORTING
            id           = bapiret2-id
            number       = bapiret2-number
            textformat   = 'ASC' "ASCII
            message_v1   = bapiret2-message_v1
            message_v2   = bapiret2-message_v2
            message_v3   = bapiret2-message_v3
            message_v4   = bapiret2-message_v4
          IMPORTING
            message      = bapiret2-message.
    ENDIF.
  ENDMETHOD.

  METHOD get_long_text.
    result = get_text( ).
  ENDMETHOD.

  METHOD is_error.
    result = COND #( WHEN bapiret2-type = CONV symsgty( ycl_al_message_type=>error ) THEN abap_true ELSE abap_false ).
  ENDMETHOD.
ENDCLASS.
