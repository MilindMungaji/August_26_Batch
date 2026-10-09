@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Fees Consumption View'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
define view entity zc_stud_fees
  as projection on zi_fees
{
    key Rollnointernal,
    key Rollno,
    @Semantics.amount.currencyCode: 'Currency'
    Feesyear1,
    @Semantics.amount.currencyCode: 'Currency'
    Feesyear2,
    @Semantics.amount.currencyCode: 'Currency'
    Feesyear3,
    @Semantics.amount.currencyCode: 'Currency'
    Feesyear4,
    Currency,
    /* Associations */
    _Stud : redirected to parent zc_student
}
