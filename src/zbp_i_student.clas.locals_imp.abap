CLASS lsc_zi_student DEFINITION INHERITING FROM cl_abap_behavior_saver.

  PROTECTED SECTION.

    METHODS adjust_numbers REDEFINITION.

ENDCLASS.

CLASS lsc_zi_student IMPLEMENTATION.

  METHOD adjust_numbers.

    TRY.
        " Fetch gap-free numbers at the final save moment
        cl_numberrange_runtime=>number_get(
          EXPORTING
            nr_range_nr       = '01'
            object            = 'ZROLLNO_NR'
            quantity          = 1
          IMPORTING
            number            = DATA(lv_number)
          ).
      CATCH cx_number_ranges.
        " Failures here can be thrown to abort the save cycle
        RETURN.
    ENDTRY.

*    DATA(lv_next_number) = lv_number - lv_quantity + 1.

*    LOOP AT  ASSIGNING FIELD-SYMBOL(<ls_travel>).
*      " Assign the permanent database key
*      <ls_travel>-TravelID = |{ lv_next_number WIDTH = 8 SIGN = RIGHT PAD = '0' }|.
*      lv_next_number += 1.
*    ENDLOOP.
*
*    " Export the permanently updated keys back to the RAP runtime mapped structure
    IF mapped IS NOT INITIAL.
      mapped-student[ 1 ]-Rollno = lv_number.
    ENDIF.
  ENDMETHOD.

ENDCLASS.

CLASS lhc_Student DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      keys REQUEST requested_authorizations FOR Student RESULT result.

    METHODS get_global_authorizations FOR GLOBAL AUTHORIZATION
      REQUEST requested_authorizations FOR Student RESULT result.
    METHODS a_updateBirthdate FOR MODIFY
       keys FOR ACTION Student~a_updateBirthdate RESULT result.
    METHODS get_instance_features FOR INSTANCE FEATURES
      keys REQUEST requested_features FOR Student RESULT result.
    METHODS validatebirthdate FOR VALIDATE ON SAVE
      keys FOR student~validatebirthdate.
    METHODS determineage FOR DETERMINE ON MODIFY
      keys FOR student~determineage.
    "METHODS earlynumbering_create.
*    METHODS earlynumbering_create FOR NUMBERING
*       entities FOR CREATE Student.

ENDCLASS.

CLASS lhc_Student IMPLEMENTATION.

  METHOD get_instance_authorizations.
  ENDMETHOD.

  METHOD get_global_authorizations.
  ENDMETHOD.

