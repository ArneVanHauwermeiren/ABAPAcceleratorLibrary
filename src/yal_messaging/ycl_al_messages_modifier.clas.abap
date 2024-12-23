CLASS ycl_al_messages_modifier DEFINITION
  PUBLIC FINAL
  CREATE PRIVATE
  GLOBAL FRIENDS ycl_al_messages_factory.

  PUBLIC SECTION.
    METHODS add_message IMPORTING !messages     TYPE REF TO if_xco_messages
                                  !message      TYPE REF TO if_xco_message
                        RETURNING VALUE(result) TYPE REF TO if_xco_messages.

    METHODS remove_message IMPORTING !messages     TYPE REF TO if_xco_messages
                                     !message      TYPE REF TO if_xco_message
                           RETURNING VALUE(result) TYPE REF TO if_xco_messages.

    METHODS remove_duplicates IMPORTING !messages     TYPE REF TO if_xco_messages
                              RETURNING VALUE(result) TYPE REF TO if_xco_messages.
ENDCLASS.


CLASS ycl_al_messages_modifier IMPLEMENTATION.
  METHOD add_message.
    DATA(existing_messages) = messages->value.
    APPEND message TO existing_messages.
    result = xco_cp=>messages( existing_messages ).
  ENDMETHOD.

  METHOD remove_duplicates.
    DATA(existing_messages) = messages->value.

    DATA new_messages TYPE REF TO if_xco_messages.
    LOOP AT existing_messages INTO DATA(existing_message).
      IF NOT NEW ycl_al_messages_factory( )->comparator->contains( messages = new_messages
                                                                   message  = existing_message ).

      ENDIF.
    ENDLOOP.
  ENDMETHOD.

  METHOD remove_message.
    DATA(existing_messages) = messages->value.

    DATA new_messages LIKE existing_messages.
    LOOP AT existing_messages INTO DATA(existing_message).
      IF NOT NEW ycl_al_message_factory( )->comparator->equals( message1 = existing_message
                                                                message2 = message ).
        APPEND existing_message TO new_messages.
      ENDIF.
    ENDLOOP.
    result = xco_cp=>messages( new_messages ).
  ENDMETHOD.
ENDCLASS.
