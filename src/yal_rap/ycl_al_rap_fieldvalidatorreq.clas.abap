"! This class handles validation of mandatory fields for a RAP entity.
"! It validates fields based on permission settings in the behaviour definition and generates appropriate
"! error messages for missing mandatory fields.
CLASS ycl_al_rap_fieldvalidatorreq DEFINITION
  PUBLIC
  FINAL
  INHERITING FROM cl_abap_behv
  CREATE PUBLIC.

  PUBLIC SECTION.

    "! The root entity name in the RAP behaviour definition
    DATA root_name   TYPE string READ-ONLY.

    "! The entity name for which validation is performed
    DATA entity_name TYPE string READ-ONLY.

    "! Constructor to initialize the class
    "!
    "! @parameter root_name   | The name of the root entity.
    "! @parameter entity_name | The name of the entity being validated.
    METHODS constructor
      IMPORTING
        root_name   TYPE string
        entity_name TYPE string.

    "! Validates the fields of the given entity against its permissions.
    "!
    "! @parameter cid      | Change ID for validation (optional).
    "! @parameter entity   | The entity to be validated.
    "! @parameter failed   | Table of failed validations (changed).
    "! @parameter reported | Table of reported error messages (changed).
    METHODS validate
      IMPORTING
        !cid      TYPE abp_behv_cid OPTIONAL
        !entity   TYPE any
      CHANGING
        !failed   TYPE STANDARD TABLE
        !reported TYPE STANDARD TABLE.

  PROTECTED SECTION.
  PRIVATE SECTION.

ENDCLASS.




CLASS ycl_al_rap_fieldvalidatorreq IMPLEMENTATION.
  METHOD constructor.
    super->constructor( ).
    me->root_name = root_name.
    me->entity_name = entity_name.
  ENDMETHOD.

  METHOD validate.
    DATA permission_request TYPE REF TO data.

    DATA(permission_request_type_name) = |\\BDEF={ root_name }\\ENTITY={ entity_name }\\TYPE=PERM_Q|.
    CREATE DATA permission_request TYPE (permission_request_type_name).

    DATA(permission_request_descr) = CAST cl_abap_structdescr( cl_abap_typedescr=>describe_by_data_ref(
                                                                   permission_request ) ).
    DATA(permission_request_field_descr) = CAST cl_abap_structdescr( permission_request_descr->get_component_type(
                                                                         '%FIELD' ) ).
    DATA(permission_request_fields) = permission_request_field_descr->get_components( ).

    ASSIGN COMPONENT '%FIELD' OF STRUCTURE permission_request->* TO FIELD-SYMBOL(<permission_request_fields>).
    LOOP AT permission_request_fields INTO DATA(permission_request_field).
      ASSIGN COMPONENT permission_request_field-name OF STRUCTURE <permission_request_fields> TO FIELD-SYMBOL(<permission_request_field>).
      <permission_request_field> = if_abap_behv=>mk-on.
    ENDLOOP.

    DATA permission_result TYPE REF TO data.
    DATA(permission_result_type_name) = |\\BDEF={ root_name }\\ENTITY={ entity_name }\\TYPE=PERM_R|.
    CREATE DATA permission_result TYPE (permission_result_type_name).

    DATA(permissions_parameters) = VALUE abp_behv_permissions_tab( ( entity_name = entity_name
                                                                     request     = permission_request
                                                                     results     = permission_result ) ).

    GET PERMISSIONS ONLY GLOBAL OPERATIONS permissions_parameters.

    FIELD-SYMBOLS <reported> TYPE any.
    LOOP AT permission_request_fields INTO permission_request_field.
      ASSIGN COMPONENT |GLOBAL-%FIELD-{ permission_request_field-name }| OF STRUCTURE permission_result->* TO FIELD-SYMBOL(<field_permission>).
      DATA(is_field_mandatory) = xsdbool( <field_permission> = if_abap_behv=>fc-f-mandatory ).
      DATA(is_field_initial) = xsdbool( entity-(permission_request_field-name) IS INITIAL ).
      IF NOT ( is_field_mandatory = abap_true AND is_field_initial = abap_true ).
        CONTINUE.
      ENDIF.

      IF <reported> IS NOT ASSIGNED.
        APPEND INITIAL LINE TO failed ASSIGNING FIELD-SYMBOL(<failed>).
        <failed>-('%KEY') = entity-('%KEY').
        ASSIGN COMPONENT '%CID' OF STRUCTURE <failed> TO FIELD-SYMBOL(<cid>).
        IF <cid> IS ASSIGNED.
          <cid> = cid.
        ENDIF.

        APPEND INITIAL LINE TO reported ASSIGNING <reported>.
        <reported>-('%KEY') = entity-('%KEY').
        ASSIGN COMPONENT '%CID' OF STRUCTURE <reported> TO <cid>.
        IF <cid> IS ASSIGNED.
          <cid> = cid.
        ENDIF.
        <reported>-('%MSG') = new_message( id       = ycl_al_rap_message_definition=>message_class
                                           number   = CONV #( ycl_al_rap_message_definition=>mandatory_field )
                                           severity = if_abap_behv_message=>severity-error ).
      ENDIF.
      <reported>-('%ELEMENT')-(permission_request_field-name) = if_abap_behv=>mk-on.
    ENDLOOP.
    UNASSIGN: <reported>, <failed>.
  ENDMETHOD.
ENDCLASS.
