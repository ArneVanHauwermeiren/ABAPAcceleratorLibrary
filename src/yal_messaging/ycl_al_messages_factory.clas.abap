"!" Class `ycl_al_messages_factory`
"!
"! This factory class is responsible for creating collections of messages.
"! It provides methods to create collections from various input structures such as `if_xco_messages`, `sxco_t_messages`, and `bapirettab`.
"! The class ensures a standardized way to handle message collection creation, allowing for flexible message processing.
CLASS ycl_al_messages_factory DEFINITION
  PUBLIC FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.
    "! Creates a collection of messages from an `if_xco_messages` instance.
    "!
    "! @parameter xco_messages | The `if_xco_messages` instance containing the initial set of messages.
    "! @parameter result       | The created collection of messages as a `yif_al_messages` instance.
    METHODS create_from_xco_messages IMPORTING xco_messages  TYPE REF TO if_xco_messages
                                     RETURNING VALUE(result) TYPE REF TO yif_al_messages.

    "! Creates a collection of messages from a table of message structures (`sxco_t_messages`).
    "!
    "! @parameter sxco_t_messages | The table of message structures to convert into a message collection.
    "! @parameter result          | The created collection of messages as a `yif_al_messages` instance.
    METHODS create_from_sxco_t_messages IMPORTING sxco_t_messages TYPE sxco_t_messages
                                        RETURNING VALUE(result)   TYPE REF TO yif_al_messages.

    "! Creates a collection of messages from a `bapirettab` structure.
    "!
    "! @parameter bapirettab | The table of BAPI return structures to be converted into a collection of messages.
    "! @parameter result     | The created collection of messages as a `yif_al_messages` instance.
    METHODS create_from_bapirettab IMPORTING bapirettab    TYPE bapirettab
                                   RETURNING VALUE(result) TYPE REF TO yif_al_messages.

ENDCLASS.


CLASS ycl_al_messages_factory IMPLEMENTATION.
  METHOD create_from_xco_messages.
    result = NEW ycl_al_messages( xco_messages ).
  ENDMETHOD.

  METHOD create_from_sxco_t_messages.
    CHECK sxco_t_messages IS NOT INITIAL.
    result = create_from_xco_messages( xco_cp=>messages( sxco_t_messages ) ).
  ENDMETHOD.

  METHOD create_from_bapirettab.
    CHECK bapirettab IS NOT INITIAL.
    DATA(message_factory) = NEW ycl_al_message_factory( ).

    DATA sxco_t_messages TYPE sxco_t_messages.
    LOOP AT bapirettab INTO DATA(bapiret2).
      APPEND message_factory->create_from_bapiret2( bapiret2 ) TO sxco_t_messages.
    ENDLOOP.

    result = create_from_sxco_t_messages( sxco_t_messages ).
  ENDMETHOD.
ENDCLASS.
