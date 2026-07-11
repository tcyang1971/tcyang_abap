*&---------------------------------------------------------------------*
*& Report zitab_demo
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zitab_demo.

TYPES: BEGIN OF ty_student,
         id   TYPE i,
         name TYPE string,
       END OF ty_student.

" 1. 定義三種不同類型的內表 (現代語法)
DATA: lt_standard TYPE STANDARD TABLE OF ty_student WITH EMPTY KEY,
      lt_sorted   TYPE SORTED TABLE OF ty_student WITH UNIQUE KEY id,
      lt_hashed   TYPE HASHED TABLE OF ty_student WITH UNIQUE KEY id.

" --- 插入資料操作 (INSERT / APPEND) ---

" Standard: 隨意插入，順序即為插入順序
APPEND VALUE #( id = 3 name = 'Alice' ) TO lt_standard.
APPEND VALUE #( id = 1 name = 'Bob' )   TO lt_standard.
APPEND VALUE #( id = 2 name = 'Cindy' ) TO lt_standard.

" Sorted: 自動根據 Key (ID) 排序，不論插入順序為何
INSERT VALUE #( id = 3 name = 'Alice' ) INTO TABLE lt_sorted.
INSERT VALUE #( id = 1 name = 'Bob' )   INTO TABLE lt_sorted.
INSERT VALUE #( id = 2 name = 'Cindy' ) INTO TABLE lt_sorted.

" Hashed: 無順序概念，純粹依雜湊值存放，必須使用 INSERT
INSERT VALUE #( id = 3 name = 'Alice' ) INTO TABLE lt_hashed.
INSERT VALUE #( id = 1 name = 'Bob' )   INTO TABLE lt_hashed.
INSERT VALUE #( id = 2 name = 'Cindy' ) INTO TABLE lt_hashed.

" --- 輸出結果展示差異 ---

WRITE: / 'Standard Table (Keep Order):'.
LOOP AT lt_standard INTO DATA(ls_std). WRITE: ls_std-id, ls_std-name. ENDLOOP.

WRITE: / 'Sorted Table (Auto Sorted by ID):'.
LOOP AT lt_sorted INTO DATA(ls_srt). WRITE: ls_srt-id, ls_srt-name. ENDLOOP.

" --- 讀取資料操作 (READ) ---

" 2. 讀取方式的差異
" Standard Table: 建議加上 BINARY SEARCH (前提是需手動先 SORT)
SORT lt_standard BY id.
READ TABLE lt_standard WITH KEY id = 1 BINARY SEARCH INTO DATA(ls_res1).

" Sorted Table: 自動使用 Binary Search，效率高
DATA(ls_res2) = lt_sorted[ id = 2 ]. " 使用 Table Expression (7.40 語法)

" Hashed Table: 使用 Hash Algorithm，在大數據量下最快
DATA(ls_res3) = lt_hashed[ id = 3 ].

WRITE: / 'Read Result from Hashed:', ls_res3-name.
