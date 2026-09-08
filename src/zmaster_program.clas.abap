CLASS zmaster_program DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zmaster_program IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

**************************************************************************************
* Day 5 - ABAP Basics - Data Declaration, value assignment
**************************************************************************************
*    DATA : lv_var  TYPE string,            "LV = Local Variable
*           lv_var1 TYPE i,
*           lv_var2 TYPE c,
*           lv_var3 TYPE p DECIMALS 2,
*           lv_var4 TYPE d,
*           lv_var5 TYPE t,
*           lv_var6 TYPE xstring.
*
*    CONSTANTS : lc_constant TYPE i VALUE 10.
*
*    lv_var = 'Hello World'.
*    lv_var1 = 123.
*    lv_var2 = 'A'.
*    lv_var3 = '123.45'.
*    lv_var4 = '20240101'.
*    lv_var5 = '123456'.
*    lv_var6 = 'Hello World in XSTRING'.
*
**    out->write( lv_var  ).
**    out->write( lv_var1 ).
**    out->write( lv_var2 ).
**    out->write( lv_var3 ).
**    out->write( lv_var4 ).
**    out->write( lv_var5 ).
**    out->write( lv_var6 ).	
*
**-- Literal
*
**    data(lv_literal) = 'This is a literal value'.
**	out->write( lv_literal ).
*	
**	data(lv_literal) = | ASBDSDS 12344 !@$%^&**** |.
**    out->write( lv_literal ).
*
**- String operations
*
*	data(lv_string1) = 'Hello'.
*	data(lv_string2) = 'World'.
*	data(lv_string3) = lv_string1  && lv_string2.
*	out->write( lv_string3 ).
*
**- Arithmetic operations
*  data(lv_addition) = lv_var1 + lc_constant.
*  data(lv_subtraction) = lv_var1 - lc_constant.
*  data(lv_multiplication) = lv_var1 * lc_constant.
*  data(lv_division) = lv_var1 / lc_constant.
*
** clean up
*  clear: lv_var, lv_var1, lv_var2, lv_var3, lv_var4, lv_var5, lv_var6, lv_string1, lv_string2, lv_string3,
*		  lv_addition, lv_subtraction, lv_multiplication, lv_division.
*
*  out->write( |Addition: { lv_addition }| ).
*  out->write( |Subtraction: { lv_subtraction }| ).
*  out->write( |Multiplication: { lv_multiplication }| ).
*  out->write( |Division: { lv_division }| ).	
*  	
*- Structure  	
    TYPES : BEGIN OF ty_student,
              rollno    TYPE i,
              firstname TYPE string,
              lastname  TYPE string,
              fullname  TYPE string,
              birthdate TYPE d,
              age       TYPE i,
              emailid   TYPE string,
            END OF ty_student.  	

    DATA : lt_students TYPE TABLE OF ty_student,
           		 lwa_student TYPE ty_student.
    		
