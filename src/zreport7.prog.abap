REPORT zreport7.


PARAMETERS pArtType TYPE zart-arttype OBLIGATORY DEFAULT 'MD'.

INITIALIZATION.
  IF sy-datum > '20260101'.
    pArtType = 'TC'.
  ELSE.
    pArtType = 'MD'.
  ENDIF.

AT SELECTION-SCREEN.
  IF pArtType <> 'MD' AND pArtType <> 'TC' AND pArtType <> 'CA'.
    MESSAGE '請輸入合法的劇團類別：MD / TC / CA' TYPE 'E'.
  ENDIF.

START-OF-SELECTION.
  DATA: artResults TYPE TABLE OF zart.

  PERFORM fetchData USING pArtType
                    CHANGING artResults.

  PERFORM displayOutput USING artResults.


FORM fetchData USING    ivArtType TYPE zart-arttype
               CHANGING ctResults TYPE ANY TABLE.
  SELECT artid, artname, arturl
    FROM zart
    WHERE arttype = @ivArtType
    INTO TABLE @ctResults.
ENDFORM.


FORM displayOutput USING itResults TYPE ANY TABLE.
  IF itResults IS NOT INITIAL.
    cl_demo_output=>write( itResults ).
    cl_demo_output=>display( ).
  ELSE.
    MESSAGE '查無相關劇團資料。' TYPE 'S' DISPLAY LIKE 'E'.
  ENDIF.
ENDFORM.
