CLASS ycl_al_message_factory DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    CLASS-DATA factory TYPE REF TO ycl_al_message_factory.

    METHODS create_from_bapiret2 IMPORTING bapiret2      TYPE bapiret2
                                 RETURNING VALUE(result) TYPE REF TO ycl_al_message.

    METHODS create_from_variables IMPORTING !id           TYPE symsgid
                                            !nr           TYPE symsgno
                                            ty            TYPE symsgty
                                            v1            TYPE any OPTIONAL
                                            v2            TYPE any OPTIONAL
                                            v3            TYPE any OPTIONAL
                                            v4            TYPE any OPTIONAL
                                  RETURNING VALUE(result) TYPE REF TO ycl_al_message.

ENDCLASS.

CLASS ycl_al_message_factory IMPLEMENTATION.


  METHOD create_from_bapiret2.
    result = NEW ycl_al_message( bapiret2 ).
  ENDMETHOD.

  METHOD create_from_variables.
    result = create_from_bapiret2( VALUE #( id         = id
                                            number     = nr
                                            type       = ty
                                            message_v1 = v1
                                            message_v2 = v2
                                            message_v3 = v3
                                            message_v4 = v4 ) ).
  ENDMETHOD.
ENDCLASS.
