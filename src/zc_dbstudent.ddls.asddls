@Metadata.allowExtensions: true
@Metadata.ignorePropagatedAnnotations: true
@Endusertext: {
  Label: '###GENERATED Core Data Service Entity'
}
@Objectmodel: {
  Sapobjectnodetype.Name: 'ZDBSTUDENT'
}
@AccessControl.authorizationCheck: #MANDATORY
define root view entity ZC_DBSTUDENT
  provider contract TRANSACTIONAL_QUERY
  as projection on ZR_DBSTUDENT
  association [1..1] to ZR_DBSTUDENT as _BaseEntity on $projection.ROLLNOINTERNAL = _BaseEntity.ROLLNOINTERNAL and $projection.ROLLNO = _BaseEntity.ROLLNO
{
  key Rollnointernal,
  key Rollno,
  Dept,
  Firstname,
  Lastname,
  Birthdate,
  Emailid,
  Age,
  @Semantics: {
    Systemdatetime.Localinstancelastchangedat: true
  }
  Lastchanged,
  @Semantics: {
    User.Createdby: true
  }
  Createdby,
  @Semantics: {
    User.Lastchangedby: true
  }
  Changedby,
  _BaseEntity
}
