@EndUserText.label: 'CDS Table Function'
@ClientHandling: {
    type: #CLIENT_DEPENDENT,
    algorithm: #SESSION_VARIABLE,
    clientSafe: true
}
define table function z_table_function
  with parameters
    i_rollno : abap.int1
returns
{
  client         : abap.clnt;
  rollnointernal : uuid;
  rollno         : zde_roll_no;
  feesyear1      : abap.curr(10,2);
  feesyear2      : abap.curr(10,2);
  feesyear3      : abap.curr(10,2);
  feesyear4      : abap.curr(10,2);
  currency       : abap.cuky;

}
implemented by method
  zcl_amdp_aug_26=>get_stud_fees_data;