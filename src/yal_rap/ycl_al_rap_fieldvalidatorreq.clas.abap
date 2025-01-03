"! This class handles validation of mandatory fields for a RAP entity.
"! It validates fields based on permission settings in the behavior definition and generates appropriate
"! error messages for missing mandatory fields.
"! The messages are added to the provided failed and reported tables.
CLASS ycl_al_rap_fieldvalidatorreq DEFINITION
  PUBLIC
  INHERITING FROM cl_abap_behv FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.
    "! Constructor to initialize the class
    "!
    "! @parameter failed | Message table for failed
    "! @parameter reported | Message table for reported
    METHODS constructor
      IMPORTING !failed   TYPE REF TO data
                !reported TYPE REF TO data.

    "! Validates the fields of the given entity against its permissions.
    "! @parameter keys   | The entities to be validated.
    METHODS validate IMPORTING !keys TYPE ANY TABLE.

  PROTECTED SECTION.

  PRIVATE SECTION.
    DATA failed         TYPE REF TO data.
    DATA reported       TYPE REF TO data.
    DATA keys           TYPE REF TO data.
    DATA cds_name       TYPE string.
    DATA behaviour_name TYPE string.
    DATA permissions    TYPE REF TO data.

    METHODS get_cds_name       RETURNING VALUE(result) TYPE string.
    METHODS get_behaviour_name RETURNING VALUE(result) TYPE string.
    METHODS get_permissions    RETURNING VALUE(result) TYPE REF TO data.
ENDCLASS.


CLASS ycl_al_rap_fieldvalidatorreq IMPLEMENTATION.
  METHOD constructor.
    super->constructor( ).
    me->failed   = failed.
    me->reported = reported.
  ENDMETHOD.

  METHOD validate.
    me->keys = REF #( keys ).

    "Read entities
    DATA op_tab TYPE abp_behv_retrievals_tab.
    DATA(read_table_descriptor) = CAST cl_abap_tabledescr( cl_abap_typedescr=>describe_by_name(
                                                               |\\BDEF={ get_behaviour_name( ) }\\ENTITY={ get_cds_name( ) }\\TYPE=READ_R| ) ).
    DATA entities TYPE REF TO data.
    CREATE DATA entities TYPE HANDLE read_table_descriptor.
    op_tab = VALUE #( ( op          = if_abap_behv=>op-r-read
                        entity_name = cds_name
                        instances   = REF #( keys )
                        results     = entities ) ).
    READ ENTITIES OPERATIONS op_tab.

    " Get reported and failed
    FIELD-SYMBOLS <failed_table> TYPE STANDARD TABLE.
    ASSIGN failed->* TO <failed_table>.
    FIELD-SYMBOLS <reported_table> TYPE STANDARD TABLE.
    ASSIGN reported->* TO <reported_table>.

    "Validate mandatory fields
    DATA(permissions) = get_permissions( ).
    DATA(entity_descriptor) = NEW ycl_al_abap_structdescr( CAST cl_abap_structdescr( read_table_descriptor->get_table_line_type( ) ) ).
    LOOP AT entities->* ASSIGNING FIELD-SYMBOL(<result>).
      FIELD-SYMBOLS <reported> TYPE any.
      LOOP AT entity_descriptor->get_all_subcomponents( ) INTO DATA(entity_field).
        ASSIGN COMPONENT |GLOBAL-%FIELD-{ entity_field-name }| OF STRUCTURE permissions->* TO FIELD-SYMBOL(<field_permission>).
        IF <field_permission> IS NOT ASSIGNED.
          CONTINUE.
        ENDIF.


        DATA(is_field_mandatory) = xsdbool( <field_permission> = if_abap_behv=>fc-f-mandatory ).
        DATA(is_field_initial) = xsdbool( <result>-(entity_field-name) IS INITIAL ).
        IF NOT ( is_field_mandatory = abap_true AND is_field_initial = abap_true ).
          CONTINUE.
        ENDIF.

        IF <reported> IS NOT ASSIGNED.
          APPEND INITIAL LINE TO <failed_table> ASSIGNING FIELD-SYMBOL(<failed>).
          <failed>-('%TKY') = <result>-('%TKY').
          UNASSIGN <failed>.

          APPEND INITIAL LINE TO <reported_table> ASSIGNING <reported>.
          <reported>-('%TKY') = <result>-('%TKY').
          <reported>-('%MSG') = new_message( id       = ycl_al_rap_message_definition=>message_class
                                             number   = CONV #( ycl_al_rap_message_definition=>mandatory_field )
                                             severity = if_abap_behv_message=>severity-error ).

        ENDIF.
        <reported>-('%ELEMENT')-(entity_field-name) = if_abap_behv=>mk-on.

        UNASSIGN <reported>.
      ENDLOOP.
    ENDLOOP.
  ENDMETHOD.

  METHOD get_behaviour_name.
    IF behaviour_name IS INITIAL.
      DATA(keys_descriptor) = cl_abap_typedescr=>describe_by_data( keys->* ).
      SPLIT keys_descriptor->absolute_name AT '\' INTO DATA(start) DATA(bdef) DATA(end).
      behaviour_name = substring_after( val = bdef
                                        sub = 'BDEF=' ).
    ENDIF.

    result = behaviour_name.
  ENDMETHOD.

  METHOD get_cds_name.
    IF cds_name IS INITIAL.
      DATA(keys_descriptor) = cl_abap_typedescr=>describe_by_data( keys->* ).
      SPLIT keys_descriptor->absolute_name AT '\' INTO DATA(start) DATA(bdef) DATA(entity) DATA(end).
      cds_name = substring_after( val = entity
                                  sub = 'ENTITY=' ).
    ENDIF.

    result = cds_name.
  ENDMETHOD.

  METHOD get_permissions.
    IF permissions IS INITIAL.
        DATA permission_request TYPE REF TO data.

        DATA(permission_request_type_name) = |\\BDEF={ get_behaviour_name( ) }\\ENTITY={ get_cds_name( ) }\\TYPE=PERM_Q|.
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

        DATA(permission_result_type_name) = |\\BDEF={ get_behaviour_name( ) }\\ENTITY={ get_cds_name( ) }\\TYPE=PERM_R|.
        CREATE DATA permissions TYPE (permission_result_type_name).

        DATA(permissions_parameters) = VALUE abp_behv_permissions_tab( ( entity_name = cds_name
                                                                         request     = permission_request
                                                                         results     = permissions ) ).

        GET PERMISSIONS ONLY GLOBAL OPERATIONS permissions_parameters.
      ENDIF.

      result = permissions.
  ENDMETHOD.
ENDCLASS.
