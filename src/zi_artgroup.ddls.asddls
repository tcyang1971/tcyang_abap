@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@Metadata.ignorePropagatedAnnotations: true

@AbapCatalog.sqlViewName: 'ZART_SQL'   // DDIC SQL View 名稱（資料字典層）
@EndUserText.label: '藝文團體基礎視圖'   // 定義 CDS 視圖的業務語意名稱

define view ZI_ARTGROUP
  as select from zart                // 指定資料來源資料表
{
  key artid   as ArtID,             // 劇團編號（主鍵欄位）
      artname as ArtName,         // 劇團名稱
      arttype as ArtType,          // 劇團類型
      arturl  as ArtURL          // 劇團網址
}

