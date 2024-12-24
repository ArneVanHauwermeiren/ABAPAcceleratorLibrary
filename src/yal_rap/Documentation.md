The `ycl_al_rap_fieldvalidatorreq` class validates whether all mandatory fields of a RAP-object are filled in.
It reports the relevant error messages in case fields are missing.

The `ycl_al_rap_message_definition` class enumerates the message numbers and their corresponding message class for RAP-related messages.

```mermaid
classDiagram
class ZCM_AL_RAP {
    <<Message Class>>
    +000: Er is iets misgelopen...
    +001: Verplicht veld &1!
}

class ycl_al_rap_fieldvalidatorreq {
    +root_name: string
    +entity_name: string
    +constructor(root_name: string, entity_name: string)
    +validate(cid: abp_behv_cid, entity: any, failed: STANDARD TABLE, reported: STANDARD TABLE)
}

class ycl_al_rap_message_definition {
    <<Enumeration>>
    +message_number
    +mandatory_field: '001'
    +undefined: IS INITIAL
    +message_class: 'ZCM_AL_RAP'
}

ycl_al_rap_fieldvalidatorreq --> ycl_al_rap_message_definition : Uses
ycl_al_rap_message_definition --> ZCM_AL_RAP : Uses
```
