REPORT ZALV3NEW.

"----------------------------------------------------------------------*
* 全域資料宣告
"----------------------------------------------------------------------*
DATA: ok_code      LIKE sy-ucomm,
      alvContainer TYPE REF TO cl_gui_custom_container,
      alvGrid      TYPE REF TO cl_gui_alv_grid,
      artResults   TYPE TABLE OF zart.

"----------------------------------------------------------------------*
* 程式進入點
"----------------------------------------------------------------------*
START-OF-SELECTION.

  " Model：從資料表讀取資料
  SELECT *
    FROM zart
    INTO TABLE @artResults.

  " View：呼叫自訂畫面
  CALL SCREEN 9000.

"----------------------------------------------------------------------*
" Screen 9000 PBO (Process Before Output)
"----------------------------------------------------------------------*
MODULE STATUS_9000 OUTPUT.
  " Controller: 檢查 Grid 是否已存在，避免重複建立控制項
  IF alvGrid IS INITIAL.

    " View：建立自訂容器（Custom Container）
    alvContainer = NEW cl_gui_custom_container(
                      container_name = 'CC_ALV' ).

    " View：建立 ALV Grid 控制項
    alvGrid = NEW cl_gui_alv_grid(
                  i_parent = alvContainer ).

    " Model → View： 將內表資料繫結至 ALV Grid
    alvGrid->set_table_for_first_display(
      EXPORTING
        i_structure_name = 'ZART'     " DDIC 結構名稱
      CHANGING
        it_outtab        = artResults ).

  ENDIF.
ENDMODULE.

"----------------------------------------------------------------------*
" Screen 9000 PAI (Process After Input)
"----------------------------------------------------------------------*
MODULE USER_COMMAND_9000 INPUT.
  " Controller： 處理使用者操作事件
  CASE ok_code.
    WHEN 'BYE'.
      LEAVE PROGRAM.
  ENDCASE.

  " 清除功能碼
  CLEAR ok_code.
ENDMODULE.
