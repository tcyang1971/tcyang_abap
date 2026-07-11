REPORT zdata1.

" 宣告 lv_art_name 變數為字串型態，lv 是指區域變數 (Local Variable)
DATA lv_art_name TYPE string.

" 設定 lv_art_name 變數值，ABAP 的字串以單引號括起來
lv_art_name = '果陀劇場'.

" 宣告 lv_art_type 變數為 2 個字元，並用 VALUE 關鍵字直接設定初始值
DATA lv_art_type TYPE c LENGTH 2 VALUE 'MD'.

" 宣告 lv_moon_to_earth_km 變數為整數型態，並設定初始值
DATA lv_moon_to_earth_km TYPE i VALUE 384400.

" 設定 lc_pi 常數為封裝數值 (Packed Number)，有 2 個小數位數
" lc 是指區域常數 (Local Constant)
CONSTANTS lc_pi TYPE p DECIMALS 2 VALUE '3.14'.

" 輸出資料
" 冒號 (:) 是連鎖指令，將多個重複指令合併；斜線 (/) 為換行符號
WRITE: / '劇團名稱：', lv_art_name, '劇團類型：', lv_art_type.
WRITE: / '月球到地球距離：', lv_moon_to_earth_km, '公里'.
WRITE: / '圓周率：', lc_pi.
