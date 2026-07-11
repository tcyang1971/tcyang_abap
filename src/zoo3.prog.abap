REPORT zoo3.

"----------------------------------------------------------------------*
" 發送者（Sender）：劇團類別
"----------------------------------------------------------------------*
CLASS lcl_art_group DEFINITION.

    PUBLIC SECTION.
        EVENTS changed.

        METHODS set_type
            IMPORTING iv_type TYPE string.

    PRIVATE SECTION.
        DATA mv_type TYPE string.

ENDCLASS.

CLASS lcl_art_group IMPLEMENTATION.

    METHOD set_type.
        mv_type = iv_type.

        " 觸發事件（通知所有已註冊的 handler）
        RAISE EVENT changed.
    ENDMETHOD.

ENDCLASS.

"----------------------------------------------------------------------*
" 接收者（Receiver）：事件處理類別
"----------------------------------------------------------------------*
CLASS lcl_logger DEFINITION.

    PUBLIC SECTION.
        METHODS on_changed
            FOR EVENT changed OF lcl_art_group.

ENDCLASS.

CLASS lcl_logger IMPLEMENTATION.

    METHOD on_changed.
        WRITE: / '>>> 事件觸發：劇團型態變更'.
    ENDMETHOD.

ENDCLASS.

"----------------------------------------------------------------------*
" 執行區：動態註冊 + 觸發事件
"----------------------------------------------------------------------*
START-OF-SELECTION.

    DATA(lo_group) = NEW lcl_art_group( ).
    DATA(lo_logger) = NEW lcl_logger( ).

    " 動態註冊事件（訂閱）
    SET HANDLER lo_logger->on_changed FOR lo_group.

    " 觸發事件
    lo_group->set_type( '音樂劇團' ).
