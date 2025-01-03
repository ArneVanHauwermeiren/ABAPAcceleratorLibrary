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
        IF_XCO_MESSAGE~VALUE = XCO_MESSAGE->VALUE.
    ENDMETHOD.

    METHOD yif_al_message~equals.
        RESULT = XSDBOOL( IF_XCO_MESSAGE~VALUE = MESSAGE->IF_XCO_MESSAGE~VALUE ).
    ENDMETHOD.

  METHOD if_xco_news~get_messages.
    RT_MESSAGES = XCO_MESSAGE->IF_XCO_NEWS~GET_MESSAGES( ).
  ENDMETHOD.

  METHOD if_xco_message~get_short_text.
    RO_SHORT_TEXT = XCO_MESSAGE->GET_SHORT_TEXT( ).
  ENDMETHOD.

  METHOD if_xco_message~get_text.
    RV_TEXT = XCO_MESSAGE->GET_TEXT( ).
  ENDMETHOD.

  METHOD if_xco_message~get_type.
    RO_TYPE = XCO_MESSAGE->GET_TYPE( ).
  ENDMETHOD.

  METHOD if_xco_message~overwrite.
    RO_MESSAGE = XCO_MESSAGE->OVERWRITE( IV_MSGTY = IV_MSGTY IV_MSGID = IV_MSGID IV_MSGNO = IV_MSGNO IV_MSGV1 = IV_MSGV1 IV_MSGV2 = IV_MSGV2 IV_MSGV3 = IV_MSGV3 IV_MSGV4 = IV_MSGV4 ).
    IF_XCO_MESSAGE~VALUE = XCO_MESSAGE->VALUE.
  ENDMETHOD.

  METHOD if_xco_message~place_string.
    RO_MESSAGE = XCO_MESSAGE->PLACE_STRING( IV_STRING = IV_STRING IV_MSGV1 = IV_MSGV1 IV_MSGV2 = IV_MSGV2 IV_MSGV3 = IV_MSGV3 IV_MSGV4 = IV_MSGV4 ).
    IF_XCO_MESSAGE~VALUE = XCO_MESSAGE->VALUE.
  ENDMETHOD.

  METHOD if_xco_message~write_to_t100_dyn_msg.
    XCO_MESSAGE->WRITE_TO_T100_DYN_MSG( IO_T100_DYN_MSG ).
    IF_XCO_MESSAGE~VALUE = XCO_MESSAGE->VALUE.
  ENDMETHOD.

  METHOD yif_al_message~is_error.
    RESULT = XSDBOOL( IF_XCO_MESSAGE~VALUE-MSGTY = XCO_CP_MESSAGE=>TYPE->ERROR->VALUE ).
  ENDMETHOD.

  METHOD yif_al_message~is_information.
    RESULT = XSDBOOL( IF_XCO_MESSAGE~VALUE-MSGTY = XCO_CP_MESSAGE=>TYPE->INFORMATION->VALUE ).
  ENDMETHOD.

  METHOD yif_al_message~is_success.
    RESULT = XSDBOOL( IF_XCO_MESSAGE~VALUE-MSGTY = XCO_CP_MESSAGE=>TYPE->SUCCESS->VALUE ).
  ENDMETHOD.

  METHOD yif_al_message~is_type.
    RESULT = XSDBOOL( IF_XCO_MESSAGE~VALUE-MSGTY = TYPE->VALUE ).
  ENDMETHOD.

  METHOD yif_al_message~is_warning.
    RESULT = XSDBOOL( IF_XCO_MESSAGE~VALUE-MSGTY = XCO_CP_MESSAGE=>TYPE->WARNING->VALUE ).
  ENDMETHOD.

ENDCLASS.
