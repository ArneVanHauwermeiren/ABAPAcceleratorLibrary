CLASS ycl_al_messages_factory DEFINITION
  PUBLIC FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.
    DATA validator  TYPE REF TO ycl_al_messages_validator  READ-ONLY.
    DATA comparator TYPE REF TO ycl_al_messages_comparator READ-ONLY.
    DATA converter  TYPE REF TO ycl_al_messages_converter  READ-ONLY.
    DATA modifier   TYPE REF TO ycl_al_messages_modifier   READ-ONLY.

    METHODS constructor.

    METHODS create IMPORTING sxco_t_messages TYPE sxco_t_messages
                   RETURNING VALUE(result)   TYPE REF TO if_xco_messages.
ENDCLASS.


CLASS ycl_al_messages_factory IMPLEMENTATION.
  METHOD constructor.
    validator = NEW ycl_al_messages_validator( ).
    comparator = NEW ycl_al_messages_comparator( ).
    converter = NEW ycl_al_messages_converter( ).
    modifier = NEW ycl_al_messages_modifier( ).
  ENDMETHOD.

  METHOD create.
    result = xco_cp=>messages( sxco_t_messages ).
  ENDMETHOD.
ENDCLASS.
