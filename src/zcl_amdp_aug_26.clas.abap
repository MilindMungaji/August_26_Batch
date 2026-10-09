CLASS zcl_amdp_aug_26 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES : if_amdp_marker_hdb,
      if_rap_query_provider,         "This interface is for Custom Entities
      if_sadl_exit_calc_element_read.

    CLASS-METHODS : calculate_age FOR SCALAR FUNCTION zscalar_fun_calculate_age,
      get_stud_fees_data FOR TABLE FUNCTION z_table_function.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_amdp_aug_26 IMPLEMENTATION.
  METHOD calculate_age BY DATABASE FUNCTION FOR HDB LANGUAGE SQLSCRIPT OPTIONS READ-ONLY.
    result = dats_days_between( birthdate, '20260917' ) / 365 ;
  ENDMETHOD.

  METHOD get_stud_fees_data BY DATABASE FUNCTION FOR HDB LANGUAGE SQLSCRIPT OPTIONS READ-ONLY USING zdb_stud_fees .
    RETURN select *
           from zdb_stud_fees
           where rollno = :i_rollno;
  ENDMETHOD.

  METHOD if_rap_query_provider~select.

    "WIthout setting page size and no of output rows you will get ABAP Dump
    "Pagination
    DATA(lv_page_size) = io_request->get_paging( )->get_page_size(  ).
    DATA(lv_max_row) = COND #( WHEN lv_page_size = if_rap_query_paging=>page_size_unlimited THEN 0 ELSE lv_page_size ).

    "Get the filter criteria for eg - "Roll No = 2"
    DATA(l_clause) = io_request->get_filter( )->get_as_sql_string( ).  "Rollno = 2"

    DATA : it_custom TYPE TABLE OF zcds_custom_entity,
           wa_custom TYPE zcds_custom_entity.

    SELECT *
    FROM zdb_stud_fees
    INTO TABLE @DATA(it_fees).

    SELECT *
    FROM zdb_student
    INTO TABLE @DATA(it_student).

    LOOP AT it_fees ASSIGNING FIELD-SYMBOL(<fs_fees>).
      MOVE-CORRESPONDING <fs_fees> TO wa_custom.
      wa_custom-totalfees = <fs_fees>-feesyear1 + <fs_fees>-feesyear2 + <fs_fees>-feesyear3 + <fs_fees>-feesyear4.

      READ TABLE it_student ASSIGNING FIELD-SYMBOL(<fs_student>) WITH KEY rollno = <fs_fees>-rollno.
      IF sy-subrc = 0.
        wa_custom-dept = <fs_student>-dept.
      ENDIF.

      APPEND wa_custom TO it_custom.
    ENDLOOP.

    "WHERE (l_clause) INTO TABLE @DATA(it_fees).
    IF sy-subrc = 0.

      "Set the no of records in the ouput
      IF io_request->is_total_numb_of_rec_requested( ).
        io_response->set_total_number_of_records( iv_total_number_of_records = lines( it_custom  )   ).
*        CATCH cx_rap_query_response_set_twic.
      ENDIF.

      "Show the records in output
      io_response->set_data( it_data = it_custom ).
*       CATCH cx_rap_query_response_set_twic.
    ENDIF.

  ENDMETHOD.

  METHOD if_sadl_exit_calc_element_read~calculate.
*    DATA : lt_original_data TYPE TABLE OF ZC_STUDENT.
*    lt_original_data = CORRESPONDING #( it_original_data ).
*
*    LOOP AT lt_original_data ASSIGNING FIELD-SYMBOL(<fs_original_data>).
*      <fs_original_data>-VirtualElementAge = ( cl_abap_context_info=>get_system_date(  ) - <fs_original_data>-Birthdate ) / 365 .
*    ENDLOOP.
*    ct_calculated_data = CORRESPONDING #( lt_original_data ).

  ENDMETHOD.

  METHOD if_sadl_exit_calc_element_read~get_calculation_info.
*    IF iv_entity = 'ZC_STUDENT'.
*      LOOP AT it_requested_calc_elements ASSIGNING FIELD-SYMBOL(<fs_calc_elements>).
*        CASE <fs_calc_elements>.
*          WHEN 'VIRTUALELEMENTAGE'.
*            APPEND 'BIRTHDATE' TO et_requested_orig_elements.
*        ENDCASE.
*      ENDLOOP.
*    ENDIF.

  ENDMETHOD.

ENDCLASS.
