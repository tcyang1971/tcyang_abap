REPORT zreport2.

" 宣告年份變數，作為 SELECT-OPTIONS 的型別來源
DATA year TYPE zwork-premiere.

" 建立區間搜尋欄位 soYear
SELECT-OPTIONS soYear FOR year.

" 初始化事件：設定預設查詢範圍為2020至2024年區間
INITIALIZATION.
    soYear-sign = 'I'.
    soYear-option = 'BT'.
    soYear-low = '2020'.
    soYear-high = '2024'.
    APPEND soYear.


START-OF-SELECTION.
    " 查詢指定首演年份區間內的作品資料
    SELECT premiere, workname, duration, artId
        FROM zwork
        WHERE premiere IN @soYear
        ORDER BY premiere ASCENDING
        INTO TABLE @DATA(results).

END-OF-SELECTION.
    IF results IS NOT INITIAL.
        " 輸出查詢結果
        cl_demo_output=>write( results ).
        cl_demo_output=>display( ).
    ELSE.
         " 使用成功訊息類型，不會中斷程式流程
        " 但以錯誤樣式顯示提示訊息，
        MESSAGE '查詢範圍條件內無作品首演紀錄。'
            TYPE 'S'
            DISPLAY LIKE 'E'.
    ENDIF.
