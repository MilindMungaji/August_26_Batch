@AccessControl.authorizationCheck: #MANDATORY
@Metadata.allowExtensions: true
@ObjectModel.sapObjectNodeType.name: 'ZDBSTUDENT'
@EndUserText.label: '###GENERATED Core Data Service Entity'
define root view entity ZR_DBSTUDENT
  as select from ZDB_STUDENT
{
  key rollnointernal as Rollnointernal,
  key rollno as Rollno,
  dept as Dept,
  firstname as Firstname,
  lastname as Lastname,
  birthdate as Birthdate,
  emailid as Emailid,
  age as Age,
  @Semantics.systemDateTime.localInstanceLastChangedAt: true
  lastchanged as Lastchanged,
  @Semantics.user.createdBy: true
  createdby as Createdby,
  @Semantics.user.lastChangedBy: true
  changedby as Changedby
}
