@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Academy Info Interface View'
@Metadata.ignorePropagatedAnnotations: true
define view entity zi_academy as select from zdb_stud_acad 
association to parent zi_student as _Stud on $projection.Rollnointernal = _Stud.Rollnointernal
                                        and $projection.Rollno = _Stud.Rollno   
{
    key rollnointernal as Rollnointernal,
    key rollno as Rollno,
    key semester as Semester,
    key subject as Subject,
    marks as Marks,
    
    //Expose Association
    _Stud
}
