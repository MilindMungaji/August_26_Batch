@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Fees Info Interface View'
@Metadata.ignorePropagatedAnnotations: true
define view entity zi_fees as select from zdb_stud_fees
association to parent zi_student as _Stud on $projection.Rollnointernal = _Stud.Rollnointernal
                                        and $projection.Rollno = _Stud.Rollno   
{
    key rollnointernal as Rollnointernal,
    key rollno as Rollno,
    @Semantics.amount.currencyCode: 'Currency'
    feesyear1 as Feesyear1,
    @Semantics.amount.currencyCode: 'Currency'
    feesyear2 as Feesyear2,
    @Semantics.amount.currencyCode: 'Currency'
    feesyear3 as Feesyear3,
    @Semantics.amount.currencyCode: 'Currency'
    feesyear4 as Feesyear4,
    currency as Currency,
    
    //Expose Association
    _Stud
    
}
