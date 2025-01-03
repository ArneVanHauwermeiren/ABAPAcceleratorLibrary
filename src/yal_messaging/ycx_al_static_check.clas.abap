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
        constructor IMPORTING messages TYPE REF TO yif_al_messages.
PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ycx_al_static_check IMPLEMENTATION.
  METHOD constructor ##ADT_SUPPRESS_GENERATION.
    super->constructor( ).
    CLEAR me->textid.

    DATA(message_table) = messages->get_messages( ).
    DATA(last_message) = message_table[ lines( message_table ) ].

    if_t100_message~t100key = VALUE #( msgid = last_message->if_xco_message~value-msgid
                                       msgno = last_message->if_xco_message~value-msgno
                                       attr1 = 'V1'
                                       attr2 = 'V2'
                                       attr3 = 'V3'
                                       attr4 = 'V4' ).

    ty = last_message->if_xco_message~value-msgty.
    v1 = last_message->if_xco_message~value-msgv1.
    v2 = last_message->if_xco_message~value-msgv2.
    v3 = last_message->if_xco_message~value-msgv3.
    v4 = last_message->if_xco_message~value-msgv4.
    me->messages = messages.
  ENDMETHOD.
ENDCLASS.
