@EndUserText.label: 'CDS Custom Entity'
@ObjectModel.query: {
    implementedBy: 'ABAP:ZCL_AMDP_AUG_26'
}
define custom entity zcds_custom_entity
// with parameters parameter_name : parameter_type
{
 key rollno         : zde_roll_no;
  @Semantics.amount.currencyCode : 'currency'
  feesyear1          : abap.curr(10,2);
  @Semantics.amount.currencyCode : 'currency'
  feesyear2          : abap.curr(10,2);
  @Semantics.amount.currencyCode : 'currency'
  feesyear3          : abap.curr(10,2);
  @Semantics.amount.currencyCode : 'currency'
  feesyear4          : abap.curr(10,2);
  @Semantics.amount.currencyCode : 'currency'
  totalfees          : abap.curr(10,2);
  dept               : zde_dept;
  currency           : abap.cuky;
  
}