*  METHOD earlynumbering_create.
*
*    DATA(lv_count) = lines( entities ).
*    TRY.
*        " Get numbers from number range object via CL_NUMBERRANGE_RUNTIME
*        CALL METHOD cl_numberrange_runtime=>number_get
*          EXPORTING
*            object            = 'ZROLLNO_NR'
**           interval          = lv_interval
*            nr_range_nr       = '01'
*            quantity          = CONV #( lines( entities ) )
*          IMPORTING
*            number            = DATA(lv_latest_number)
*            returncode        = DATA(lv_returncode)
*            returned_quantity = DATA(lv_returned_quantity).
*      CATCH cx_nr_object_not_found.
*      CATCH cx_number_ranges INTO data(lo_error).
*
*      LOOP AT entities into data(ls_entities).
*        APPEND VALUE #( %cid = ls_entities-%cid
*                        %key = ls_entities-%key ) to failed-student.
*        APPEND VALUE #( %cid = ls_entities-%cid
*                        %key = ls_entities-%key
*                        %msg = lo_error ) to reported-student.
*      endloop.
*    ENDTRY.
*
*    DATA(lv_current_number) = lv_latest_number - lv_returned_quantity + 1.
*
*    LOOP AT entities INTO DATA(entity).
*      APPEND VALUE #( %cid      = entity-%cid
*                      %is_draft           = entity-%is_draft
*                      rollno = lv_current_number ) TO mapped-student.
*    ENDLOOP.
*
*  ENDMETHOD.

  METHOD a_updateBirthdate.

    " EML Statement to update birthdate
    MODIFY ENTITIES OF zc_student
     " IN LOCAL MODE
      ENTITY student
      UPDATE FIELDS ( Birthdate )
      WITH VALUE #( FOR key IN keys ( %key-rollno = key-rollno
                                      birthdate = key-%param-birthdate )  )
      FAILED DATA(lt_failed)
      MAPPED DATA(lt_mapped)
      REPORTED DATA(lt_reported).
    IF lt_failed IS INITIAL.
        data(lv_msg) = | Student | && keys[ 1 ]-Rollno && | Birthdate updated successfully |.

        APPEND INITIAL LINE TO reported-student ASSIGNING FIELD-SYMBOL(<fs_student>).
        <fs_student>-%msg = new_message_with_text(
                              severity = if_abap_behv_message=>severity-success
                              text     = lv_msg
                            ).
    else.

        lv_msg = | Student | && keys[ 1 ]-Rollno && | update FAILED |.

        APPEND INITIAL LINE TO reported-student ASSIGNING <fs_student>.
        <fs_student>-%msg = new_message_with_text(
                              severity = if_abap_behv_message=>severity-success
                              text     = lv_msg
                            ).

    ENDIF.

  ENDMETHOD.

  METHOD get_instance_features.

  READ ENTITIES OF zc_student
    ENTITY student
    FIELDS ( Dept )
    WITH CORRESPONDING #( keys )
    RESULT DATA(lt_result).

    result = VALUE #( FOR ls_result IN lt_result ( %key-rollno = ls_result-rollno
                                                   %features-%action-a_updateBirthdate = COND #( WHEN ls_result-Dept = 'IT'
                                                                                            THEN  if_abap_behv=>fc-o-enabled
                                                                                            ELSE if_abap_behv=>fc-o-disabled ) ) ).

  ENDMETHOD.

  METHOD validateBirthdate.

  READ ENTITIES OF zc_student
  ENTITY student
  FIELDS ( birthdate )
  WITH CORRESPONDING #( keys )
  RESULT DATA(lt_result).

    DATA(ls_result) = lt_result[ 1 ].

    IF  ls_result-birthdate > cl_abap_context_info=>get_system_date( ).

      APPEND INITIAL LINE TO reported-student ASSIGNING FIELD-SYMBOL(<lfs_reported>).
      <lfs_reported>-%msg = new_message_with_text(
                              severity = if_abap_behv_message=>severity-error
                              text     = 'Birth date cannot be a future date'
                            ).
    APPEND INITIAL LINE TO failed-student ASSIGNING FIELD-SYMBOL(<lfs_failed>).
      <lfs_failed>-%key = lt_result[ 1 ]-%key.

    ENDIF.

  ENDMETHOD.

  METHOD DetermineAge.

  READ ENTITIES OF zc_student
        ENTITY student
        FIELDS ( birthdate )
        WITH CORRESPONDING #( DEEP keys )
        RESULT DATA(lt_result).

    DATA(lv_age) = ( cl_abap_context_info=>get_system_date( ) - lt_result[ 1 ]-birthdate ) / 365.

    MODIFY ENTITIES OF zi_student
     IN LOCAL MODE
     ENTITY student
     UPDATE FIELDS ( Age ) WITH VALUE #( FOR key IN keys (  %key-Rollnointernal = key-Rollnointernal
                                                            %key-rollno         = key-rollno
                                                            %is_draft           = key-%is_draft
                                                            age                 = lv_age ) )
     FAILED DATA(lt_failed)
     MAPPED DATA(lt_mapped)
     REPORTED DATA(lt_reported).


* %control = VALUE #( age = if_abap_behv=>mk-on

*DATA: lt_update TYPE TABLE FOR UPDATE Zi_student.
*
*APPEND VALUE #( %tky = lt_result[ 1 ]-%tky
*                        Age  = lv_age ) TO lt_update.
*
* MODIFY ENTITIES OF zi_student
*     IN LOCAL MODE
*     ENTITY student
*     UPDATE FIELDS ( Age ) WITH CORRESPONDING #( DEEP lt_update )
*     FAILED DATA(lt_failed)
*     MAPPED DATA(lt_mapped)
*     REPORTED DATA(lt_reported).

  ENDMETHOD.

ENDCLASS.
