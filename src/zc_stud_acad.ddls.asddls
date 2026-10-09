@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Academy Info Consumption View'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
define view entity zc_stud_acad
  as projection on zi_academy
{
    key Rollnointernal,
    key Rollno,
    key Semester,
    key Subject,
    Marks,
    /* Associations */
    _Stud : redirected to parent zc_student
}
