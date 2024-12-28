"!" Class `ycl_al_message`
"!
"! This class represents an individual message and provides methods to interact with its properties.
"! It implements the `yif_al_message` interface to expose message-related operations.
CLASS ycl_al_message DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.

    INTERFACES yif_al_message.

    "! Constructor to initialize the message object
    "!
    "! @parameter xco_message | An object representing the message (`if_xco_message`).
    METHODS constructor IMPORTING xco_message TYPE REF TO if_xco_message.

  PRIVATE SECTION.
    "! Internal storage for the message
    DATA xco_message TYPE REF TO if_xco_message.

ENDCLASS.




CLASS ycl_al_message IMPLEMENTATION.
    METHOD constructor.
        me->xco_message = xco_message.
        me->if_xco_message~value = xco_message->value.
    ENDMETHOD.

    METHOD yif_al_message~equals.
        result = xsdbool( me->if_xco_message~value = message->if_xco_message~value ).
    ENDMETHOD.

  METHOD if_xco_news~get_messages.
    rt_messages = me->xco_message->if_xco_news~get_messages( ).
  ENDMETHOD.

  METHOD if_xco_message~get_short_text.
    ro_short_text = me->xco_message->get_short_text( ).
  ENDMETHOD.

  METHOD if_xco_message~get_text.
    rv_text = me->xco_message->get_text( ).
  ENDMETHOD.

  METHOD if_xco_message~get_type.
    ro_type = me->xco_message->get_type( ).
  ENDMETHOD.

  METHOD if_xco_message~overwrite.
    ro_message = me->xco_message->overwrite( iv_msgty = iv_msgty
                                             iv_msgid = iv_msgid
                                             iv_msgno = iv_msgno
                                             iv_msgv1 = iv_msgv1
                                             iv_msgv2 = iv_msgv2
                                             iv_msgv3 = iv_msgv3
                                             iv_msgv4 = iv_msgv4 ).
    me->if_xco_message~value = xco_message->value.
  ENDMETHOD.

  METHOD if_xco_message~place_string.
    ro_message = me->xco_message->place_string( iv_string = iv_string
                                                iv_msgv1  = iv_msgv1
                                                iv_msgv2  = iv_msgv2
                                                iv_msgv3  = iv_msgv3
                                                iv_msgv4  = iv_msgv4 ).
    me->if_xco_message~value = xco_message->value.
  ENDMETHOD.

  METHOD if_xco_message~write_to_t100_dyn_msg.
    me->xco_message->write_to_t100_dyn_msg( io_t100_dyn_msg ).
    me->if_xco_message~value = xco_message->value.
  ENDMETHOD.

  METHOD yif_al_message~is_error.
    result = xsdbool( me->if_xco_message~value-msgty = xco_cp_message=>type->error->value ).
  ENDMETHOD.

  METHOD yif_al_message~is_information.
    result = xsdbool( me->if_xco_message~value-msgty = xco_cp_message=>type->information->value ).
  ENDMETHOD.

  METHOD yif_al_message~is_success.
    result = xsdbool( me->if_xco_message~value-msgty = xco_cp_message=>type->success->value ).
  ENDMETHOD.

  METHOD yif_al_message~is_type.
    result = xsdbool( me->if_xco_message~value-msgty = type->value ).
  ENDMETHOD.

  METHOD yif_al_message~is_warning.
    result = xsdbool( me->if_xco_message~value-msgty = xco_cp_message=>type->warning->value ).
  ENDMETHOD.

ENDCLASS.
