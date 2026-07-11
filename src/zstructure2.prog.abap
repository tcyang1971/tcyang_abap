REPORT zstructure2.

" 定義結構型態 (ts = Type Structure)
TYPES: BEGIN OF ts_art_info,
    id   TYPE c LENGTH 10,
    name TYPE c LENGTH 40,
    type TYPE c LENGTH 2,
END OF ts_art_info.

" 定義內表型態 (tt = Table Type)
TYPES tt_art TYPE TABLE OF ts_art_info WITH EMPTY KEY.

" 現代化初始化
" 直接使用 VALUE 運算子配合 tt_art 型態推導
DATA(lt_art) = VALUE tt_art(
    ( id = 'Godot'    name = '果陀劇場' type = 'MD' )
    ( id = 'GuoGuang' name = '國光劇團' type = 'TC' )
).

" 使用 SAP demo 類別輸出結果（自動以表格/清單顯示）
*cl_demo_output=>display( lt_art ).

" 輸出資料
*LOOP AT lt_art INTO DATA(art).
*    WRITE: / |ID: { art-id WIDTH = 10 } 名稱: { art-name WIDTH = 15 } 類型: { art-type }|.
*ENDLOOP.

" 使用 REDUCE 將內表內容進行字串累加
DATA(lv_output) = REDUCE string(
    INIT s = ``   " 反引號代表空字串，可避免固定長度截斷的問題
    FOR art IN lt_art
    NEXT s = s &&
        | ID: { art-id WIDTH = 10 } | &&
        | 名稱: { art-name WIDTH = 15 } | &&
        | 類型: { art-type } | &&
        cl_abap_char_utilities=>newline   " 換行字元
).

" 輸出結果
cl_demo_output=>display( lv_output ).
