REPORT zcds.

START-OF-SELECTION.

    TRY.
        " 建立 SALV IDA 實例：只指定一個 CDS View 名稱
        DATA(lo_alv) =
            cl_salv_gui_table_ida=>create_for_cds_view( 'ZC_SHOW_REPORT' ).

        " 直接交給前端展示
        lo_alv->fullscreen( )->display( ).

    CATCH cx_root INTO DATA(lx_error).
        " 例外處理與訊息輸出
        MESSAGE lx_error->get_text( ) TYPE 'E'.
    ENDTRY.
