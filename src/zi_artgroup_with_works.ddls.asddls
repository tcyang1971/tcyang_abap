@AbapCatalog.sqlViewName: 'ZART_WORK_SQL'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: '藝文團體與戲劇作品關聯視圖'

/* Metadata 設定：保留並繼承底層資料來源所傳遞的 Metadata 註解 */
@Metadata.ignorePropagatedAnnotations: false

/* 定義 CDS View，名稱為ZI_ARTGROUP_WITH_WORKS */
define view ZI_ARTGROUP_WITH_WORKS
    /* 指定資料來源表 zart，並設定別名為 ArtGroup */
    as select from zart as ArtGroup

    /* Association：建立藝文團體與作品的一對多關聯 */
    /* [0..*] 表示一個劇團團體可能對應 0 到多筆作品 */
    association [0..*] to zwork as _Works

    /* 關聯條件：以團體編號 ArtID 與作品表 artid 進行關聯 */
    /* $projection 代表目前 View 投影出的欄位 */
    on $projection.ArtID = _Works.artid

{
    key ArtGroup.artid   as ArtID,        /* 劇團編號 (主鍵) */
        ArtGroup.artname as ArtName,   /* 劇團名稱 */
        ArtGroup.arttype as ArtType,      /* 劇團類型 */

    /* 暴露作品關聯，讓上層 CDS 或應用程式可以存取作品資料 */
         _Works
}
