REPORT zoo4.

"----------------------------------------------------------------------*
" 介面：定義表演能力（Behavior Contract）
"----------------------------------------------------------------------*
INTERFACE lif_art_performer.

    METHODS perform
        RETURNING VALUE(rv_action) TYPE string.

ENDINTERFACE.

"----------------------------------------------------------------------*
" 音樂劇團：實作介面
"----------------------------------------------------------------------*
CLASS lcl_musical_group DEFINITION.

    PUBLIC SECTION.
        INTERFACES lif_art_performer.

ENDCLASS.

CLASS lcl_musical_group IMPLEMENTATION.

    METHOD lif_art_performer~perform.
        rv_action = '音樂劇團正在演唱經典劇目...'.
    ENDMETHOD.

ENDCLASS.

"----------------------------------------------------------------------*
" 舞蹈劇團：實作介面
"----------------------------------------------------------------------*
CLASS lcl_dance_group DEFINITION.

    PUBLIC SECTION.
        INTERFACES lif_art_performer.

ENDCLASS.

CLASS lcl_dance_group IMPLEMENTATION.

    METHOD lif_art_performer~perform.
        rv_action = '舞蹈劇團正在進行現代舞演出...'.
    ENDMETHOD.

ENDCLASS.

"----------------------------------------------------------------------*
" 多型：透過介面參考操作不同物件
"----------------------------------------------------------------------*
START-OF-SELECTION.

    DATA lt_performers TYPE TABLE OF REF TO lif_art_performer.

    APPEND NEW lcl_musical_group( ) TO lt_performers.
    APPEND NEW lcl_dance_group( ) TO lt_performers.

    LOOP AT lt_performers INTO DATA(lo_performer).
        WRITE: / lo_performer->perform( ).
    ENDLOOP.
