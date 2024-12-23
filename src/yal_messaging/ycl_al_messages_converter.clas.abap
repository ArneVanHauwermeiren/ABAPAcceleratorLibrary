CLASS ycl_al_messages_converter DEFINITION
  PUBLIC FINAL
  CREATE PRIVATE
  GLOBAL FRIENDS ycl_al_messages_factory.

  PUBLIC SECTION.
    METHODS bapirettab_to_sxco_t_messages IMPORTING bapirettab    TYPE bapirettab
                                          RETURNING VALUE(result) TYPE sxco_t_messages.
ENDCLASS.


CLASS ycl_al_messages_converter IMPLEMENTATION.
  METHOD bapirettab_to_sxco_t_messages.
    LOOP AT bapirettab INTO DATA(bapiret2).
      APPEND xco_cp=>message( NEW ycl_al_message_factory( )->converter->bapiret2_to_symsg( bapiret2 ) ) TO result.
    ENDLOOP.
  ENDMETHOD.
ENDCLASS.
