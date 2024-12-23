CLASS ycl_al_message_factory DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    DATA validator TYPE REF TO ycl_al_message_validator READ-ONLY.
    DATA comparator TYPE REF TO ycl_al_message_comparator READ-ONLY.
    DATA converter TYPE REF TO ycl_al_message_converter READ-ONLY.
    METHODS constructor.
    METHODS create IMPORTING symsg TYPE symsg
                   RETURNING VALUE(result) TYPE REF TO if_xco_message.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ycl_al_message_factory IMPLEMENTATION.
    METHOD constructor.
        me->validator = new ycl_al_message_validator( ).
        me->comparator = new ycl_al_message_comparator( ).
        me->converter = new ycl_al_message_converter( ).
    ENDMETHOD.

    METHOD create.
        result = xco_cp=>message( symsg ).
    ENDMETHOD.
ENDCLASS.
