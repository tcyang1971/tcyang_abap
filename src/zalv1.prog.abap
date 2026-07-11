REPORT zalv1.

START-OF-SELECTION.
    " 從資料表 ZART 讀取所有資料
    SELECT * FROM zart INTO TABLE @DATA(artResults).

    " 呼叫傳統 ALV 函式顯示ALV報表
    CALL FUNCTION 'REUSE_ALV_GRID_DISPLAY'
        EXPORTING
            i_structure_name = 'ZART'   " 指定DDIC結構名稱
        TABLES
            t_outtab         = artResults.   " 傳入查詢到的內表
