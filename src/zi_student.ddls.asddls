@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Student Interface View'
@Metadata.ignorePropagatedAnnotations: true
@AbapCatalog.entityBuffer.definitionAllowed: true
//@Analytics.dataCategory: #CUBE
define root view entity zi_student
  as select from zdb_student
//  association [1..*] to zi_academy as _Acad1 on  $projection.Rollnointernal = _Acad1.Rollnointernal
//                                            and $projection.Rollno         = _Acad1.Rollno
//
//  association [1..1] to zi_fees    as _Fees1 on  $projection.Rollnointernal = _Fees1.Rollnointernal
//                                            and $projection.Rollno         = _Fees1.Rollno
    

  //CDS Exact Cardinalities - exact one to many                                         
  composition of exact one to many zi_academy as _Acad

  composition of exact one to one zi_fees as _Fees              
  
//  bind aspect z_cds_aspect( changedby => zdb_student.changedby, 
//                            createdby => zdb_student.createdby, 
//                            lastchanged =>  zdb_student.lastchanged )                     
{
  key rollnointernal                                                         as Rollnointernal,
  key rollno                                                                 as Rollno,
      dept                                                                   as Dept,
      firstname                                                              as Firstname,
      lastname                                                               as Lastname,

      //Calculate FUllname by concatenating firstname and lastname
      concat_with_space( firstname, lastname, 1 )                            as Fullname,

      //Calculate length of Fullname
      length( concat_with_space( firstname, lastname, 1 ) )                  as FullnameLength,

      length( $projection.Fullname )                                         as FullnameLength2,

      //Convert Fullname to Uppercase
      upper( $projection.Fullname )                                          as FullnameUppercase,

      //Calculate age based on birthdate
      //datn_days_between( $session.system_date, birthdate ) / 365 as AgeCalculated,
      //round( dats_days_between( birthdate, $session.system_date ) / 365 , 0) as AgeCalculated,

      //Calculate Age using Scalar Function
      //ZSCALAR_FUN_CALCULATE_AGE( birthdate => birthdate )                    as ScalarFuncAge,

      birthdate                                                              as Birthdate,
      emailid                                                                as Emailid,

      //@AnalyticsDetails.query.axis: #COLUMNS
      //@DefaultAggregation: #SUM
      age                                                                    as Age,

      //( $projection.AgeCalculated + $projection.Age )                        as SumAge,
      lastchanged                                                            as Lastchanged,
      createdby                                                              as Createdby,
      changedby                                                              as Changedby,
//        include z_cds_aspect. * excluding {lastchanged},
      //Expose the Associations
      _Acad,
      _Fees
}
