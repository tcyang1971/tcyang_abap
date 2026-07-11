REPORT zreport1.

" 定義單一參數pArtType，必填
PARAMETERS pArtType TYPE zart-arttype OBLIGATORY.

" INITIALIZATION事件，於畫面顯示前執行，
" 展示如何根據系統變數(如日期)動態設定或修改參數值
INITIALIZATION.
    IF sy-datum > '20260101'.
        pArtType = 'TC'.
    ELSE.
        pArtType = 'MD'.
    ENDIF.

" AT SELECTION-SCREEN事件，進行輸入值合法性檢查，
" 利用MESSAGE阻止不正確的執行
AT SELECTION-SCREEN.
    IF pArtType <> 'MD' AND pArtType <> 'TC' AND pArtType <> 'CA'.
        MESSAGE '請輸入合法的劇團類別：MD / TC / CA' TYPE 'E'.
    ENDIF.

" START-OF-SELECTION事件，使用現代SQL與行內宣告讀取資料庫內容
START-OF-SELECTION.
    SELECT artId, artName, artUrl
      FROM zart
      WHERE artType = @pArtType
      INTO TABLE @DATA(artResults).

" END-OF-SELECTION事件，利用物件導向類別cl_demo_output自動產生HTML報表
END-OF-SELECTION.
    IF artResults IS NOT INITIAL.
        cl_demo_output=>display( artResults ).
    ELSE.
        cl_demo_output=>display( '查無相關劇團資料。' ).
    ENDIF.
