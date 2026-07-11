@AbapCatalog.sqlViewName: 'ZSHOW1'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: '演出場次票房（依幣別彙總）'
@Metadata.ignorePropagatedAnnotations: true
define view ZC_SHOW_REPORT_AGG
  as select from ZI_SHOW
{
    Currency,

    @Semantics.amount.currencyCode: 'Currency'
    sum( Revenue ) as TotalRevenue
}
group by Currency
