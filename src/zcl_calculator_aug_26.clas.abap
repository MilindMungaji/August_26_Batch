CLASS zcl_calculator_aug_26 DEFINITION
  PUBLIC
  CREATE PUBLIC ABSTRACT.

  PUBLIC SECTION.

*-- Instance Attributes
*    DATA : lv_pie TYPE decfloat16 VALUE '3.142'.

*-- Static Attributes
    CLASS-DATA : lv_pie TYPE decfloat16. " VALUE '3.142'.

    METHODS : abstract_method ABSTRACT EXPORTING ev_string TYPE string. "Abstract method declaration

*    "Instance Method Declaration
    METHODS : calculate_result importing iv_value1 type i              "iv = Importing variable
                                         iv_value2 type i
                                         iv_operator type c
                               exporting ev_result TYPE i.             "ev = Exporting variable

    "Static Method Declaration
*    CLASS-METHODS : calculate_result IMPORTING iv_value1   TYPE i              "iv = Importing variable
*                                               iv_value2   TYPE i
*                                               iv_operator TYPE c
*                                     EXPORTING ev_result   TYPE i.             "ev = Exporting variable

    "Functional Method Declaration
*    CLASS-METHODS : calculate_result IMPORTING iv_value1   TYPE i              "iv = Importing variable
*                                               iv_value2   TYPE i
*                                               iv_operator TYPE c
*                                     RETURNING VALUE(ev_result)   TYPE i             "ev = Exporting variable
*                                     RAISING CX_SY_ZERODIVIDE.                  "Handle division by zero exception
    "Instance Constructor Declaration
*    METHODS : constructor.

    "Static Constructor Declaration
    CLASS-METHODS : static_constructor.
PROTECTED SECTION.
  PRIVATE SECTION.

ENDCLASS.

CLASS zcl_calculator_aug_26 IMPLEMENTATION.

  METHOD calculate_result.

    	CASE iv_operator.
      	  WHEN '+'.
        		ev_result = iv_value1 + iv_value2.
      	  WHEN '-'.
        		ev_result = iv_value1 - iv_value2.
      	  WHEN '*'.
        		ev_result = iv_value1 * iv_value2.
      	  WHEN '/'.
      	     try.
        		ev_result = iv_value1 / iv_value2.
        	CATCH CX_SY_ZERODIVIDE.	
        		RAISE EXCEPTION type CX_SY_ZERODIVIDE.
        	ENDTRY.
         WHEN '^'.	
        	ev_result = lcl_sci_calculator=>calculate_result( EXPORTING
                                                  iv_value1   = iv_value1
                                                  iv_value2   = iv_value2
                                                  iv_operator = iv_operator ).	
        	        	
      	  WHEN OTHERS.
        		ev_result = 0. " Handle unsupported operator
    	ENDCASE.
    	
  ENDMETHOD.

  METHOD static_constructor.
    lv_pie = '3.142'.
  ENDMETHOD.

ENDCLASS.
