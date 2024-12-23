CLASS ycl_al_message_comparator DEFINITION
  PUBLIC FINAL
  CREATE PRIVATE
  GLOBAL FRIENDS ycl_al_message_factory.

  PUBLIC SECTION.
    METHODS equals IMPORTING message1      TYPE REF TO if_xco_message
                             message2      TYPE REF TO if_xco_message
                   RETURNING VALUE(result) TYPE abap_boolean.
ENDCLASS.


CLASS ycl_al_message_comparator IMPLEMENTATION.
  METHOD equals.
    result = xsdbool( message1->value = message2->value ).
  ENDMETHOD.
ENDCLASS.
