*&---------------------------------------------------------------------*
*& Report zcall_fm
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zcall_fm.

PARAMETERS pType TYPE zart-arttype OBLIGATORY DEFAULT 'TC'.
DATA: results TYPE zart_tbltype.

START-OF-SELECTION.

    CALL FUNCTION 'Z_GET_ART1'
        EXPORTING
            arttype        = pType
        IMPORTING
            artresults     = results
    EXCEPTIONS
      no_data_found  = 1
      OTHERS         = 2.

    CASE sy-subrc.
        WHEN 0.
            cl_demo_output=>display( results ).

        WHEN 1.
            MESSAGE '查無相關劇團資料，請重新輸入類型。' TYPE 'S' DISPLAY LIKE 'E'.

        WHEN OTHERS.
            MESSAGE '系統執行異常，請聯絡系統管理員。' TYPE 'E'.
  ENDCASE.
