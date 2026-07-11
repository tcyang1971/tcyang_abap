@AbapCatalog.sqlViewName: 'ZART_SQL_C'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED

@Metadata.ignorePropagatedAnnotations: true

@EndUserText.label: '藝文團體消費視圖'
define view ZC_ARTGROUP_REPORT as select from ZI_ARTGROUP_I // 資料來源為整合層 Interface View
{
  key ArtID        as GroupID,        // 報表專用識別欄位：劇團編號
      ArtName       as GroupName,      // 團體名稱
      ArtTypeName   as GroupCategory,  // 直接取用已完成語意轉換的類型名稱
      ArtURL        as WebsiteURL      // 轉譯為商務直觀命名：官方網站網址
}
