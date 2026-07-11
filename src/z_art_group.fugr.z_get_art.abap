FUNCTION Z_GET_ART.
*"----------------------------------------------------------------------
*"*"Local Interface:
*"  IMPORTING
*"     VALUE(ARTTYPE) TYPE  ZART-ARTTYPE
*"  EXPORTING
*"     VALUE(ARTRESULTS) TYPE  ZART_TBLTYPE
*"  EXCEPTIONS
*"      NO_DATA_FOUND
*"----------------------------------------------------------------------
  SELECT *
    FROM zart
    WHERE artType = @arttype
    INTO TABLE @artResults.


  IF sy-subrc <> 0.
    RAISE no_data_found.
  ENDIF.

ENDFUNCTION.
