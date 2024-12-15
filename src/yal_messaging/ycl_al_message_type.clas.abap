CLASS ycl_al_message_type DEFINITION
  PUBLIC
  ABSTRACT FINAL.

  PUBLIC SECTION.
    TYPES: BEGIN OF ENUM type BASE TYPE symsgty,
             success   VALUE 'S',
             warning   VALUE 'W',
             error     VALUE 'E',
             abort     VALUE 'A',
             undefined VALUE IS INITIAL,
           END OF ENUM type.
ENDCLASS.

CLASS ycl_al_message_type IMPLEMENTATION.

ENDCLASS.
