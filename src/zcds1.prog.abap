REPORT zcds1.

START-OF-SELECTION.

  TRY.
      DATA(lo_alv) =
        cl_salv_gui_table_ida=>create_for_cds_view(
          'ZC_SHOW_REPORT_AGG' ).

      lo_alv->fullscreen( )->display( ).

  CATCH cx_root INTO DATA(lx_error).
      MESSAGE lx_error->get_text( ) TYPE 'E'.
  ENDTRY.
