REPORT zoo2.

"----------------------------------------------------------------------*
" 父類別：封裝 + 基本行為
"----------------------------------------------------------------------*
CLASS lcl_art_group DEFINITION.

    PUBLIC SECTION.
        METHODS get_summary
            RETURNING VALUE(rv_text) TYPE string.

    PRIVATE SECTION.
        DATA mv_artid   TYPE string VALUE 'Godot'.
        DATA mv_artname TYPE string VALUE '果陀劇場'.
        DATA mv_type    TYPE string VALUE '現代戲劇'.

ENDCLASS.

CLASS lcl_art_group IMPLEMENTATION.

    METHOD get_summary.
        rv_text = |類型：{ mv_type }（{ mv_artname }，編號：{ mv_artid }）|.
    ENDMETHOD.

ENDCLASS.

"----------------------------------------------------------------------*
" 子類別：繼承 + 覆寫
"----------------------------------------------------------------------*
CLASS lcl_musical_group DEFINITION
    INHERITING FROM lcl_art_group.

    PUBLIC SECTION.
        METHODS get_summary REDEFINITION.

ENDCLASS.

CLASS lcl_musical_group IMPLEMENTATION.

  METHOD get_summary.
    rv_text = |{ super->get_summary( ) } - 具備大型歌舞編排能力|.
  ENDMETHOD.

ENDCLASS.

"----------------------------------------------------------------------*
" 多型
"----------------------------------------------------------------------*
START-OF-SELECTION.

    DATA lo_group TYPE REF TO lcl_art_group.

    lo_group = NEW lcl_art_group( ).
    WRITE: / lo_group->get_summary( ).

    lo_group = NEW lcl_musical_group( ).
    WRITE: / lo_group->get_summary( ).
