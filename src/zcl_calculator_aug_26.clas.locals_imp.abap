**********************************************************************
* LOCAL CLASS DECLARATION & IMPLEMENTATION
**********************************************************************
CLASS lcl_SCI_CALCULATOR DEFINITION.

  PUBLIC SECTION.

  CLASS-METHODS : calculate_result IMPORTING iv_value1   TYPE i              "iv = Importing variable
                                             iv_value2   TYPE i
                                             iv_operator TYPE c
                                   RETURNING VALUE(ev_result)   TYPE i.             "ev = Exporting variable

  PROTECTED SECTION.
  PRIVATE SECTION.

ENDCLASS.

CLASS lcl_SCI_CALCULATOR IMPLEMENTATION.

  METHOD calculate_result.
    CASE iv_operator.
	  WHEN '^'.                "Power of
		ev_result = iv_value1 ** iv_value2.
	ENDCASE.
  ENDMETHOD.

ENDCLASS.

