REPORT zchap5.

" 1. 定義結構與型態 (建議先定義內表型態)
TYPES: BEGIN OF ty_art,
         workname TYPE string,
         premiere TYPE i,
         duration TYPE i,
       END OF ty_art.
TYPES tt_art TYPE STANDARD TABLE OF ty_art WITH EMPTY KEY. " 原始資料用

TYPES: BEGIN OF ty_result,
         workname     TYPE string,
         premiere     TYPE i,
         duration TYPE i,
         duration_txt TYPE string,
       END OF ty_result.
TYPES tt_result TYPE STANDARD TABLE OF ty_result WITH EMPTY KEY. " 輸出結果用

" 2. 建立原始資料內表 (注意雙重括號與正確型態)
DATA(lt_art) = VALUE tt_art(
  ( workname = '解憂雜貨店'          premiere = 2020 duration = 155 )
  ( workname = '生命中最美好的5分鐘' premiere = 2021 duration = 145 )
  ( workname = '倒數婚姻'            premiere = 2023 duration = 125 )
  ( workname = '火神的眼淚'          premiere = 2025 duration = 165 )
  ( workname = '夢紅樓．乾隆與和珅'  premiere = 2019 duration = 180 )
  ( workname = '奇幻旅程'            premiere = 2012 duration = 115 )
  ( workname = 'VALO二部曲-島嶼'     premiere = 2021 duration = 110 )
). " 這裡修正了括號對應

" 3. 處理資料：篩選 (WHERE)、排序 (SORTED BY) 與 邏輯判斷 (COND)
" 我們篩選 2021 年以後 (>= 2021) 的作品，並存入新表
DATA(lt_display) = VALUE tt_result(
  FOR ls_art IN lt_art WHERE ( premiere >= 2021 )
  ( workname     = ls_art-workname
    premiere     = ls_art-premiere
    duration = ls_art-duration
    duration_txt = COND string(
                     WHEN ls_art-duration <= 60  THEN '1小時以內'
                     WHEN ls_art-duration <= 120 THEN '2小時以內'
                     ELSE '超過2小時' )
  )
).

" 以首演年份由小至大排序
SORT lt_display BY premiere ASCENDING.

" 4. 統計加總：計算 2021 年以後作品的總演出時間 (使用 REDUCE)
DATA(lv_total_duration) = REDUCE i(
  INIT sum = 0
  FOR ls_sum IN lt_art WHERE ( premiere >= 2021 )
  NEXT sum = sum + ls_sum-duration
).

" 5. 輸出結果
" 輸出清單
cl_demo_output=>next_section( '2021年以後戲劇作品清單' ).
cl_demo_output=>write( lt_display ).

" 輸出加總結果
cl_demo_output=>next_section( '演出統計' ).
cl_demo_output=>write( |2021年以後的作品總演出長度：{ lv_total_duration } 分鐘| ).

cl_demo_output=>display( ).
