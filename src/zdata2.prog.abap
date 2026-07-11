REPORT zdata2.

" 變數名稱移除 lv_ 前綴，使用 Snake Case 方式命名
" 內聯宣告 (Inline Declaration)：使用 |...| 確保自動推導為 string 型態
DATA(art_name) = |果陀劇場|.
DATA(art_type) = |MD|.

" 數值與常數：維持明確型態宣告，確保精確度並避免內聯宣告字面值的語法錯誤
DATA moon_to_earth_km TYPE i VALUE 384400.
CONSTANTS pi TYPE p DECIMALS 2 VALUE '3.14'.

" 字串處理 (String Templates)：使用 { ... } 嵌入變數
" 這種寫法比傳統 WRITE 分段輸出更易於維護，且可讀性更高
WRITE: / |劇團名稱：{ art_name } 劇團類型：{ art_type }|.
WRITE: / |月球到地球距離：{ moon_to_earth_km } 公里|.
WRITE: / |圓周率：{ pi }|.
