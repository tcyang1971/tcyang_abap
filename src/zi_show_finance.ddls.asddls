@AbapCatalog.sqlViewName: 'ZSHOWFIN_SQL'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: '演出場次交易檔財務語意視圖'
@Metadata.ignorePropagatedAnnotations: true

define view ZI_SHOW_FINANCE as select from zshow
{
    /* 主鍵欄位，唯一識別演出場次 */
    key mandt,
    key artid,
    key workname,
    key showdate,
    key showtime,
    key venue,

    /* 觀眾人數 */
    audience,

    /* 將票房收入欄位與幣別欄位進行強關聯。
       系統可自動理解金額與幣別的關聯，用於報表計算與單位換算。 */ 
    @Semantics.amount.currencyCode: 'CURRENCY'
    revenue,

    /* 標記此欄位為標準 ISO 貨幣編號 (Currency Code) */
    @Semantics.currencyCode: true
    currency
}
