```mermaid

classDiagram
class ycl_al_message_comparator {
    +equals(message1: if_xco_message, message2: if_xco_message) abap_boolean
}

class ycl_al_message_converter {
    +bapiret2_to_symsg(bapiret2: bapiret2) symsg
}

class ycl_al_message_factory {
    +validator: ycl_al_message_validator
    +comparator: ycl_al_message_comparator
    +converter: ycl_al_message_converter
    +constructor()
    +create(symsg: symsg) if_xco_message
}

class ycl_al_message_validator {
    +is_error(message: if_xco_message) abap_boolean
    +is_warning(message: if_xco_message) abap_boolean
    +is_success(message: if_xco_message) abap_boolean
    +is_information(message: if_xco_message) abap_boolean
    +is_type(message: if_xco_message, type: cl_xco_message_type) abap_boolean
}

class ycl_al_messages_comparator {
    +equals(messages1: if_xco_messages, messages2: if_xco_messages) abap_boolean
    +contains(messages: if_xco_messages, message: if_xco_message) abap_boolean
}

class ycl_al_messages_converter {
    +bapirettab_to_sxco_t_messages(bapirettab: bapirettab) sxco_t_messages
}

class ycl_al_messages_factory {
    +validator: ycl_al_messages_validator
    +comparator: ycl_al_messages_comparator
    +converter: ycl_al_messages_converter
    +modifier: ycl_al_messages_modifier
    +constructor()
    +create(sxco_t_messages: sxco_t_messages) if_xco_messages
}

class ycl_al_messages_modifier {
    +add_message(messages: if_xco_messages, message: if_xco_message) if_xco_messages
    +remove_message(messages: if_xco_messages, message: if_xco_message) if_xco_messages
    +remove_duplicates(messages: if_xco_messages) if_xco_messages
}

class ycl_al_messages_validator {
    +has_errors(messages: if_xco_messages) abap_boolean
    +has_warnings(messages: if_xco_messages) abap_boolean
    +has_informations(messages: if_xco_messages) abap_boolean
    +has_successes(messages: if_xco_messages) abap_boolean
    +get_messages_of_type(messages: if_xco_messages, type: cl_xco_message_type) if_xco_messages
}

ycl_al_message_factory --> ycl_al_message_validator : validator
ycl_al_message_factory --> ycl_al_message_comparator : comparator
ycl_al_message_factory --> ycl_al_message_converter : converter

ycl_al_messages_factory --> ycl_al_messages_validator : validator
ycl_al_messages_factory --> ycl_al_messages_comparator : comparator
ycl_al_messages_factory --> ycl_al_messages_converter : converter
ycl_al_messages_factory --> ycl_al_messages_modifier : modifier

ycl_al_messages_comparator --> ycl_al_message_factory : comparator

ycl_al_messages_modifier --> ycl_al_message_factory : comparator

ycl_al_messages_validator --> ycl_al_message_factory : validator
```
