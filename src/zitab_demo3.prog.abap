REPORT zitab_demo3.

TYPES: BEGIN OF art_info,
    ArtId   TYPE c LENGTH 10,
    ArtName TYPE c LENGTH 40,
END OF art_info.

" 定義內表：使用語意化命名，展現各類型內表的技術意圖
DATA:
    arts            TYPE STANDARD TABLE OF art_info WITH EMPTY KEY,
    arts_sorted TYPE SORTED TABLE OF art_info WITH UNIQUE KEY ArtId,
    arts_map    TYPE HASHED TABLE OF art_info WITH UNIQUE KEY ArtId.

" ---------------------------------------------------------
" 1. 插入資料操作
" ---------------------------------------------------------

" Standard Table: 依指令順序存放，使用 APPEND 效能最優
APPEND VALUE #( ArtId = 'Godot'  ArtName = '果陀劇場' ) TO arts.
APPEND VALUE #( ArtId = 'StoryWorks'  ArtName =  '故事工廠' ) TO arts.
" 使用 Index 插入指定位置 (第一筆)
INSERT VALUE #( ArtId = 'GuoGuang'   ArtName  = '國光劇團' ) INTO arts INDEX 1.

" Sorted Table: 系統自動依 Key (ArtId) 進行物理排序並維護內部索引
INSERT VALUE #( ArtId = 'Godot'  ArtName = '果陀劇場' ) INTO TABLE arts_sorted.
INSERT VALUE #( ArtId = 'StoryWorks'  ArtName =  '故事工廠'  ) INTO TABLE arts_sorted.
INSERT VALUE #( ArtId = 'GuoGuang'  ArtName =  '國光劇團' ) INTO TABLE arts_sorted.

" Hashed Table: 依雜湊映射存放，存放位置由內部雜湊演算法管理
INSERT VALUE #( ArtId = 'Godot'  ArtName = '果陀劇場' ) INTO TABLE arts_map.
INSERT VALUE #( ArtId = 'StoryWorks'  ArtName =  '故事工廠' ) INTO TABLE arts_map.
INSERT VALUE #( ArtId = 'GuoGuang'  ArtName =  '國光劇團' ) INTO TABLE arts_map.

" ---------------------------------------------------------
" 2. 輸出結果與排序展示
" ---------------------------------------------------------

cl_demo_output=>write( '【資料排列順序比較】' ).
cl_demo_output=>write( 'Standard Table (維持原始插入順序)' ).
cl_demo_output=>write( arts ).

cl_demo_output=>write( 'Sorted Table (自動根據 Key (ArtId) 排序)' ).
cl_demo_output=>write( arts_sorted ).

cl_demo_output=>write( 'Hashed Table (無特定順序)' ).
cl_demo_output=>write( arts_map ).

" ---------------------------------------------------------
" 3. 讀取存取路徑對照 (Access Path Comparison)
" ---------------------------------------------------------
cl_demo_output=>write( '【讀取方式比較】' ).
DATA current_art TYPE art_info.

READ TABLE arts WITH KEY ArtId = 'GuoGuang' INTO current_art.
cl_demo_output=>write( 'Standard Table 採線性搜尋，效能較低' ).
cl_demo_output=>write( current_art ).

READ TABLE arts_sorted WITH KEY ArtId = 'Godot' INTO current_art.
cl_demo_output=>write( 'Sorted Table 依 Key 自動排序，Key 查詢時可使用 Binary Search' ).
cl_demo_output=>write( current_art ).

READ TABLE arts_map WITH KEY ArtId = 'StoryWorks' INTO current_art.
cl_demo_output=>write( 'Hashed Table 採雜湊檢索，效能取決於雜湊分布' ).
cl_demo_output=>write( current_art ).

" ---------------------------------------------------------
" 4. 修改與刪除操作 (Modify & Delete)
" ---------------------------------------------------------
cl_demo_output=>write( '【內表修改與刪除】' ).

" 針對 Standard Table 使用 INDEX 進行修改
MODIFY arts FROM VALUE #( ArtId = 'GuoGuang2' ArtName = '國光劇團2' ) INDEX 1.

" 針對 Standard Table 使用 WHERE 條件進行修改
MODIFY arts FROM VALUE #( ArtName = '故事工廠2' )
    TRANSPORTING ArtName
    WHERE ArtId = 'StoryWorks'.

" 針對 Standard Table 使用 WHERE 條件進行刪除
DELETE arts WHERE ArtId = 'Godot'.

cl_demo_output=>write( arts ).

cl_demo_output=>display( ).  " 輸出全部結果
