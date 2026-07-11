@AbapCatalog.sqlViewName: 'ZWORK_SQL'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: '戲劇作品基礎視圖'
@Metadata.ignorePropagatedAnnotations: true
define view ZI_WORK
  as select from zwork
{
  key artid    as ArtID,         // 劇團編號 (主鍵 & 外鍵)
  key workname as WorkName,   // 作品名稱 (主鍵)
      premiere as Premiere,      // 首演年份
      duration as Duration       // 演出長度 (分鐘)
}
