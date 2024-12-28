"!" Interface `yif_al_message`
"!
"! This interface defines the structure and methods for interacting with message objects.
"! It extends `if_xco_message` and `if_xco_news` to provide message-specific operations, including validation, type checking, and comparison.
"! It serves as the contract for any message class, exposing essential methods for checking message types and comparing messages.
INTERFACE yif_al_message
  PUBLIC.

  INTERFACES if_xco_message.
  INTERFACES if_xco_news.

  ALIASES get_type FOR if_xco_message~get_type.
  ALIASES get_text FOR if_xco_message~get_text.

  "! Determines if the message represents an error.
  "!
  "! @parameter result | `abap_true` if the message is an error, `abap_false` otherwise.
  METHODS is_error RETURNING VALUE(result) TYPE abap_boolean.

  "! Determines if the message represents a warning.
  "!
  "! @parameter result | `abap_true` if the message is a warning, `abap_false` otherwise.
  METHODS is_warning RETURNING VALUE(result) TYPE abap_boolean.

  "! Determines if the message represents a success.
  "!
  "! @parameter result | `abap_true` if the message is a success, `abap_false` otherwise.
  METHODS is_success RETURNING VALUE(result) TYPE abap_boolean.

  "! Determines if the message represents an informational message.
  "!
  "! @parameter result | `abap_true` if the message is informational, `abap_false` otherwise.
  METHODS is_information RETURNING VALUE(result) TYPE abap_boolean.

  "! Determines if the message is of a specified type.
  "!
  "! @parameter type | The type of message to check against (`cl_xco_message_type`).
  "! @parameter result | `abap_true` if the message matches the specified type, `abap_false` otherwise.
  METHODS is_type IMPORTING type TYPE REF TO cl_xco_message_type
                  RETURNING VALUE(result) TYPE abap_boolean.

  "! Compares the current message with another message to determine equality.
  "!
  "! @parameter message | The message to compare against.
  "! @parameter result  | `abap_true` if the messages are equal, `abap_false` otherwise.
  METHODS equals IMPORTING message TYPE REF TO yif_al_message
                 RETURNING VALUE(result) TYPE abap_boolean.

ENDINTERFACE.
