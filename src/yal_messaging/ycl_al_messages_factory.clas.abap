CLASS ycl_al_messages_factory DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    DATA validator TYPE REF TO ycl_al_messages_validator READ-ONLY.
    DATA comparator TYPE REF TO ycl_al_messages_comparator READ-ONLY.
    DATA converter TYPE REF TO ycl_al_messages_converter READ-ONLY.
    DATA modifier TYPE REF TO ycl_al_messages_modifier READ-ONLY.
    METHODS constructor.
    METHODS create IMPORTING sxco_t_messages TYPE sxco_t_messages
                   RETURNING VALUE(result) TYPE REF TO if_xco_messages.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ycl_al_messages_factory IMPLEMENTATION.
    METHOD constructor.
        me->validator = new ycl_al_messages_validator( ).
        me->comparator = new ycl_al_messages_comparator( ).
        me->converter = new ycl_al_messages_converter( ).
        me->modifier = new ycl_al_messages_modifier( ).
    ENDMETHOD.

    METHOD create.
        result = xco_cp=>messages( sxco_t_messages ).
    ENDMETHOD.
ENDCLASS.
