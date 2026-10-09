@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Student Consumption View'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
define root view entity zc_student
  provider contract transactional_query as projection on zi_student
{
    key Rollnointernal,
    key Rollno,
    Dept,
    Firstname,
    Lastname,
    Fullname,
    Birthdate,
    Emailid,
    Age,
    
//    @ObjectModel.virtualElementCalculatedBy: 'ABAP:ZCL_AMDP_AUG_26'
//    virtual VirtualElementAge : abap.int1,   //Age 
    Lastchanged,
    Createdby,
    Changedby,
    /* Associations */
    _Acad : redirected to composition child zc_stud_acad,
    _Fees : redirected to composition child zc_stud_fees
}
