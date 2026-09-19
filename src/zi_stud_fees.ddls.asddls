@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Fees Interface View'
@Metadata.ignorePropagatedAnnotations: true
define view entity zi_stud_fees 
//CDS with Input Parameters
with parameters
	p_currency : abap.cuky( 5 )

as select from zdb_stud_fees
{
    key rollnointernal as Rollnointernal,
    key rollno as Rollno,
    @Semantics.amount.currencyCode : 'Currency'
    feesyear1 as Feesyear1,
    @Semantics.amount.currencyCode : 'Currency'
    feesyear2 as Feesyear2,
    @Semantics.amount.currencyCode : 'Currency'
    feesyear3 as Feesyear3,
    @Semantics.amount.currencyCode : 'Currency'
    feesyear4 as Feesyear4,
    currency as Currency
   
   //Calculate Fees in local currency
  // @Semantics.amount.currencyCode : 'Currency'
//   currency_conversion( amount => feesyear1, 
//               source_currency => currency, 
//               target_currency =>  $parameters.p_currency, 
//               exchange_rate_date => $session.system_date ) as FeesInLocalCurrency
    }
where currency = $parameters.p_currency










