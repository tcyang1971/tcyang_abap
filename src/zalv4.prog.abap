REPORT zalv4.

* Local Class 定義與實作
CLASS lcl_alv_handler DEFINITION.
  PUBLIC SECTION.
    METHODS:
      fetchData,
      display,
      " 定義事件處理方法
      handle_double_click FOR EVENT double_click OF cl_gui_alv_grid
        IMPORTING e_row e_column.

  PRIVATE SECTION.
    DATA: artResults TYPE TABLE OF zart,      " 資料模型 (Model)
          alvGrid    TYPE REF TO cl_gui_alv_grid,  " View 控制項
          container  TYPE REF TO cl_gui_custom_container.
ENDCLASS.

CLASS lcl_alv_handler IMPLEMENTATION.
  METHOD fetchData.
    " 業務邏輯：從資料表讀取資料並存入成員變數
    SELECT * FROM zart INTO TABLE @me->artResults.
  ENDMETHOD.

  METHOD display.
    " 實踐延遲實例化：確保在 PBO 時才初始化 UI
    IF me->alvGrid IS INITIAL.
      " 使用 NEW #( ) 自動推導型別，減少冗餘宣告
      me->container = NEW #( container_name = 'CC_ALV' ).
      me->alvGrid   = NEW #( i_parent = me->container ).

      " 註冊事件：告訴系統當雙擊發生時，由我這個物件來處理
      SET HANDLER me->handle_double_click FOR me->alvGrid.

      me->alvGrid->set_table_for_first_display(
        EXPORTING i_structure_name = 'ZART'
        CHANGING  it_outtab        = me->artResults ).
    ELSE.
      " 若物件已存在，則僅刷新資料，符合 SAP 運作生命週期
      me->alvGrid->refresh_table_display( ).
    ENDIF.
  ENDMETHOD.

  " 實作事件邏輯：Controller 捕捉互動並決定後續行為
  METHOD handle_double_click.
    READ TABLE artResults INTO DATA(ls_data) INDEX e_row-index.
    IF sy-subrc = 0.
      MESSAGE |您點選了第 { e_row-index } 列，劇團名稱為：{ ls_data-ArtName }| TYPE 'I'.
    ENDIF.
  ENDMETHOD.
ENDCLASS.

" 全域資料宣告
DATA: OK_CODE LIKE SY-UCOMM,
      alvMain TYPE REF TO lcl_alv_handler.

" 程式進入點
START-OF-SELECTION.
  alvMain = NEW #( ).      " 實例化 Handler，不必關心 UI 細節
  alvMain->fetchData( ).   " 準備資料
  CALL SCREEN 9000.        " 啟動畫面流程


INCLUDE ZALV4_STATUS_9000O01.

INCLUDE ZALV4_USER_COMMAND_9000I01.
