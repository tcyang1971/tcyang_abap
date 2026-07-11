@AbapCatalog.sqlViewName: 'ZART_SHOW_RPT'
@AbapCatalog.compiler.compareFilter: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: '整合劇團、作品與演出資訊'
@Metadata.ignorePropagatedAnnotations: true

/* 自動發佈為 OData 服務，供外部應用存取 */
@OData.publish: true

/* Consumption View：整合劇團、作品與演出場次 */
define view ZC_ART_SHOW_REPORT

    as select from ZI_WORK_WITH_SHOWS as WorkShow

    /* 關聯至藝文團體 Interface View */
    association [1..1] to ZI_ARTGROUP_WITH_WORKS as _ArtGroup
        on $projection.ArtID = _ArtGroup.ArtID
{
    key WorkShow.mandt,       /* Client */
    key WorkShow.ArtID,       /* 劇團編號 */
    key WorkShow.WorkName,    /* 作品名稱 */

    /* 透過 Association 關聯取得並標註 UI 資訊 */
    @UI.lineItem: [{ position: 10, label: '劇團名稱' }]
    _ArtGroup.ArtName as ArtName,

    @UI.lineItem: [{ position: 20, label: '首演年份' }]
    WorkShow.Premiere as Premiere,


    @UI.lineItem: [{ position: 30, label: '演出日期' }]
    WorkShow._Shows.showdate as ShowDate,
    
    @UI.lineItem: [{ position: 40, label: '演出場地' }]
    WorkShow._Shows.venue    as Venue
}
