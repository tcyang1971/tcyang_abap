@AbapCatalog.sqlViewName: 'ZWORK_SHOW_SQL'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: '戲劇作品與演出場次關聯視圖'

/* Metadata 設定：保留並繼承底層資料來源所傳遞的 Metadata 註解 */
@Metadata.ignorePropagatedAnnotations: false

/* 定義 CDS View，名稱為ZI_WORK_WITH_SHOWS */
define view ZI_WORK_WITH_SHOWS
    /* 指定資料來源表 zwork，並設定別名為 Work */
    as select from zwork as Work

    /* Association：建立戲劇作品與演出場次的一對多關聯 */
    /* [0..*] 表示一齣戲劇作品可能對應 0 到多筆演出場次 */
    association [0..*] to zshow as _Shows

    /* 關聯條件 */
    on  $projection.Mandt    = _Shows.mandt
    and $projection.ArtID    = _Shows.artid
    and $projection.WorkName = _Shows.workname
{
    key Work.mandt    as Mandt,     /* 客戶端 (Key) */
    key Work.artid    as ArtID,     /* 劇團編號 (Key) */
    key Work.workname as WorkName,  /* 作品名稱 (Key) */
        
        Work.premiere as Premiere,  /* 首演年份 */
        Work.duration as Duration,  /* 演出長度 */

    /* 暴露演出關聯 */
    _Shows
}
