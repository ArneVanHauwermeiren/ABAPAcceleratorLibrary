CLASS ycl_al_message_factory DEFINITION
  PUBLIC FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.
    DATA validator  TYPE REF TO ycl_al_message_validator  READ-ONLY.
    DATA comparator TYPE REF TO ycl_al_message_comparator READ-ONLY.
    DATA converter  TYPE REF TO ycl_al_message_converter  READ-ONLY.

    METHODS constructor.

    METHODS create IMPORTING symsg         TYPE symsg
                   RETURNING VALUE(result) TYPE REF TO if_xco_message.
ENDCLASS.


CLASS ycl_al_message_factory IMPLEMENTATION.
  METHOD constructor.
    validator = NEW ycl_al_message_validator( ).
    comparator = NEW ycl_al_message_comparator( ).
    converter = NEW ycl_al_message_converter( ).
  ENDMETHOD.

  METHOD create.
    result = xco_cp=>message( symsg ).
  ENDMETHOD.
ENDCLASS.
