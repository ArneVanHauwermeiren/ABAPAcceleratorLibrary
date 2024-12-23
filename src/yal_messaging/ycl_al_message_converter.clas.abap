CLASS ycl_al_message_converter DEFINITION
  PUBLIC FINAL
  CREATE PRIVATE
  GLOBAL FRIENDS ycl_al_message_factory.

  PUBLIC SECTION.
    METHODS bapiret2_to_symsg IMPORTING bapiret2      TYPE bapiret2
                              RETURNING VALUE(result) TYPE symsg.
ENDCLASS.


CLASS ycl_al_message_converter IMPLEMENTATION.
  METHOD bapiret2_to_symsg.
    result = VALUE #( msgid = bapiret2-id
                      msgty = bapiret2-type
                      msgno = bapiret2-number
                      msgv1 = bapiret2-message_v1
                      msgv2 = bapiret2-message_v2
                      msgv3 = bapiret2-message_v3
                      msgv4 = bapiret2-message_v4 ).
  ENDMETHOD.
ENDCLASS.
