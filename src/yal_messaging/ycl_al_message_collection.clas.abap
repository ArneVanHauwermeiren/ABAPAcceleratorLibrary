CLASS ycl_al_message_collection DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    DATA messages TYPE TABLE OF REF TO ycl_al_message READ-ONLY.

    METHODS add_message IMPORTING message TYPE REF TO ycl_al_message.
    METHODS get_messages_by_type IMPORTING type TYPE ycl_al_message_type=>type
            RETURNING VALUE(result) TYPE REF TO ycl_al_message_collection.
    METHODS to_bapirettab RETURNING VALUE(result) TYPE bapirettab.
    METHODS has_errors RETURNING VALUE(result) TYPE abap_boolean.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ycl_al_message_collection IMPLEMENTATION.
  METHOD add_message.
    APPEND message TO messages.
  ENDMETHOD.

  METHOD get_messages_by_type.
    LOOP AT messages INTO DATA(message).
        IF message->bapiret2-type = CONV symsgty( type ).
            result->add_message( message ).
        ENDIF.
    ENDLOOP.
  ENDMETHOD.

  METHOD to_bapirettab.
    LOOP AT messages INTO DATA(message).
      APPEND message->bapiret2 TO result.
    ENDLOOP.
  ENDMETHOD.

  METHOD has_errors.
    LOOP AT messages INTO DATA(message).
        IF message->bapiret2-type = CONV symsgty( ycl_al_message_type=>error ).
            result = abap_true.
            RETURN.
        ENDIF.
    ENDLOOP.
  ENDMETHOD.

ENDCLASS.
