@AccessControl.authorizationCheck: #NOT_ALLOWED
@EndUserText.label: 'Analytical Projection VIew'
@Metadata.ignorePropagatedAnnotations: true
define transient view entity zanalytical_proj_view
  provider contract analytical_query as projection on zi_student
{
    @AnalyticsDetails.query.axis: #ROWS
    Rollno,
    
    @AnalyticsDetails.query.axis: #COLUMNS
    Dept,
    
    @AnalyticsDetails.query.axis: #COLUMNS
    @Aggregation.default: #FORMULA
    @EndUserText.label: 'Exponential Age'
    power( base => Age, exponent => 2 ) as ExponentialAge
    
}
