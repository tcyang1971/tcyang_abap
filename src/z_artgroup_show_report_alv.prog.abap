REPORT z_artgroup_show_report_alv.

DATA: ltData TYPE TABLE OF ZC_ART_SHOW_REPORT,  " 宣告內表
            loAlv TYPE REF TO cl_salv_table.         " ALV 類別的實例

START-OF-SELECTION.
    TRY.
        " 從 CDS View讀取資料
        SELECT artid, workname, artname, premiere, showdate, venue
            FROM ZC_ART_SHOW_REPORT
            INTO TABLE @ltData.

        " 創建 ALV 顯示對象
        CALL METHOD cl_salv_table=>factory
            IMPORTING
                r_salv_table = loAlv
            CHANGING
                t_table = ltData.  " 將資料傳遞給 ALV

        " 顯示 ALV 報表
        loAlv->display( ).  " 顯示 ALV 報表

    CATCH cx_salv_error INTO DATA(lx_error).
        MESSAGE lx_error->get_text( ) TYPE 'E'.
    ENDTRY.
