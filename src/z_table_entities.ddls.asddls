@ClientHandling.type: #CLIENT_DEPENDENT
@AbapCatalog.deliveryClass: #APPLICATION_DATA
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'CDS Table Entities'
define table entity z_table_entities
{
  key rollno : abap.int1;
      dept : zcds_simple_type;
      
}
