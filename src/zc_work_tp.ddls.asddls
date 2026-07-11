@AbapCatalog.sqlViewName: 'ZC_SQL_WORK_TP'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: '戲劇作品消費視圖'
@Metadata.ignorePropagatedAnnotations: true
define view ZC_WORK_TP 
    as select from ZR_WORK
{  @UI.facet: [ { id: 'Work', type: #IDENTIFICATION_REFERENCE, label: '作品資料' } ]

  @UI.lineItem: [ { position: 10, label: '劇團編號' } ]
  key ArtID,
  
  @UI.lineItem: [ { position: 20, label: '作品名稱' } ]
  key WorkName,
  
  @UI.lineItem: [ { position: 30, label: '首演年份' } ]
  Premiere,
  
  @UI.lineItem: [ { position: 40, label: '演出長度(分)' } ]
  Duration


}
