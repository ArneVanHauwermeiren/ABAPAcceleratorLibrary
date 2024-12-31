"!" Class `ycl_al_messages`
"!
"! This class provides a collection of messages and operations for managing and analyzing them.
"! It implements the `yif_al_messages` interface to expose methods for handling messages.
CLASS ycl_al_messages DEFINITION
  PUBLIC FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.

    INTERFACES yif_al_messages.
    ALIASES types FOR yif_al_messages~types.
    ALIASES get_messages FOR yif_al_messages~get_messages.

    "! Constructor to initialize the message collection
    "!
    "! @parameter xco_messages | An object containing an initial set of messages (`if_xco_messages`).
    METHODS constructor IMPORTING xco_messages TYPE REF TO if_xco_messages.

  PRIVATE SECTION.

    "! Internal storage for the message collection
    DATA value TYPE yif_al_messages~types-messages.

ENDCLASS.



CLASS ycl_al_messages IMPLEMENTATION.
  METHOD constructor.
    DATA(message_factory) = NEW ycl_al_message_factory( ).
    LOOP AT xco_messages->value INTO DATA(xco_message).
      APPEND MESSAGE_FACTORY->CREATE_FROM_XCO_MESSAGE( XCO_MESSAGE ) TO VALUE.
    ENDLOOP.
  ENDMETHOD.

  METHOD yif_al_messages~get_messages.
    RESULT = VALUE.
  ENDMETHOD.

  METHOD yif_al_messages~add_message.
    APPEND MESSAGE TO VALUE.
    IF_XCO_MESSAGES~VALUE = GET_MESSAGES( ).
  ENDMETHOD.

  METHOD yif_al_messages~remove_duplicates.
    CHECK lines( get_messages( ) ) > 1.

    DATA new_messages TYPE REF TO yif_al_messages.
    LOOP AT get_messages( ) INTO DATA(existing_message).
      IF NOT new_messages->contains( existing_message ).
        new_messages->add_message( existing_message ).
      ENDIF.
    ENDLOOP.

    IF_XCO_MESSAGES~VALUE = GET_MESSAGES( ).
  ENDMETHOD.

  METHOD yif_al_messages~remove_message.
    CHECK IF_XCO_MESSAGES~VALUE IS NOT INITIAL.

    DATA(existing_messages) = get_messages( ).

    DATA new_messages LIKE existing_messages.
    LOOP AT existing_messages INTO DATA(existing_message).
      IF NOT message->equals( existing_message ).
        APPEND existing_message TO new_messages.
      ENDIF.
    ENDLOOP.

    VALUE = NEW_MESSAGES.    IF_XCO_MESSAGES~VALUE = VALUE.
  ENDMETHOD.

  METHOD yif_al_messages~contains.
    CHECK get_messages( ) IS NOT INITIAL.

    LOOP AT get_messages( ) INTO DATA(existing_message).
      IF existing_message->equals( message ).
        result = abap_true.
        RETURN.
      ENDIF.
    ENDLOOP.
  ENDMETHOD.

  METHOD if_xco_news~get_messages.
    rt_messages = get_messages( ).
  ENDMETHOD.

  METHOD yif_al_messages~has_error.
    LOOP AT get_messages( ) INTO DATA(message).
      result = message->is_error( ).
      IF result = abap_true.
        RETURN.
      ENDIF.
    ENDLOOP.
  ENDMETHOD.

  METHOD yif_al_messages~has_information.
    LOOP AT get_messages( ) INTO DATA(message).
      result = message->is_information( ).
      IF result = abap_true.
        RETURN.
      ENDIF.
    ENDLOOP.
  ENDMETHOD.

  METHOD yif_al_messages~has_success.
    LOOP AT get_messages( ) INTO DATA(message).
      result = message->is_success( ).
      IF result = abap_true.
        RETURN.
      ENDIF.
    ENDLOOP.
  ENDMETHOD.

  METHOD yif_al_messages~has_type.
    LOOP AT get_messages( ) INTO DATA(message).
      result = message->is_type( type ).
      IF result = abap_true.
        RETURN.
      ENDIF.
    ENDLOOP.
  ENDMETHOD.

  METHOD yif_al_messages~has_warning.
    LOOP AT get_messages( ) INTO DATA(message).
      result = message->is_warning( ).
      IF result = abap_true.
        RETURN.
      ENDIF.
    ENDLOOP.
  ENDMETHOD.

  METHOD yif_al_messages~equals.
    DATA(current_messages) = get_messages( ).
    SORT current_messages.
    DATA(compared_messages) = messages->get_messages( ).
    SORT compared_messages.

    LOOP AT current_messages INTO DATA(current_message).
        IF NOT current_message->equals( compared_messages[ sy-tabix ] ).
            result = abap_false.
            RETURN.
        ENDIF.
    ENDLOOP.

    result = abap_true.
  ENDMETHOD.

  METHOD yif_al_messages~get_messages_of_type.
    DATA new_messages TYPE types-messages.
    LOOP AT get_messages( ) INTO DATA(message).
        IF message->is_type( type ).
            APPEND message TO new_messages.
        ENDIF.
    ENDLOOP.

    result = new ycl_al_messages_factory( )->create_from_sxco_t_messages( new_messages ).
  ENDMETHOD.

ENDCLASS.
