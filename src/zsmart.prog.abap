REPORT zsmart.

DATA: artData TYPE zart_tbltype,
            fmName  TYPE rs38l_fnam.

SELECT mandt, artid, artname, arttype, arturl
    FROM zart
    INTO TABLE @artData.

IF sy-subrc <> 0.
    MESSAGE '查無劇團資料' TYPE 'I'.
    RETURN.
ENDIF.

CALL FUNCTION 'SSF_FUNCTION_MODULE_NAME'
    EXPORTING formname = 'ZART_FORM1'
    IMPORTING fm_name  = fmName
    EXCEPTIONS others  = 1.

IF sy-subrc <> 0.
    MESSAGE '找不到指定的 Smart Form' TYPE 'E'.
ENDIF.

CALL FUNCTION fmName
    EXPORTING IT_ART = artData
    EXCEPTIONS others = 1.

IF sy-subrc <> 0.
    MESSAGE '報表產生失敗' TYPE 'E'.
ENDIF.
