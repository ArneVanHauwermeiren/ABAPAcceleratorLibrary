CLASS ycx_al_static_check DEFINITION
  PUBLIC
  INHERITING FROM cx_static_check
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_t100_dyn_msg.
    INTERFACES if_t100_message.

    ALIASES ty FOR if_t100_dyn_msg~msgty.
    ALIASES v1 FOR if_t100_dyn_msg~msgv1.
    ALIASES v2 FOR if_t100_dyn_msg~msgv2.
    ALIASES v3 FOR if_t100_dyn_msg~msgv3.
    ALIASES v4 FOR if_t100_dyn_msg~msgv4.

    DATA messages TYPE bapirettab READ-ONLY.

    METHODS constructor IMPORTING textid    LIKE if_t100_message=>t100key OPTIONAL
                                  !previous LIKE previous                 OPTIONAL
                                  ty        TYPE symsgty                  DEFAULT 'E' ##TODO
                                  v1        TYPE any                      OPTIONAL
                                  v2        TYPE any                      OPTIONAL
                                  v3        TYPE any                      OPTIONAL
                                  v4        TYPE any                      OPTIONAL
                                  !messages TYPE bapirettab               OPTIONAL.

    METHODS get_as_bapiret2 RETURNING VALUE(result) TYPE bapiret2.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ycx_al_static_check IMPLEMENTATION.


  METHOD constructor ##ADT_SUPPRESS_GENERATION.
    CALL METHOD super->constructor
      EXPORTING
        previous = previous.
    CLEAR me->textid.

    IF textid IS INITIAL.
      if_t100_message~t100key = if_t100_message=>default_textid.
    ELSE.
      if_t100_message~t100key = textid.
    ENDIF.

    me->ty = ty.
    me->v1 = CONV #( v1 ).
    me->v2 = CONV #( v2 ).
    me->v3 = CONV #( v3 ).
    me->v4 = CONV #( v4 ).

    me->messages = messages.
    APPEND get_as_bapiret2( ) TO me->messages.
  ENDMETHOD.


  METHOD get_as_bapiret2.
    result = VALUE #( id         = if_t100_message~t100key-msgid
                      type       = ty
                      number     = if_t100_message~t100key-msgno
                      message_v1 = v1
                      message_v2 = v2
                      message_v3 = v3
                      message_v4 = v4 ).
  ENDMETHOD.
ENDCLASS.
