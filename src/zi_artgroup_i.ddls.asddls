@AbapCatalog.sqlViewName: 'ZART_SQL_I'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@Metadata.ignorePropagatedAnnotations: true

@EndUserText.label: '藝文團體介面視圖'
define view ZI_ARTGROUP_I 
    as select from  ZI_ARTGROUP   // 資料來源為基礎層 Basic View
{
  key ArtID,
      ArtName,
      ArtType,
      ArtURL,

      // 語意轉換：集中於語意模型層處理
      case ArtType
        when 'MD' then '現代戲劇'
        when 'TC' then '傳統戲曲'
        when 'CA' then '馬戲雜技'
        else '其他'
      end as ArtTypeName   // 衍生出具備業務可讀性的類型名稱
}
