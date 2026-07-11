@AbapCatalog.sqlViewName: 'ZARTUI_SQL' 
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: '藝文團體 UI 呈現配置視圖'
@Metadata.ignorePropagatedAnnotations: true

define view ZC_ARTGROUP_UI as select from ZI_ARTGROUP
{
    /* @UI.lineItem: 定義欄位在 Fiori List Report 的顯示欄位與順序。
        @UI.selectionField: 將欄位設為搜尋篩選條件，自動生成查詢框。
        position: 數值越小，欄位越靠左。 */
    @UI.lineItem: [{ position: 10, label: '劇團編號' }]
    @UI.selectionField: [{ position: 10 }]
    key ArtID,

    /* @UI.lineItem: 劇團名稱顯示於列表。
        @UI.identification: 劇團名稱在 Object Page 詳細頁的呈現位置與重要性。 */
    @UI.lineItem: [{ position: 20, label: '劇團名稱' }]
    @UI.identification: [{ position: 10 }]
    ArtName,

    /* @UI.lineItem: 劇團類型為列表報表的第三個欄位。 */
    @UI.lineItem: [{ position: 30, label: '劇團類型' }]
    ArtType
}
