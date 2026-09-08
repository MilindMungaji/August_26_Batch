**********************************************************************
*  INHERITANCE CLASS
**********************************************************************
CLASS zcl_inheritance_cl DEFINITION INHERITING FROM zcl_calculator_aug_26 PUBLIC.

 PUBLIC SECTION.
    INTERFACES : zif_calculator2.
   METHODS: abstract_method REDEFINITION.
*   METHODS : calculate_result REDEFINITION.
  PROTECTED SECTION.

  PRIVATE SECTION.
ENDCLASS.


CLASS zcl_inheritance_cl IMPLEMENTATION.

  METHOD abstract_method.
    ev_string = 'This is an abstract method implemented in the subclass.'.
  ENDMETHOD.

  METHOD zif_calculator2~calculate_percentage.
    rv_result = ( iv_value1 * iv_value2 ) / 100.
  ENDMETHOD.

ENDCLASS.


*METHOD calculate_result.
*    super->calculate_result(            "Call the superclass method
*      EXPORTING
*        iv_value1   = iv_value1
*        iv_value2   = iv_value2
*        iv_operator = iv_operator
*      IMPORTING
*        ev_result   = ev_result
*    ).
*
*    CASE iv_operator.
*          WHEN '√'.                "Square Root operation
*                ev_result = sqrt( iv_value1 ).
*        ENDCASE.
*  ENDMETHOD.

