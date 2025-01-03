CLASS ycl_al_rap_message_definition DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.
    TYPES: BEGIN OF ENUM message_number BASE TYPE symsgno,
             "! Error message for missing mandatory fields of a RAP-object
             mandatory_field VALUE '001',
             "! An undefined error message with a generic text
             undefined       VALUE IS INITIAL,
           END OF ENUM message_number.

    "! Constant representing the message class for RAP related messages
    CONSTANTS message_class TYPE symsgid VALUE 'YCM_AL_RAP'.

ENDCLASS.





CLASS ycl_al_rap_message_definition IMPLEMENTATION.
ENDCLASS.
