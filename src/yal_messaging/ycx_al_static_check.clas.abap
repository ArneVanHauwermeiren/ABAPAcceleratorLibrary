CLASS ycx_al_static_check DEFINITION
  PUBLIC
  INHERITING FROM cx_static_check
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_t100_dyn_msg .
    INTERFACES if_t100_message .

    ALIASES:
      ty FOR if_t100_dyn_msg~msgty,
      v1 FOR if_t100_dyn_msg~msgv1,
      v2 FOR if_t100_dyn_msg~msgv2,
      v3 FOR if_t100_dyn_msg~msgv3,
      v4 FOR if_t100_dyn_msg~msgv4.

    DATA:
        messages TYPE REF TO yif_al_messages READ-ONLY.

    METHODS:
        constructor IMPORTING textid   LIKE if_t100_message=>t100key OPTIONAL
                              previous LIKE previous OPTIONAL
                              ty type SYMSGTY DEFAULT xco_cp_message=>type->error->value
                              v1 type any optional
                              v2 type any optional
                              v3 type any optional
                              v4 type any optional
                              messages TYPE REF TO yif_al_messages OPTIONAL.
PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ycx_al_static_check IMPLEMENTATION.
  METHOD constructor ##ADT_SUPPRESS_GENERATION.
    super->constructor( previous = previous ).
    CLEAR me->textid.

    IF textid IS INITIAL.
      if_t100_message~t100key = if_t100_message=>default_textid.
    ELSE.
      if_t100_message~t100key = textid.
    ENDIF.

    me->ty       = ty.
    me->v1       = CONV #( v1 ).
    me->v2       = CONV #( v2 ).
    me->v3       = CONV #( v3 ).
    me->v4       = CONV #( v4 ).

    me->messages = messages.
    me->messages->add_message(
        NEW ycl_al_message_factory( )->create_from_bapiret2( VALUE #( id         = if_t100_message~t100key-msgid
                                                                      type       = ty
                                                                      number     = if_t100_message~t100key-msgno
                                                                      message_v1 = v1
                                                                      message_v2 = v2
                                                                      message_v3 = v3
                                                                      message_v4 = v4 ) ) ).
  ENDMETHOD.
ENDCLASS.
