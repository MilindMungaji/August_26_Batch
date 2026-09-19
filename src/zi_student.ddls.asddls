@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Student Interface View'
@Metadata.ignorePropagatedAnnotations: true
@Analytics.dataCategory: #CUBE
define view entity zi_student as select from zdb_student
{
    key rollnointernal as Rollnointernal,
    key rollno as Rollno,
    dept as Dept,
    firstname as Firstname,
    lastname as Lastname,
 
    //Calculate FUllname by concatenating firstname and lastname
    concat_with_space( firstname, lastname, 1 ) as Fullname,
    
    //Calculate length of Fullname
    length( concat_with_space( firstname, lastname, 1 ) ) as FullnameLength,
       
    length( $projection.Fullname ) as FullnameLength2,  
    
    //Convert Fullname to Uppercase
    upper( $projection.Fullname ) as FullnameUppercase,
    
    //Calculate age based on birthdate
    //datn_days_between( $session.system_date, birthdate ) / 365 as AgeCalculated,
    round( dats_days_between( birthdate, $session.system_date ) / 365 , 0) as AgeCalculated,
    
    //Calculate Age using Scalar Function
    ZSCALAR_FUN_CALCULATE_AGE( birthdate => birthdate ) as ScalarFuncAge,
    
    birthdate as Birthdate,
    emailid as Emailid,
    
    @AnalyticsDetails.query.axis: #COLUMNS
    @DefaultAggregation: #SUM
    age as Age,
    
    ( $projection.AgeCalculated + $projection.Age ) as SumAge,
    lastchanged as Lastchanged,
    createdby as Createdby,
    changedby as Changedby
}



