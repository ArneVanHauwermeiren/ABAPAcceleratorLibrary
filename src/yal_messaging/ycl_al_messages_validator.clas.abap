CLASS ycl_al_messages_validator DEFINITION
  PUBLIC FINAL
  CREATE PRIVATE
  GLOBAL FRIENDS ycl_al_messages_factory.

  PUBLIC SECTION.
    METHODS has_errors IMPORTING !messages     TYPE REF TO if_xco_messages
                       RETURNING VALUE(result) TYPE abap_boolean.

    METHODS has_warnings IMPORTING !messages     TYPE REF TO if_xco_messages
                         RETURNING VALUE(result) TYPE abap_boolean.

    METHODS has_informations IMPORTING !messages     TYPE REF TO if_xco_messages
                             RETURNING VALUE(result) TYPE abap_boolean.

    METHODS has_successes IMPORTING !messages     TYPE REF TO if_xco_messages
                          RETURNING VALUE(result) TYPE abap_boolean.

    METHODS get_messages_of_type IMPORTING !messages     TYPE REF TO if_xco_messages
                                           !type         TYPE REF TO cl_xco_message_type
                                 RETURNING VALUE(result) TYPE REF TO if_xco_messages.
ENDCLASS.


CLASS ycl_al_messages_validator IMPLEMENTATION.
  METHOD has_errors.
    CHECK messages IS NOT INITIAL.

    LOOP AT messages->value INTO DATA(message).
      result = NEW ycl_al_message_factory( )->validator->is_error( message ).
      IF result = abap_true.
        RETURN.
      ENDIF.
    ENDLOOP.
  ENDMETHOD.

  METHOD has_informations.
    CHECK messages IS NOT INITIAL.

    LOOP AT messages->value INTO DATA(message).
      result = NEW ycl_al_message_factory( )->validator->is_information( message ).
      IF result = abap_true.
        RETURN.
      ENDIF.
    ENDLOOP.
  ENDMETHOD.

  METHOD has_successes.
    CHECK messages IS NOT INITIAL.

    LOOP AT messages->value INTO DATA(message).
      result = NEW ycl_al_message_factory( )->validator->is_success( message ).
      IF result = abap_true.
        RETURN.
      ENDIF.
    ENDLOOP.
  ENDMETHOD.

  METHOD has_warnings.
    CHECK messages IS NOT INITIAL.

    LOOP AT messages->value INTO DATA(message).
      result = NEW ycl_al_message_factory( )->validator->is_warning( message ).
      IF result = abap_true.
        RETURN.
      ENDIF.
    ENDLOOP.
  ENDMETHOD.

  METHOD get_messages_of_type.
    CHECK messages IS NOT INITIAL.

    DATA new_messages TYPE sxco_t_messages.
    LOOP AT messages->value INTO DATA(message).
      IF message->get_type( ) = type.
        APPEND message TO new_messages.
      ENDIF.
    ENDLOOP.

    result = xco_cp=>messages( new_messages ).
  ENDMETHOD.
ENDCLASS.
