"!" Class `ycl_al_messages_factory`
"!
"! This factory class is responsible for creating and managing collections of messages.
"! It initializes utilities for validation, comparison, conversion, and modification of message collections.
CLASS ycl_al_messages_factory DEFINITION
  PUBLIC FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.
    "! Validator for validating collections of messages.
    DATA validator  TYPE REF TO ycl_al_messages_validator  READ-ONLY.

    "! Comparator for comparing collections of messages.
    DATA comparator TYPE REF TO ycl_al_messages_comparator READ-ONLY.

    "! Converter for converting message collections.
    DATA converter  TYPE REF TO ycl_al_messages_converter  READ-ONLY.

    "! Modifier for modifying collections of messages.
    DATA modifier   TYPE REF TO ycl_al_messages_modifier   READ-ONLY.

    "! Constructor for initializing dependencies.
    "! Instantiates the `validator`, `comparator`, `converter`, and `modifier` components.
    METHODS constructor.

    "! Creates a collection of messages from a table of message structures.
    "!
    "! @parameter sxco_t_messages | The table of message structures to convert into a collection.
    "! @parameter result | The created collection of messages.
    METHODS create IMPORTING sxco_t_messages TYPE sxco_t_messages
                   RETURNING VALUE(result)   TYPE REF TO if_xco_messages.
ENDCLASS.



CLASS ycl_al_messages_factory IMPLEMENTATION.
  METHOD constructor.
    validator = NEW ycl_al_messages_validator( ).
    comparator = NEW ycl_al_messages_comparator( ).
    converter = NEW ycl_al_messages_converter( ).
    modifier = NEW ycl_al_messages_modifier( ).
  ENDMETHOD.

  METHOD create.
    CHECK sxco_t_messages IS NOT INITIAL.
    result = xco_cp=>messages( sxco_t_messages ).
  ENDMETHOD.
ENDCLASS.
