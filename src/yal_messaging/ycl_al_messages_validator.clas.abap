"!" Class `ycl_al_messages_validator`
"!
"! This class provides validation utilities for collections of messages.
"! It includes methods to check for specific types of messages (errors, warnings, etc.) in a collection.
CLASS ycl_al_messages_validator DEFINITION
  PUBLIC FINAL
  CREATE PRIVATE
  GLOBAL FRIENDS ycl_al_messages_factory.

  PUBLIC SECTION.
    "! Checks if the collection contains error messages.
    "! @parameter messages | The collection of messages to be checked.
    "! @parameter result | Boolean result indicating if errors are present.
    METHODS has_errors IMPORTING !messages     TYPE REF TO if_xco_messages
                       RETURNING VALUE(result) TYPE abap_boolean.

    "! Checks if the collection contains warning messages.
    "! @parameter messages | The collection of messages to be checked.
    "! @parameter result | Boolean result indicating if warnings are present.
    METHODS has_warnings IMPORTING !messages     TYPE REF TO if_xco_messages
                         RETURNING VALUE(result) TYPE abap_boolean.

    "! Checks if the collection contains informational messages.
    "! @parameter messages | The collection of messages to be checked.
    "! @parameter result | Boolean result indicating if informational messages are present.
    METHODS has_informations IMPORTING !messages     TYPE REF TO if_xco_messages
                             RETURNING VALUE(result) TYPE abap_boolean.

    "! Checks if the collection contains success messages.
    "! @parameter messages | The collection of messages to be checked.
    "! @parameter result | Boolean result indicating if success messages are present.
    METHODS has_successes IMPORTING !messages     TYPE REF TO if_xco_messages
                          RETURNING VALUE(result) TYPE abap_boolean.

    "! Retrieves messages of a specific type from the collection.
    "! @parameter messages | The collection of messages to filter.
    "! @parameter type | The type of messages to retrieve.
    "! @parameter result | The filtered collection of messages.
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
