REPORT zoo1.

"----------------------------------------------------------------------*
" 類別定義
"----------------------------------------------------------------------*
CLASS lcl_art_group DEFINITION.

    PUBLIC SECTION.
        " 封裝後的查詢結果，僅供外部讀取 (Read-Only)
        DATA mv_details TYPE zart READ-ONLY.

        " 建構子：可選初始化識別碼
        METHODS constructor
            IMPORTING
                iv_id TYPE zart-artid OPTIONAL.

        " 行為方法：更新物件狀態並查詢資料
        METHODS fetch_by_id
            IMPORTING
                iv_id            TYPE zart-artid
            RETURNING
                VALUE(rv_is_found) TYPE abap_bool.

        " 衍生行為：由目前狀態產生摘要文字
        METHODS get_summary
            RETURNING
                VALUE(rv_summary) TYPE string.

    PRIVATE SECTION.
        " 物件內部狀態：目前關注的劇團 ID
        DATA mv_active_id TYPE zart-artid.

ENDCLASS.

"----------------------------------------------------------------------*
" 類別實作
"----------------------------------------------------------------------*
CLASS lcl_art_group IMPLEMENTATION.

    METHOD constructor.
        me->mv_active_id = iv_id.
    ENDMETHOD.

    METHOD fetch_by_id.
        " 更新物件內部狀態
        me->mv_active_id = iv_id.

        " 根據目前狀態存取資料庫
        SELECT SINGLE *
            FROM zart
            INTO @me->mv_details
            WHERE artid = @me->mv_active_id.

        " 回傳查詢結果
        rv_is_found = xsdbool( sy-subrc = 0 ).
    ENDMETHOD.

    METHOD get_summary.
        " 使用 mv_details 存取內部欄位
        rv_summary = |劇團：{ me->mv_details-artname } (編號：{ me->mv_details-artid })|.
    ENDMETHOD.

ENDCLASS.

"----------------------------------------------------------------------*
" 報表執行 (主流程)
"----------------------------------------------------------------------*
START-OF-SELECTION.
    " 建立本地類別物件
    DATA(lo_art_group) = NEW lcl_art_group( ).

    " 查詢特定劇團，如 Godot
    IF lo_art_group->fetch_by_id( 'Godot' ).
        WRITE: / lo_art_group->get_summary( ).
    ELSE.
        MESSAGE '查無此劇團資訊' TYPE 'I'.
    ENDIF.

 "----------------------------------------------------------------------*
" 測試類別定義
"----------------------------------------------------------------------*
" ltcl_ = Local Test Class (本地測試類別，用於隔離並編寫自動化測試邏輯)
CLASS ltcl_art_group_test DEFINITION FOR TESTING
    DURATION SHORT
    RISK LEVEL HARMLESS.

    PRIVATE SECTION.
        DATA mo_art TYPE REF TO lcl_art_group.  " 受測物件

        METHODS setup.  " 測試前置作業：注入測試資料
        METHODS test_fetch_by_id FOR TESTING.  " 測試方法
ENDCLASS.

"----------------------------------------------------------------------*
" 測試類別實作
"----------------------------------------------------------------------*
CLASS ltcl_art_group_test IMPLEMENTATION.
    METHOD setup.
        mo_art = NEW lcl_art_group( ).
    ENDMETHOD.

    METHOD  test_fetch_by_id.
        cl_abap_unit_assert=>assert_true( act = mo_art->fetch_by_id( 'Godo' ) ).
        cl_abap_unit_assert=>assert_equals(
            act = mo_art->get_summary( )
            exp = '劇團：果陀劇場 (編號：Godot)'
        ).
    ENDMETHOD.

ENDCLASS.
