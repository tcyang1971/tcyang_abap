MODULE STATUS_9000 OUTPUT.
  " OO ALV 核心邏輯
  " 檢查 Grid 是否已存在，避免重複建立
  IF alvGrid IS INITIAL.
    " View 層: 建立自定義容器與 ALV Grid 控制項
    DATA(alvContainer)
      = NEW cl_gui_custom_container( container_name = 'CC_ALV' ).
    alvGrid = NEW cl_gui_alv_grid( i_parent = alvContainer ).

    " Model 層: 將內表資料與 ALV Grid 連結
    alvGrid->set_table_for_first_display(
      EXPORTING
        i_structure_name = 'ZART'   " 指定 DDIC 結構名稱
      CHANGING
        it_outtab        = artResults ). " 傳入內表資料
  ENDIF.
ENDMODULE.
