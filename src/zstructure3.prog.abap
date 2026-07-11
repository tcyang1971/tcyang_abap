REPORT zstructure3.

" 定義結構型態 (使用簡潔的欄位名稱)
TYPES: BEGIN OF art_info,
    id   TYPE c LENGTH 10,
    name TYPE c LENGTH 40,
    type TYPE c LENGTH 2,
END OF art_info.

" 定義內表型態，方便後續 VALUE 運算子推導
TYPES art_table TYPE TABLE OF art_info WITH EMPTY KEY.

" 現代化初始化 (使用簡化變數名 arts)
" 直接在括號內定義多筆資料
DATA(arts) = VALUE art_table(
    ( id = 'Godot'    name = '果陀劇場' type = 'MD' )
    ( id = 'GuoGuang' name = '國光劇團' type = 'TC' )
).

" 使用 REDUCE 將內表內容進行字串累加
DATA(lv_output) = REDUCE string(
    INIT s = ``   " 反引號代表空字串，可避免固定長度截斷的問題
    FOR art IN arts
    NEXT s = s &&
        | ID: { art-id WIDTH = 10 } | &&
        | 名稱: { art-name WIDTH = 15 } | &&
        | 類型: { art-type } | &&
        cl_abap_char_utilities=>newline   " 換行字元
).

" 輸出結果
cl_demo_output=>display( lv_output ).
