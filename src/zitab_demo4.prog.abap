REPORT zitab_demo4.

"--------------------------------------------------------
" 1. 定義資料模型
"--------------------------------------------------------
TYPES: BEGIN OF art_info,
                ArtId   TYPE c LENGTH 10,
                ArtName TYPE c LENGTH 40,
            END OF art_info.

" FILTER 運算子必須搭配具備 Key 定義的內表
TYPES art_table TYPE SORTED TABLE OF art_info
    WITH UNIQUE KEY ArtId.

"--------------------------------------------------------
" 2. 初始化資料（Data Initialization）
"--------------------------------------------------------
DATA(arts) = VALUE art_table(
    ( ArtId = 'A001' ArtName = '果陀劇場' )
    ( ArtId = 'A002' ArtName = '故事工廠' )
    ( ArtId = 'A003' ArtName = '國光劇團' )
).

"--------------------------------------------------------
" 3. 單筆資料存取（Table Expression）
"--------------------------------------------------------
cl_demo_output=>write( '【內表表達式直接存取內表資料】' ).

" 查無資料時，selected_art 會獲得該型別的初始值 (Initial Value)
DATA(selected_art) = VALUE #( arts[ ArtId = 'A005' ] OPTIONAL ).
cl_demo_output=>write( selected_art ).

DATA(selected_art2) = VALUE #( arts[ ArtId = 'A002' ] OPTIONAL ).
cl_demo_output=>write( selected_art2 ).

"--------------------------------------------------------
" 4. 集合篩選（FILTER）
"--------------------------------------------------------
" 必須明確指定變數型別與 Key 名稱
cl_demo_output=>write( '【集合篩選 FILTER】' ).
DATA filter_artid TYPE art_info-ArtId VALUE 'A003'.

" 不使用 IN 的 FILTER 必須顯式指定 USING KEY
DATA(filtered_arts) = FILTER art_table(
    arts USING KEY primary_key
    WHERE ArtId = filter_artid
).
cl_demo_output=>write( filtered_arts ).

"--------------------------------------------------------
" 5. 結構映射（CORRESPONDING）
"--------------------------------------------------------
cl_demo_output=>write( '【結構映射 CORRESPONDING 】' ).

cl_demo_output=>write( '單筆結構轉換' ).
DATA(corresp_art) = CORRESPONDING art_info( arts[ ArtId = 'A001' ] ).
cl_demo_output=>write( corresp_art ).

cl_demo_output=>write( '內表整體轉換' ).
DATA(corresp_arts) = CORRESPONDING art_table( arts ).
cl_demo_output=>write( corresp_arts ).

"--------------------------------------------------------
" 6. 顯式欄位映射（MAPPING）
"--------------------------------------------------------
" 先定義一個欄位名稱略有不同的新結構
TYPES: BEGIN OF business_partner,
    id   TYPE c LENGTH 10,  " 原本是 ArtId
    name TYPE c LENGTH 40,  " 原本是 ArtName
    type TYPE c LENGTH 2,
END OF business_partner.

" 定義目標內表型別
TYPES business_partner_table TYPE STANDARD TABLE OF business_partner
    WITH EMPTY KEY.

cl_demo_output=>write( '【顯式欄位映射  MAPPING 】' ).
" 當來源與目標欄位名稱不同時，必須手動指定對應關係
DATA(target_table) = CORRESPONDING business_partner_table(
    arts
    MAPPING id   = ArtId
                    name = ArtName
).
cl_demo_output=>write( target_table ).

cl_demo_output=>display( ).  " 輸出全部結果
