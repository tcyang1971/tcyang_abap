*&---------------------------------------------------------------------*
*& Report zexpress1
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zexpress1.

" 1. 定義結構型別
TYPES: BEGIN OF tyArtWork,
         workName TYPE string,
         premiere TYPE i,
         duration TYPE i,
       END OF tyArtWork.

TYPES: BEGIN OF tyReportLine,
         workName    TYPE string,
         premiere    TYPE i,
         duration    TYPE i,
         durationTxt TYPE string,
       END OF tyReportLine.

" 定義內表型別
TYPES ttArtWorks   TYPE STANDARD TABLE OF tyArtWork WITH EMPTY KEY.
TYPES ttReportData TYPE STANDARD TABLE OF tyReportLine WITH EMPTY KEY.

" 2. 初始化原始資料 (使用 VALUE)
DATA(ltRawData) = VALUE ttArtWorks(
  ( workName = `解憂雜貨店`           premiere = 2020 duration = 155 )
  ( workName = `生命中最美好的5分鐘` premiere = 2021 duration = 145 )
  ( workName = `倒數婚姻`             premiere = 2023 duration = 125 )
  ( workName = `火神的眼淚`           premiere = 2025 duration = 165 )
  ( workName = `夢紅樓．乾隆與和珅`    premiere = 2019 duration = 180 )
  ( workName = `奇幻旅程`             premiere = 2012 duration = 115 )
  ( workName = `VALO二部曲-島嶼`      premiere = 2021 duration = 110 )
).

" 3. 生成報表資料：篩選、加註與轉換 (整合 FOR 與 COND)
DATA(ltFinalReport) = VALUE ttReportData(
  FOR lsArt IN ltRawData WHERE ( premiere >= 2021 )
  ( workName    = lsArt-workName
    premiere    = lsArt-premiere
    duration    = lsArt-duration
    durationTxt = COND string(
                    WHEN lsArt-duration <= 60  THEN |短篇作品|
                    WHEN lsArt-duration <= 120 THEN |中長篇作品|
                    ELSE                             |長篇作品| )
  )
).

" 依首演年份排序，如果首演年份相同再依演出長度由小至大排序
SORT ltFinalReport BY premiere ASCENDING duration ASCENDING.

" 4. 統計加總：計算符合條件的作品總演出時間 (使用 REDUCE)
DATA(lvTotalDuration) = REDUCE i(
  INIT sum = 0
  FOR lsSum IN ltRawData WHERE ( premiere >= 2021 )
  NEXT sum = sum + lsSum-duration
).

" 5. 輸出報表結果

" 新增報表標題區段
cl_demo_output=>next_section( '2021年以後推出的戲劇作品報表' ).

" 寫入內表內容到輸出視窗
cl_demo_output=>write( ltFinalReport ).

" 新增統計資料區段
cl_demo_output=>next_section( '演出統計 summary' ).

" 寫入統計文字訊息
cl_demo_output=>write( |符合條件作品之總演出時間：{ lvTotalDuration } 分鐘| ).

" 輸出到內嵌視窗
cl_demo_output=>display( ).
