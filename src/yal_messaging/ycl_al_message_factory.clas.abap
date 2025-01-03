"!" Class `ycl_al_message_factory`
"!
"! This class is responsible for creating message objects based on various input structures.
"! This ensures a standardized way to handle message creation.
CLASS ycl_al_message_factory DEFINITION
  PUBLIC FINAL
  CREATE PUBLIC.


  PUBLIC SECTION.

    "! Factory method to create a message object from the provided `if_xco_message` instance.
    "!
    "! @parameter xco_message | The `if_xco_message` instance representing a message.
    "! @parameter result | The created message object as a `yif_al_message` instance.
    METHODS create_from_xco_message IMPORTING xco_message TYPE REF TO if_xco_message
                                    RETURNING VALUE(result) TYPE REF TO yif_al_message.

    "! Factory method to create a message object from the given `symsg` structure.
    "!
    "! @parameter symsg | The SAP standard message structure (SYMSG) used to create the message.
    "! @parameter result | The created message object as a `yif_al_message` instance.
    METHODS create_from_symsg IMPORTING symsg         TYPE symsg
                              RETURNING VALUE(result) TYPE REF TO yif_al_message.

    "! Factory method to create a message object from the given `bapiret2` structure.
    "!
    "! @parameter bapiret2 | The SAP standard structure (BAPIRET2) representing a message.
    "! @parameter result | The created message object as a `yif_al_message` instance.
    METHODS create_from_bapiret2 IMPORTING bapiret2 TYPE bapiret2
                                 RETURNING VALUE(result) TYPE REF TO yif_al_message.

ENDCLASS.

CLASS ycl_al_message_factory IMPLEMENTATION.
    METHOD create_from_xco_message.
    result = new ycl_al_message( xco_message ).
  ENDMETHOD.

  METHOD create_from_symsg.
    result = create_from_xco_message( xco_cp=>message( symsg ) ).
  ENDMETHOD.

  METHOD create_from_bapiret2.
    result = create_from_symsg( VALUE #( msgid = bapiret2-id
                                         msgty = bapiret2-type
                                         msgno = bapiret2-number
                                         msgv1 = bapiret2-message_v1
                                         msgv2 = bapiret2-message_v2
                                         msgv3 = bapiret2-message_v3
                                         msgv4 = bapiret2-message_v4 ) ).
  ENDMETHOD.
ENDCLASS.