*- assign values to internal table using workarea
*  lwa_student-rollno = 1.
*  lwa_student-firstname  = 'John'.
*  lwa_student-lastname  = 'Doe'.
*  lwa_student-birthdate = '19900101'.
*  lwa_student-age = 30.
*  lwa_student-emailid = 'John.Doe@Gmail.com'.
*  APPEND lwa_student TO lt_students.
*
*   lwa_student-rollno = 2.
*  lwa_student-firstname  = 'Harshada'.
*  lwa_student-lastname  = 'Koli'.
*  lwa_student-birthdate = '20000101'.
*  lwa_student-age = 20.
*  lwa_student-emailid = 'Harshada.Koli@Gmail.com'.
*  APPEND lwa_student TO lt_students.
*
*  lwa_student-rollno = 3.
*  lwa_student-firstname  = 'Vaibhav'.
*  lwa_student-lastname  = 'Dandge'.
*  lwa_student-birthdate = '20010101'.
*  lwa_student-age = 22.
*  lwa_student-emailid = 'Vaibhav.Dandge@Gmail.com'.
*  APPEND lwa_student TO lt_students.
*
*  lwa_student-rollno = 4.
*  lwa_student-firstname  = 'Namita'.
*  lwa_student-lastname  = 'Gowda'.
*  lwa_student-birthdate = '20020101'.
*  lwa_student-age = 21.
*  lwa_student-emailid = 'Namita.Gowda@Gmail.com'.
*  APPEND lwa_student TO lt_students.

    APPEND INITIAL LINE TO lt_students ASSIGNING FIELD-SYMBOL(<fs_student>).
    lwa_student-rollno = 1.
    <fs_student>-firstname  = 'John'.
    <fs_student>-lastname  = 'Doe'.
    <fs_student>-birthdate = '19900101'.
    <fs_student>-age = 30.
    <fs_student>-emailid = 'John.Doe@Gmail.com'.


    APPEND INITIAL LINE TO lt_students ASSIGNING <fs_student>.
    <fs_student>-rollno = 2.
    <fs_student>-firstname  = 'Harshada'.
    <fs_student>-lastname  = 'Koli'.
    <fs_student>-birthdate = '20000101'.
    <fs_student>-age = 20.
    <fs_student>-emailid = 'Harshada.Koli@Gmail.com'.


    APPEND INITIAL LINE TO lt_students ASSIGNING <fs_student>.
    <fs_student>-rollno = 3.
    <fs_student>-firstname  = 'Vaibhav'.
    <fs_student>-lastname  = 'Dandge'.
    <fs_student>-birthdate = '20010101'.
    <fs_student>-age = 22.
    <fs_student>-emailid = 'Vaibhav.Dandge@Gmail.com'.

    APPEND INITIAL LINE TO lt_students ASSIGNING <fs_student>.
    <fs_student>-rollno = 4.
    <fs_student>-firstname  = 'Namita'.
    <fs_student>-lastname  = 'Gowda'.
    <fs_student>-birthdate = '20020101'.
    <fs_student>-age = 21.
    <fs_student>-emailid = 'Namita.Gowda@Gmail.com'.

    APPEND VALUE #( rollno = 5 firstname = 'John' lastname = 'Doe' birthdate = '19900101' age = 30 emailid = 'ABC@Gmail.com') TO lt_students.

* out->write( lt_students ).

**************************************************************************************
* Day 5 - LOOP, DO Loops, FOR Loops
**************************************************************************************
*    LOOP AT lt_students into lwa_student.
**      if lwa_student-age > 20.
**      lwa_student-fullname =  lwa_student-firstname && lwa_student-lastname.
**        out->write( lwa_student ).
**
**      else.
**
**        out->write( 'Age Less than 20' ).
**      endif.
*       case lwa_student-rollno.
*		 when 1.
*		   out->write( |Roll No: 1 | ).
*		 when 2.
*		   out->write( |Roll No: { lwa_student-rollno }| ).
*		 when 3.
*		   out->write( |Roll No: 3 | ).
*		 when 4.
*		   out->write( |Roll No: { lwa_student-rollno }| ).
*		 when others.
*		   out->write( |Roll No: Other than 1-4 | ).
*        ENDCASE.
*    ENDLOOP.

*-- Using Field Symbols
*    LOOP AT lt_students ASSIGNING <fs_student>.
**      if lwa_student-age > 20.
**      lwa_student-fullname =  lwa_student-firstname && lwa_student-lastname.
**        out->write( lwa_student ).
**
**      else.
**
**        out->write( 'Age Less than 20' ).
**      endif.
*       case <fs_student>-rollno.
*         when 1.
*           out->write( |Roll No: 1 | ).
*         when 2.
*           out->write( |Roll No: { <fs_student>-rollno }| ).
*         when 3.
*           out->write( |Roll No: 3 | ).
*         when 4.
*           out->write( |Roll No: { <fs_student>-rollno }| ).
*         when others.
*           out->write( |Roll No: Other than 1-4 | ).
*        ENDCASE.
*    ENDLOOP.

*    DATA : lv_counter TYPE i VALUE 0.
*
*    DO 50 TIMES.
*      lv_counter = lv_counter + 1.
*      out->write( |Counter: { lv_counter }| ).
*    ENDDO.

*    TYPES : BEGIN OF ty_student1,
*              rollno    TYPE i,
*              firstname TYPE string,
*              lastname  TYPE string,
*            END OF ty_student1.
*
*    TYPES : lt_student1 TYPE STANDARD TABLE OF ty_student1 WITH EMPTY KEY.
*
**-- FOR Loop
*    DATA(lt_student2) = VALUE lt_student1( FOR lwa_student1 IN lt_students ( rollno = lwa_student1-rollno
*																  firstname = lwa_student1-firstname
*																  lastname = lwa_student1-lastname )  ).
*
*    out->write( lt_student2 ).

*-- Exception Handling
*    TRY.
*        DATA(lv_exception) = 1 / 0.
*      CATCH cx_sy_zerodivide INTO DATA(lv_zerodivide).
*        	out->write( |Exception: { lv_zerodivide->get_text( ) }| ).
*    ENDTRY.

