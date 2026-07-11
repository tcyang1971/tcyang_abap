@AbapCatalog.sqlViewName: 'ZC_SHOW_R'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@Metadata.ignorePropagatedAnnotations: true
@EndUserText.label: '演出場次明細消費視圖'

define view ZC_SHOW_REPORT
  as select from ZI_SHOW_I           // 資料來源：整合層關聯視圖
{
  key ShowID,                        // 演出場次編號
  
        @EndUserText.label: '演出日期'
      ShowDate,                      // 演出日期
      
      @EndUserText.label: '演出場地'
      Venue,                         // 演出場地
      
      @EndUserText.label: '作品名稱'
      _Work.WorkName as PerformanceName, 
      
      @EndUserText.label: '演出長度(分鐘)'
      _Work.Duration as PlayDuration, 
       
      /* 覆蓋標註：承襲底層幣別綁定，並覆蓋顯示標籤為「當場票房總收益」 */
      @Semantics.amount.currencyCode: 'Currency'
      @EndUserText.label: '當場票房總收益'
      Revenue,                       
       
      Currency                      // 自動承襲為標準幣別欄位

}

