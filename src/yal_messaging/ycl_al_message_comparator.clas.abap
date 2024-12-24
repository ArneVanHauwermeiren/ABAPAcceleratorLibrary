"!" Class `ycl_al_message_comparator`
"!
"! This class provides methods to compare messages for equality.
"! It supports comparing individual messages and checking if one message exists within a collection.
CLASS ycl_al_message_comparator DEFINITION
  PUBLIC FINAL
  CREATE PRIVATE
  GLOBAL FRIENDS ycl_al_message_factory.

  PUBLIC SECTION.
    "! Compares two messages for equality.
    "!
    "! @parameter message1 | The first message to be compared.
    "! @parameter message2 | The second message to be compared.
    "! @parameter result | Boolean result indicating if the messages are equal.
    METHODS equals IMPORTING message1      TYPE REF TO if_xco_message
                             message2      TYPE REF TO if_xco_message
                   RETURNING VALUE(result) TYPE abap_boolean.
ENDCLASS.



CLASS ycl_al_message_comparator IMPLEMENTATION.
  METHOD equals.
    result = xsdbool( message1->value = message2->value ).
  ENDMETHOD.
ENDCLASS.
