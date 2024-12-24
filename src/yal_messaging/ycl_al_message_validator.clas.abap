"!" Class `ycl_al_message_validator`
"!
"! This class provides utilities for validating messages based on their type.
"! It includes methods to determine if a message is of a specific type, such as error, warning, success, or information.
CLASS ycl_al_message_validator DEFINITION
  PUBLIC FINAL
  CREATE PRIVATE
  GLOBAL FRIENDS ycl_al_message_factory.

  PUBLIC SECTION.
    "! Checks if the message is of type 'error'.
    "! @parameter message | The message to be validated.
    "! @parameter result | Boolean result indicating if the message is an error.
    METHODS is_error IMPORTING !message      TYPE REF TO if_xco_message
                     RETURNING VALUE(result) TYPE abap_boolean.

    "! Checks if the message is of type 'warning'.
    "! @parameter message | The message to be validated.
    "! @parameter result | Boolean result indicating if the message is a warning.
    METHODS is_warning IMPORTING !message      TYPE REF TO if_xco_message
                       RETURNING VALUE(result) TYPE abap_boolean.

    "! Checks if the message is of type 'success'.
    "! @parameter message | The message to be validated.
    "! @parameter result | Boolean result indicating if the message is a success.
    METHODS is_success IMPORTING !message      TYPE REF TO if_xco_message
                       RETURNING VALUE(result) TYPE abap_boolean.

    "! Checks if the message is of type 'information'.
    "! @parameter message | The message to be validated.
    "! @parameter result | Boolean result indicating if the message is informational.
    METHODS is_information IMPORTING !message      TYPE REF TO if_xco_message
                           RETURNING VALUE(result) TYPE abap_boolean.

    "! Checks if the message matches a specific type.
    "! @parameter message | The message to be validated.
    "! @parameter type | The type to compare the message against.
    "! @parameter result | Boolean result indicating if the message matches the given type.
    METHODS is_type IMPORTING !message      TYPE REF TO if_xco_message
                              !type         TYPE REF TO cl_xco_message_type
                    RETURNING VALUE(result) TYPE abap_boolean.
ENDCLASS.


CLASS ycl_al_message_validator IMPLEMENTATION.
  METHOD is_error.
    result = xsdbool( message->get_type( ) = xco_cp_message=>type->error ).
  ENDMETHOD.

  METHOD is_information.
    result = xsdbool( message->get_type( ) = xco_cp_message=>type->information ).
  ENDMETHOD.

  METHOD is_success.
    result = xsdbool( message->get_type( ) = xco_cp_message=>type->success ).
  ENDMETHOD.

  METHOD is_warning.
    result = xsdbool( message->get_type( ) = xco_cp_message=>type->warning ).
  ENDMETHOD.

  METHOD is_type.
    result = xsdbool( message->get_type( ) = type ).
  ENDMETHOD.
ENDCLASS.
