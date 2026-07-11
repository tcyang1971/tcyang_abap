REPORT zalv2.

START-OF-SELECTION.
    " 從資料表 ZART 讀取所有資料
    SELECT * FROM zart INTO TABLE @DATA(artResults).

    " 使用工廠方法建立 SALV 物件實例
    cl_salv_table=>factory(
        IMPORTING r_salv_table = DATA(alvTable)
        CHANGING  t_table      = artResults
    ).

    DATA(alvFunctions) = alvTable->get_functions( ).  " 取得工具列物件
    alvFunctions->set_all( abap_true ).  " 啟用排序、篩選等內建功能

    " 呼叫方法顯示報表畫面
    alvTable->display( ).
