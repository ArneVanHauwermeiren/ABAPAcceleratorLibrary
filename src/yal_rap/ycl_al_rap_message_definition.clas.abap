CLASS ycl_al_rap_message_definition DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    TYPES: BEGIN OF ENUM message_number BASE TYPE symsgno,
             mandatory_field VALUE '001',
             undefined       VALUE IS INITIAL,
           END OF ENUM message_number.

    CONSTANTS message_class TYPE symsgid VALUE 'ZCM_AL_RAP'.
ENDCLASS.



CLASS ycl_al_rap_message_definition IMPLEMENTATION.
ENDCLASS.
