REPORT zstructure1 no standard page heading.

write:/ '傳統結構與內表初始化'.
uline.

" 定義結構型態 (ts = Type Structure)
TYPES: BEGIN OF ts_art_info,
    art_id   TYPE c LENGTH 10,
    art_name TYPE c LENGTH 40,
    art_type TYPE c LENGTH 2,
END OF ts_art_info.

" 定義內表型態 (tt = Table Type)
TYPES tt_art TYPE TABLE OF ts_art_info WITH EMPTY KEY.

" 宣告變數
DATA: ls_art TYPE ts_art_info,   " ls = Local Structure (Work Area)
      lt_art TYPE tt_art.                 " lt = Local Table

ls_art-art_id   = 'Godot'.
ls_art-art_name = '果陀劇場'.
ls_art-art_type = 'MD'.
APPEND ls_art TO lt_art.

ls_art-art_id   = 'GuoGuang'.
ls_art-art_name = '國光劇團'.
ls_art-art_type = 'TC'.
APPEND ls_art TO lt_art.

" 使用 LOOP AT 將內表資料一筆一筆讀取到 ls_art 結構中
LOOP AT lt_art INTO ls_art.
    WRITE: /  'ID:',   ls_art-art_id,
                    '名稱:', ls_art-art_name,
                    '類型:', ls_art-art_type.
ENDLOOP.
