REPORT zoo1_var.

"----------------------------------------------------------------------*
" 類別定義：ArtGroup（領域物件）
"----------------------------------------------------------------------*
CLASS ArtGroup DEFINITION.
    PUBLIC SECTION.
        " 封裝後的查詢結果，僅供讀取
        DATA mvDetails TYPE zart READ-ONLY.

        " 建構子：可選初始化識別碼
        METHODS constructor
            IMPORTING ivId TYPE zart-artid OPTIONAL.

         " 行為方法：更新物件狀態並查詢資料
        METHODS fetchById
            IMPORTING ivId TYPE zart-artid
            RETURNING VALUE(rvIsFound) TYPE abap_bool.

        " 衍生行為：由目前狀態產生摘要文字
        METHODS getSummary
            RETURNING VALUE(rvSummary) TYPE string.

        PRIVATE SECTION.
            " 物件內部狀態：目前關注的劇團 ID
            DATA mvActiveId TYPE zart-artid.
ENDCLASS.

"----------------------------------------------------------------------*
" 類別實作
"----------------------------------------------------------------------*
CLASS ArtGroup IMPLEMENTATION.

    METHOD constructor.
        me->mvActiveId = ivId.
    ENDMETHOD.

    METHOD fetchById.
        " 更新物件內部狀態
        me->mvActiveId = ivId.

        " 根據目前狀態存取資料庫
        SELECT SINGLE *
            FROM zart
            INTO @me->mvDetails
            WHERE artid = @me->mvActiveId.

        " 回傳查詢結果
        rvIsFound = xsdbool( sy-subrc = 0 ).
    ENDMETHOD.

    METHOD getSummary.
        rvSummary = |劇團：{ me->mvDetails-artname } (編號：{ me->mvDetails-artid })|.
    ENDMETHOD.

ENDCLASS.

START-OF-SELECTION.
     " 建立本地類別物件
    DATA(loArtGroup) = NEW ArtGroup( ).

    " 查詢特定劇團，如Godot
    IF loArtGroup->fetchById( 'Godot' ).
        WRITE: / loArtGroup->getSummary( ).
    ELSE.
        MESSAGE '查無此劇團資訊' TYPE 'I'.
  ENDIF.

CLASS ltcl_artgroup_test DEFINITION FOR TESTING
    DURATION SHORT
    RISK LEVEL HARMLESS.

    PRIVATE SECTION.
        DATA moArt TYPE REF TO ArtGroup.
        METHODS setup.
        METHODS testFetchById FOR TESTING.
ENDCLASS.

CLASS ltcl_artgroup_test IMPLEMENTATION.
    METHOD setup.
        moArt = NEW ArtGroup( ).
    ENDMETHOD.

    METHOD testFetchById.
        cl_abap_unit_assert=>assert_true( act = moArt->fetchById( 'Godot' ) ).
        cl_abap_unit_assert=>assert_equals(
            act = moArt->getSummary( )
            exp = '劇團：果陀劇場 (編號：Godot)'
        ).
    ENDMETHOD.

ENDCLASS.
