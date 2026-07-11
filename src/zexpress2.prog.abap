*&---------------------------------------------------------------------*
*& Report zexpress2
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zexpress2.

" 1. 定義結構型別
TYPES: BEGIN OF art_work,
    work_name TYPE string,
    premiere  TYPE i,
    duration  TYPE i,
END OF art_work.

TYPES: BEGIN OF report_line,
    work_name    TYPE string,
    premiere     TYPE i,
    duration     TYPE i,
    duration_txt TYPE string,
END OF report_line.

" 定義內表型別
TYPES art_works   TYPE STANDARD TABLE OF art_work WITH EMPTY KEY.
TYPES report_data TYPE STANDARD TABLE OF report_line WITH EMPTY KEY.

" 2. 初始化原始資料 (使用 VALUE)
DATA(raw_data) = VALUE art_works(
  ( work_name = `解憂雜貨店`           premiere = 2020 duration = 155 )
  ( work_name = `生命中最美好的5分鐘` premiere = 2021 duration = 145 )
  ( work_name = `倒數婚姻`             premiere = 2023 duration = 125 )
  ( work_name = `火神的眼淚`           premiere = 2025 duration = 165 )
  ( work_name = `夢紅樓．乾隆與和珅`    premiere = 2019 duration = 180 )
  ( work_name = `奇幻旅程`             premiere = 2012 duration = 115 )
  ( work_name = `VALO二部曲-島嶼`      premiere = 2021 duration = 110 )
).

" 3. 生成報表資料：篩選、加註與轉換 (整合 FOR 與 COND)
DATA(final_report) = VALUE report_data(
    FOR art_item IN raw_data WHERE ( premiere >= 2021 ) (
    work_name    = art_item-work_name
    premiere     = art_item-premiere
    duration     = art_item-duration
    duration_txt = COND string(
                            WHEN art_item-duration <= 60  THEN |短篇作品|
                            WHEN art_item-duration <= 120 THEN |中長篇作品|
                            ELSE                               |長篇作品| )
    )
).

" 依首演年份排序，如果首演年份相同再依演出長度由小至大排序
SORT final_report BY premiere ASCENDING duration ASCENDING.

" 4. 統計加總：計算符合條件的作品總演出時間 (使用 REDUCE)
DATA(total_duration) = REDUCE i(
    INIT sum = 0
    FOR sum_item IN raw_data WHERE ( premiere >= 2021 )
    NEXT sum = sum + sum_item-duration
).

" 5. 輸出報表結果

" 新增報表標題區段
cl_demo_output=>next_section( '2021年以後推出的戲劇作品報表' ).

" 寫入內表內容到輸出視窗
cl_demo_output=>write( final_report ).

" 新增統計資料區段
cl_demo_output=>next_section( '演出統計 summary' ).

" 寫入統計文字訊息
cl_demo_output=>write( |符合條件作品之總演出時間：{ total_duration } 分鐘| ).

" 顯示輸出
cl_demo_output=>display( ).
