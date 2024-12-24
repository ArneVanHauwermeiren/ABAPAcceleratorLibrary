"!" Class `ycl_al_messages_comparator`
"!
"! This class provides methods to compare collections of messages.
"! It supports checking for equality and determining if a message is contained within a collection.
CLASS ycl_al_messages_comparator DEFINITION
  PUBLIC FINAL
  CREATE PRIVATE
  GLOBAL FRIENDS ycl_al_messages_factory.

  PUBLIC SECTION.
    "! Compares two collections of messages for equality.
    "!
    "! @parameter messages1 | The first collection to be compared.
    "! @parameter messages2 | The second collection to be compared.
    "! @parameter result | Boolean result indicating if the collections are equal.
    METHODS equals IMPORTING messages1     TYPE REF TO if_xco_messages
                             messages2     TYPE REF TO if_xco_messages
                   RETURNING VALUE(result) TYPE abap_boolean.

    "! Checks if a message is contained within a collection.
    "!
    "! @parameter messages | The collection to search.
    "! @parameter message | The message to look for in the collection.
    "! @parameter result | Boolean result indicating if the message is contained in the collection.
    METHODS contains IMPORTING !messages     TYPE REF TO if_xco_messages
                               !message      TYPE REF TO if_xco_message
                     RETURNING VALUE(result) TYPE abap_boolean.
ENDCLASS.



CLASS ycl_al_messages_comparator IMPLEMENTATION.
  METHOD equals.
    IF messages1 IS INITIAL AND messages2 IS INITIAL.
        result = abap_true.
        RETURN.
    ENDIF.

    IF ( messages1 IS INITIAL AND messages2 IS NOT INITIAL )
    OR ( messages2 IS NOT INITIAL AND messages2 IS INITIAL ).
        RETURN.
    ENDIF.

    DATA(messages1_values) = messages1->value.
    SORT messages1_values.

    DATA(messages2_values) = messages2->value.
    SORT messages2_values.

    result = abap_true.
    LOOP AT messages1_values INTO DATA(message1).
      DATA(message2) = messages2_values[ sy-tabix ].
      result = NEW ycl_al_message_factory( )->comparator->equals( message1 = message1
                                                                  message2 = message2 ).
      IF result = abap_false.
        RETURN.
      ENDIF.
    ENDLOOP.
  ENDMETHOD.

  METHOD contains.
    CHECK messages IS NOT INITIAL.

    LOOP AT messages->value INTO DATA(existing_message).
      IF NEW ycl_al_message_factory( )->comparator->equals( message1 = existing_message
                                                            message2 = message ).
        result = abap_true.
        RETURN.
      ENDIF.
    ENDLOOP.
  ENDMETHOD.
ENDCLASS.
