@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'CDS domain Value help'
@Metadata.ignorePropagatedAnnotations: true
define view entity ZCDS_DOMAIN_F4 as select from DDCDS_CUSTOMER_DOMAIN_VALUE_T ( p_domain_name : 'ZDO_STUD_DEPARTMENT' )
{
    key domain_name,
    key value_position,
    key language,
    value_low,
    text
}
