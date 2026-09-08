INTERFACE zif_calculator2
  PUBLIC .

    METHODS : calculate_percentage IMPORTING iv_value1 TYPE i
                                             iv_value2 TYPE i
                                   RETURNING VALUE(rv_result) TYPE f.
ENDINTERFACE.
