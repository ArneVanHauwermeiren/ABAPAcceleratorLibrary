"!" Class `ycl_al_message_factory`
"!
"! This class is responsible for creating message objects based on the provided `symsg` structure.
"! It acts as a factory, providing utilities to validate, compare, and convert messages.
CLASS ycl_al_message_factory DEFINITION
  PUBLIC FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.
    "! Validator for message validation
    DATA validator  TYPE REF TO ycl_al_message_validator  READ-ONLY.

    "! Comparator for comparing messages
    DATA comparator TYPE REF TO ycl_al_message_comparator READ-ONLY.

    "! Converter for message conversion
    DATA converter  TYPE REF TO ycl_al_message_converter  READ-ONLY.

    "! Constructor for initializing dependencies.
    "! Instantiates the `validator`, `comparator`, and `converter` objects.
    METHODS constructor.

    "! Factory method to create a message object from the given `symsg`.
    "!
    "! @parameter symsg | The message structure used to create the message object.
    "! @parameter result | The created message object.
    METHODS create IMPORTING symsg         TYPE symsg
                   RETURNING VALUE(result) TYPE REF TO if_xco_message.

ENDCLASS.

CLASS ycl_al_message_factory IMPLEMENTATION.
  METHOD constructor.
    validator = NEW ycl_al_message_validator( ).
    comparator = NEW ycl_al_message_comparator( ).
    converter = NEW ycl_al_message_converter( ).
  ENDMETHOD.

  METHOD create.
    result = xco_cp=>message( symsg ).
  ENDMETHOD.

ENDCLASS.

