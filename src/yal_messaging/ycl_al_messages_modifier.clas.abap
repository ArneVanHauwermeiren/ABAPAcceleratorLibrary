"!" Class `ycl_al_messages_modifier`
"!
"! This class provides utilities to modify collections of messages.
"! It includes methods to add, remove, and remove duplicate messages from a collection.
CLASS ycl_al_messages_modifier DEFINITION
  PUBLIC FINAL
  CREATE PRIVATE
  GLOBAL FRIENDS ycl_al_messages_factory.

  PUBLIC SECTION.
    "! Adds a message to the collection.
    "!
    "! @parameter messages | The collection to which the message will be added.
    "! @parameter message | The message to be added.
    "! @parameter result | The updated collection of messages.
    METHODS add_message IMPORTING !messages     TYPE REF TO if_xco_messages
                                  !message      TYPE REF TO if_xco_message
                        RETURNING VALUE(result) TYPE REF TO if_xco_messages.

    "! Removes a message from the collection.
    "!
    "! @parameter messages | The collection from which the message will be removed.
    "! @parameter message | The message to be removed.
    "! @parameter result | The updated collection of messages.
    METHODS remove_message IMPORTING !messages     TYPE REF TO if_xco_messages
                                     !message      TYPE REF TO if_xco_message
                           RETURNING VALUE(result) TYPE REF TO if_xco_messages.

    "! Removes duplicate messages from the collection.
    "!
    "! @parameter messages | The collection from which duplicates will be removed.
    "! @parameter result | The updated collection of unique messages.
    METHODS remove_duplicates IMPORTING !messages     TYPE REF TO if_xco_messages
                              RETURNING VALUE(result) TYPE REF TO if_xco_messages.
ENDCLASS.



CLASS ycl_al_messages_modifier IMPLEMENTATION.
  METHOD add_message.
    DATA existing_messages TYPE sxco_t_messages.
    IF messages IS NOT INITIAL.
        existing_messages = messages->value.
    ENDIF.
    APPEND message TO existing_messages.
    result = xco_cp=>messages( existing_messages ).
  ENDMETHOD.

  METHOD remove_duplicates.
    CHECK messages IS NOT INITIAL.

    DATA(existing_messages) = messages->value.

    DATA new_messages TYPE REF TO if_xco_messages.
    LOOP AT existing_messages INTO DATA(existing_message).
      IF NOT NEW ycl_al_messages_factory( )->comparator->contains( messages = new_messages
                                                                   message  = existing_message ).

        new_messages = me->add_message( messages = new_messages
                                        message  = existing_message ).
      ENDIF.
    ENDLOOP.

    result = new_messages.
  ENDMETHOD.

  METHOD remove_message.
    CHECK messages IS NOT INITIAL.

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
