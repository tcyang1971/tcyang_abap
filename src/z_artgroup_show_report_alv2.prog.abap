REPORT z_artgroup_show_report_alv2.

DATA loAlv TYPE REF TO if_salv_gui_table_ida.

START-OF-SELECTION.
    TRY.
        " 以 CDS View 作為資料來源建立 IDA ALV
        loAlv = cl_salv_gui_table_ida=>create_for_cds_view(
            iv_cds_view_name = 'ZC_ART_SHOW_REPORT' ).

        " 全螢幕顯示 ALV
        loAlv->fullscreen( )->display( ).

    CATCH cx_salv_ida_contract_violation INTO DATA(lxError).
        MESSAGE lxError->get_text( ) TYPE 'E'.
    ENDTRY.
