REPORT zreport3.

" 宣告參考變數，作為 SELECT-OPTIONS 型別來源
DATA artID   TYPE zwork-artid.
DATA artType TYPE zart-arttype.

" 定義選擇畫面區塊 b1，使用框線 (WITH FRAME) 與標題 (TITLE) 組織輸入欄位
SELECTION-SCREEN BEGIN OF BLOCK b1 WITH FRAME TITLE text-t01.
    " 使用 COMMENT 輸出說明文字，/1(60) 表示從第1格開始，寬度60
    SELECTION-SCREEN COMMENT /1(60) text-c01.
    " 輸出水平線與跳行
    SELECTION-SCREEN ULINE.
    SELECTION-SCREEN SKIP 1.

    "定義範圍選擇，套用 NO INTERVALS與 NO-EXTENSION簡化介面
    SELECT-OPTIONS: soArtid  FOR artID   NO INTERVALS NO-EXTENSION,
                                     soArttyp FOR artType NO INTERVALS NO-EXTENSION.
SELECTION-SCREEN END OF BLOCK b1.

START-OF-SELECTION.
    " 資料選取，使用 UPPER 函數實現「不分大小寫」搜尋
    SELECT artid, artname, arttype, arturl
        FROM zart
        WHERE artid IN @soArtid
        AND arttype        IN @soArttyp
        INTO TABLE @DATA(arts).

    " 判斷是否擷取到資料
    IF arts IS NOT INITIAL.

        " 輸出報表欄位標題。/1(10) 指定欄位起始位置與寬度
        " 使用 COLOR COL_HEADING (顏色編號 1) 呈現標準表頭藍色
        WRITE: /1(10) text-h01 COLOR COL_HEADING,
                    12(30) text-h02 COLOR COL_HEADING,
                    43(15) text-h03 COLOR COL_HEADING,
                    59     text-h04 COLOR COL_HEADING.
        ULINE.

        " 循環內表輸出內容，針對不同欄位屬性套用對應色彩強化可讀性
        LOOP AT arts INTO DATA(art).
            " ABAP 報表常用顏色應用示範
            " COL_KEY (4): 青色，用於主鍵
            WRITE: /1  art-artid   COLOR COL_KEY,
                        " COL_NORMAL (2): 淺色，用於一般描述
                        12 art-artname  COLOR COL_NORMAL,
                        " COL_GROUP (7): 紫/橙色，用於分組
                        43 art-arttype  COLOR COL_GROUP,
                        " COL_POSITIVE (5): 綠色，用於正確/正向連結
                        59 art-arturl   COLOR COL_POSITIVE.
        ENDLOOP .

    ELSE.
        " 當查無資料時顯示 Text Element 定義的錯誤訊息
        WRITE: / text-m01.
    ENDIF.





  .
