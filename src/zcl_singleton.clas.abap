CLASS zcl_singleton DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    CLASS-METHODS : get_instance RETURNING VALUE(ro_instance) TYPE REF TO zcl_singleton,
      write_to_application_log IMPORTING iv_message TYPE string.

    CLASS-DATA : go_instance TYPE REF TO zcl_singleton.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.


CLASS zcl_singleton IMPLEMENTATION.
  METHOD get_instance.

    IF go_instance IS NOT BOUND.
      	go_instance = NEW zcl_singleton( ).
    ENDIF.
    ro_instance = go_instance.

  ENDMETHOD.

  METHOD write_to_application_log.

  ENDMETHOD.

ENDCLASS.
