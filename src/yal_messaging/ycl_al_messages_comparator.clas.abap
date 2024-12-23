CLASS ycl_al_messages_comparator DEFINITION
  PUBLIC
  FINAL
  CREATE PRIVATE
  GLOBAL FRIENDS ycl_al_messages_factory .

  PUBLIC SECTION.
    METHODS equals IMPORTING messages1 TYPE REF TO if_xco_messages
                             messages2 TYPE REF TO if_xco_messages
                   RETURNING VALUE(result) TYPE abap_boolean.
        METHODS contains IMPORTING !messages TYPE REF TO if_xco_messages
                               !message TYPE REF TO if_xco_message
                     RETURNING VALUE(result) TYPE abap_boolean.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ycl_al_messages_comparator IMPLEMENTATION.
  METHOD equals.
    DATA(messages1_values) = messages1->value.
    SORT messages1_values.

    DATA(messages2_values) = messages2->value.
    SORT messages2_values.

    result = abap_true.
    LOOP AT messages1_values INTO DATA(message1).
      DATA(message2) = messages2_values[ sy-tabix ].
      result = NEW ycl_al_message_comparator( )->equals( message1 = message1
                                                         message2 = message2 ).
      IF result = abap_false.
        RETURN.
      ENDIF.
    ENDLOOP.
  ENDMETHOD.

  METHOD contains.
    LOOP AT messages->value INTO DATA(existing_message).
      IF NEW ycl_al_message_comparator( )->equals( message1 = existing_message
                                                   message2 = message ).
        result = abap_true.
        RETURN.
      ENDIF.
    ENDLOOP.
  ENDMETHOD.
ENDCLASS.
