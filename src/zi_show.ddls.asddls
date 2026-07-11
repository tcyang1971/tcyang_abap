@AbapCatalog.sqlViewName: 'ZSHOW_SQL'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@Metadata.ignorePropagatedAnnotations: true

@EndUserText.label: '演出場次基礎視圖'

define view ZI_SHOW
  as select from zshow
{
  key showid   as ShowID,   // 演出場次編號 (主鍵)
      artid    as ArtID,    // 劇團編號 (外鍵)
      workname as WorkName, // 作品名稱 (外鍵)
      showdate as ShowDate, // 演出日期
      showtime as ShowTime, // 演出時間
      venue    as Venue,    // 演出場地
      audience as Audience, // 觀眾人數
      
      /* 語意標註：宣告此欄位為金額，並綁定對應的幣別別名 'Currency' */
      @Semantics.amount.currencyCode: 'Currency'
      revenue  as Revenue,  // 票房收入 (金額欄位)
       
      /* 語意標註：宣告此欄位為標準的 ISO 幣別代碼 */
      @Semantics.currencyCode: true
      currency as Currency  // 幣別 (ISO currency key, referenced by amount field)
}
