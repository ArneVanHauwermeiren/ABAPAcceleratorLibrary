"!" Interface `yif_al_messages`
"!
"! This interface defines the structure and methods for interacting with collections of messages.
"! It extends `if_xco_messages` and `if_xco_news` to provide operations for managing and querying message collections.
"! It serves as the contract for any message collection class, allowing for message manipulation, retrieval, type checking, and comparison.
INTERFACE yif_al_messages
  PUBLIC.


  INTERFACES if_xco_messages.
  INTERFACES if_xco_news.

  TYPES: BEGIN OF types,
           messages TYPE STANDARD TABLE OF REF TO yif_al_message WITH EMPTY KEY,
         END OF types.

  "! Retrieves the collection of messages.
  "!
  "! @parameter result | The collection of messages.
  METHODS get_messages RETURNING VALUE(result) TYPE types-messages.

  "! Retrieves a collection of messages of a specified type.
  "!
  "! @parameter type    | The type of message to filter.
  "! @parameter result  | The collection of messages of the specified type.
  METHODS get_messages_of_type
    IMPORTING !type         TYPE REF TO cl_xco_message_type
    RETURNING VALUE(result) TYPE REF TO yif_al_messages.

  "! Adds a message to the collection.
  "!
  "! @parameter message | The message to add to the collection.
  METHODS add_message     IMPORTING !message      TYPE REF TO yif_al_message.

  "! Removes a message from the collection.
  "!
  "! @parameter message | The message to remove from the collection.
  METHODS remove_message  IMPORTING !message      TYPE REF TO yif_al_message.

  "! Removes duplicate messages from the collection.
  METHODS remove_duplicates.

  "! Checks if any message in the collection is an error.
  "!
  "! @parameter result | `abap_true` if any message is an error, `abap_false` otherwise.
  METHODS has_error       RETURNING VALUE(result) TYPE abap_boolean.

  "! Checks if any message in the collection is a warning.
  "!
  "! @parameter result | `abap_true` if any message is a warning, `abap_false` otherwise.
  METHODS has_warning     RETURNING VALUE(result) TYPE abap_boolean.

  "! Checks if any message in the collection indicates success.
  "!
  "! @parameter result | `abap_true` if any message indicates success, `abap_false` otherwise.
  METHODS has_success     RETURNING VALUE(result) TYPE abap_boolean.

  "! Checks if any message in the collection is informational.
  "!
  "! @parameter result | `abap_true` if any message is informational, `abap_false` otherwise.
  METHODS has_information RETURNING VALUE(result) TYPE abap_boolean.

  "! Checks if any message in the collection matches the specified type.
  "!
  "! @parameter type    | The type of message to check for.
  "! @parameter result  | `abap_true` if any message matches the specified type, `abap_false` otherwise.
  METHODS has_type IMPORTING !type         TYPE REF TO cl_xco_message_type
                   RETURNING VALUE(result) TYPE abap_boolean.

  "! Compares the current collection of messages with another collection.
  "!
  "! @parameter messages | The collection of messages to compare against.
  "! @parameter result   | `abap_true` if the collections are equal, `abap_false` otherwise.
  METHODS equals IMPORTING !messages     TYPE REF TO yif_al_messages
                 RETURNING VALUE(result) TYPE abap_boolean.

  "! Checks if a specific message is contained within the collection.
  "!
  "! @parameter message | The message to check for in the collection.
  "! @parameter result  | `abap_true` if the message is found in the collection, `abap_false` otherwise.
  METHODS contains IMPORTING !message      TYPE REF TO yif_al_message
                   RETURNING VALUE(result) TYPE abap_boolean.

ENDINTERFACE.