**************************************************************************************
* Day 8 - OOP - Classes, Objects, Methods, Attributes, Constructors
**************************************************************************************

*-- Create Object of the class
*    DATA(lo_calculator) = NEW zcl_calculator_aug_26(  ).
*
**-- To access Instance Data/method of the class use ->
**-- To access Static Data/method of the class use =>
*
*-- Access Instance Method of the class
*    lo_calculator->calculate_result( EXPORTING
*                                        iv_value1   = 100
*                                        iv_value2   = 50
*                                        iv_operator = '+'
*                                      IMPORTING
*                                        ev_result   = data(lv_result) ).


*-- Access Static Method of the class
*    zcl_calculator_aug_26=>calculate_result(
*                                        EXPORTING
*                                          iv_value1   = 200
*                                          iv_value2   = 20
*                                          iv_operator = '*'
*                                        IMPORTING
*                                          ev_result   =  DATA(lv_result) ).
*
*    out->write( |Result: { lv_result }| ).

**************************************************************************************
* Day 9 - OOP - Attributes, Functional Methods, Constructors
**************************************************************************************

*-- Access Instance Attribute of the class
*    out->write( lo_calculator->lv_pie ).

*-- Access Static Attribute of the class
*    out->write( zcl_calculator_aug_26=>lv_pie ).
*
**-- Access Functional Method of the class
*    DATA(lv_result) = zcl_calculator_aug_26=>calculate_result(
*                                        EXPORTING
*                                          iv_value1   = zcl_calculator_aug_26=>calculate_result(
*                                                                EXPORTING
*                                                                      iv_value1   = 100
*                                                                      iv_value2   = 10
*                                                                      iv_operator = '/' )
*                                          iv_value2   = 5
*                                          iv_operator = '*' ).
*
**    out->write( zcl_calculator_aug_26=>calculate_result(
**                                        EXPORTING
**                                          iv_value1   = 200
**                                          iv_value2   = 5
**                                          iv_operator = '/' ) ).
*
*
*    out->write( lv_result ).

*-- Access Instance Constructor of the class
* out->write( lo_calculator->lv_pie ).

*-- Access Static Constructor of the class
*zcl_calculator_aug_26=>static_constructor( ).

**************************************************************************************
* Day 10 - Exception Handling in OOPs,
**************************************************************************************

*-- Exception Handling in OOPs

*    TRY.
*        DATA(lv_result) = zcl_calculator_aug_26=>calculate_result(
*                                                EXPORTING
*                                                  iv_value1   = 10
*                                                  iv_value2   = 0
*                                                  iv_operator = '/' ).
*      CATCH cx_sy_zerodivide INTO DATA(lv_zerodivide).
*        out->write( |Exception: { lv_zerodivide->get_text( ) }| ).
*    ENDTRY.

*-- Call Local Class
*    DATA(lv_result) = zcl_calculator_aug_26=>calculate_result(
*                                                    EXPORTING
*                                                      iv_value1   = 4
*                                                      iv_value2   = 4
*                                                      iv_operator = '^' ).
*    out->write( lv_result ).

*-- Call Child class method

*-- Create Object of the Child class
*    DATA(lo_child) = NEW zcl_inheritance_cl( ).

*-- Access Instance Method of the Child class
*    lo_child->calculate_result( EXPORTING
*    										iv_value1   = 25
*    										iv_value2   = 0
*    										iv_operator = '√'
*    					        IMPORTING
*    					                   ev_result = DATA(lv_result) ).

*-- Call Interface Method of the Child class

    DATA(lo_child) = NEW zcl_inheritance_cl( ).
        " ~ = TIlde operator is used to call the method of the interface implemented by the class
*    lo_child->zif_calculator2~calculate_percentage(
*                                                      EXPORTING
*                                                        iv_value1 = 50
*                                                        iv_value2 = 40
*                                                      RECEIVING
*                                                        rv_result = data(lv_result)
*                                                    ).
*
*    out->write( |Percentage: { lv_result }| ).

*-- Call Abstract Method of the Child class

*        lo_child->abstract_method(
*          IMPORTING
*            ev_string = data(lv_string)
*        ).
*        out->write( |Abstract Method: { lv_string }| ).

*-- Call singleton method of the class
    DATA(lo_singleton) = zcl_singleton=>get_instance( ).

  ENDMETHOD.






















ENDCLASS.
