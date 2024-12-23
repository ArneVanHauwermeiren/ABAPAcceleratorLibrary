CLASS ycl_al_message_validator DEFINITION
  PUBLIC
  FINAL
  CREATE PRIVATE
  GLOBAL FRIENDS ycl_al_message_factory .

  PUBLIC SECTION.
    METHODS is_error IMPORTING !message      TYPE REF TO if_xco_message
                     RETURNING VALUE(result) TYPE abap_boolean.

    METHODS is_warning IMPORTING !message      TYPE REF TO if_xco_message
                       RETURNING VALUE(result) TYPE abap_boolean.

    METHODS is_success IMPORTING !message      TYPE REF TO if_xco_message
                       RETURNING VALUE(result) TYPE abap_boolean.

    METHODS is_information IMPORTING !message      TYPE REF TO if_xco_message
                           RETURNING VALUE(result) TYPE abap_boolean.

    METHODS is_type IMPORTING !message TYPE REF TO if_xco_message
                              !type TYPE REF TO cl_xco_message_type
                    RETURNING VALUE(result) TYPE abap_boolean.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ycl_al_message_validator IMPLEMENTATION.
  METHOD is_error.
    result = xsdbool( message->get_type( ) = xco_cp_message=>type->error ).
  ENDMETHOD.

  METHOD is_information.
    result = xsdbool( message->get_type( ) = xco_cp_message=>type->information ).
  ENDMETHOD.

  METHOD is_success.
    result = xsdbool( message->get_type( ) = xco_cp_message=>type->success ).
  ENDMETHOD.

  METHOD is_warning.
    result = xsdbool( message->get_type( ) = xco_cp_message=>type->warning ).
  ENDMETHOD.

  METHOD is_type.
    result = xsdbool( message->get_type( ) = type ).
  ENDMETHOD.

ENDCLASS.
