@AbapCatalog.sqlViewName: 'ZR_SQL_WORK'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: '戲劇作品根視圖v2'
@Metadata.ignorePropagatedAnnotations: true

define root view ZR_WORK as select from zwork
{
  key artid    as ArtID,
  key workname as WorkName,
      premiere as Premiere,
      duration as Duration
}

