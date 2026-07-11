@AbapCatalog.sqlViewName: 'ZSHOW_WORK1'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@Metadata.ignorePropagatedAnnotations: true

@EndUserText.label: '演出場次與作品關聯介面視圖'

define view ZI_SHOW_I
  as select from ZI_SHOW as Show     // 資料來源：演出場次基礎視圖
  
  /* 宣告到作品主檔的關聯：每一筆演出場次對應一部作品 [1..1] */
  association [1..1] to ZI_WORK as _Work 
    /* 使用 $projection 引用目前視圖已投影的欄位作為關聯條件 */
    on  $projection.ArtID    = _Work.ArtID 
    and $projection.WorkName = _Work.WorkName
{
  key ShowID,                        // 演出場次編號（主鍵）
      ArtID,                         // 劇團編號（外鍵）
      WorkName,                      // 作品名稱（外鍵）
      ShowDate,                      // 演出日期
      Venue,                         // 演出場地
      Audience,                      // 觀眾人數
      Revenue,                       // 票房收入
      Currency,                      // 幣別
      
      /* 關聯暴露：提供上層視圖進行資料存取 */
      _Work 
}
