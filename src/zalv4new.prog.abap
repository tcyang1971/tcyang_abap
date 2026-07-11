REPORT ZALV4NEW.

"----------------------------------------------------------------------*
" Local Class：ALV Handler (Definition)
"----------------------------------------------------------------------*
CLASS lcl_alv_handler DEFINITION.
    PUBLIC SECTION.
        METHODS:
            fetch_data,
            display,
            handle_double_click
                FOR EVENT double_click OF cl_gui_alv_grid
                IMPORTING e_row e_column.

    PRIVATE SECTION.
        DATA:
            artResults TYPE TABLE OF zart,          " Model
            alvGrid    TYPE REF TO cl_gui_alv_grid, " View
            container  TYPE REF TO cl_gui_custom_container.
ENDCLASS.

"----------------------------------------------------------------------*
" Local Class：ALV Handler (Implementation)
"----------------------------------------------------------------------*
CLASS lcl_alv_handler IMPLEMENTATION.

    METHOD fetch_data.
        SELECT * FROM zart INTO TABLE @me->artResults.
    ENDMETHOD.

    METHOD display.
        " Lazy Instantiation
        IF me->alvGrid IS INITIAL.
            me->container = NEW cl_gui_custom_container(
                container_name = 'CC_ALV' ).
            me->alvGrid   = NEW cl_gui_alv_grid( i_parent = me->container ).
            SET HANDLER me->handle_double_click FOR me->alvGrid.
            me->alvGrid->set_table_for_first_display(
                EXPORTING i_structure_name = 'ZART'
                CHANGING  it_outtab        = me->artResults ).
        ELSE.
            me->alvGrid->refresh_table_display( ).
        ENDIF.
    ENDMETHOD.

    METHOD handle_double_click.
        READ TABLE me->artResults INTO DATA(ls_row) INDEX e_row-index.
        IF sy-subrc = 0.
        MESSAGE |您雙擊了第 { e_row-index } 列，| &&
            |欄位名稱: { e_column-fieldname }，|  &&
            |劇團名稱為: { ls_row-artname }| TYPE 'I'.
        ENDIF.
    ENDMETHOD.

ENDCLASS.

"----------------------------------------------------------------------*
" 全域資料
"----------------------------------------------------------------------*
DATA:
  ok_code TYPE sy-ucomm,
  alvApp  TYPE REF TO lcl_alv_handler.

"----------------------------------------------------------------------*
" 主流程
"----------------------------------------------------------------------*
START-OF-SELECTION.
    alvApp = NEW #( ).
    alvApp->fetch_data( ).
    CALL SCREEN 9000.

MODULE status_9000 OUTPUT.
    alvApp->display( ).
ENDMODULE.

MODULE user_command_9000 INPUT.
    CASE ok_code.
        WHEN 'BYE'.
            LEAVE PROGRAM.
    ENDCASE.
    CLEAR ok_code.
ENDMODULE.
