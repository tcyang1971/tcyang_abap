*&---------------------------------------------------------------------*
*& Report zinsert_show
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zinsert_show.


* 建立內表，用於暫存欲寫入 ZSHOW 的資料
DATA lt_show_list TYPE TABLE OF zshow.

* 使用 VALUE # 依據左側型別自動推導內表結構
* 關鍵提醒：
* 1. SHOWDATE 需為 YYYYMMDD 格式 (移除斜線)
* 2. SHOWTIME 需為 HHMMSS 格式 (移除冒號)
* 3. REVENUE 為金額型別，建議以字串或數值形式輸入，系統會自動轉換
lt_show_list = VALUE #(
  ( showid   = '0000000001' artid = 'Diabolo'    workname = 'VALO二部曲-島嶼' showdate = '20260117' showtime = '143000'
    venue    = '桃園展演中心展演廳' audience = 1050 revenue = '1012500.00' currency = 'TWD' )

  ( showid   = '0000000002' artid = 'Diabolo'    workname = 'VALO二部曲-島嶼' showdate = '20260118' showtime = '143000'
    venue    = '桃園展演中心展演廳' audience = 1120 revenue = '1087600.00' currency = 'TWD' )

  ( showid   = '0000000003' artid = 'Godot'      workname = '解憂雜貨店'      showdate = '20260424' showtime = '193000'
    venue    = '新北市藝文中心演藝廳' audience = 880  revenue = '983400.00'  currency = 'TWD' )

  ( showid   = '0000000004' artid = 'Godot'      workname = '解憂雜貨店'      showdate = '20260425' showtime = '143000'
    venue    = '新北市藝文中心演藝廳' audience = 830  revenue = '864900.00'  currency = 'TWD' )

  ( showid   = '0000000005' artid = 'Godot'      workname = '解憂雜貨店'      showdate = '20260425' showtime = '193000'
    venue    = '新北市藝文中心演藝廳' audience = 920  revenue = '1058600.00' currency = 'TWD' )

  ( showid   = '0000000006' artid = 'Godot'      workname = '解憂雜貨店'      showdate = '20260426' showtime = '143000'
    venue    = '新北市藝文中心演藝廳' audience = 860  revenue = '915800.00'  currency = 'TWD' )

  ( showid   = '0000000007' artid = 'StoryWorks' workname = '火神的眼淚'      showdate = '20260116' showtime = '193000'
    venue    = '臺北表演藝術中心大劇院' audience = 1420 revenue = '2356800.00' currency = 'TWD' )

  ( showid   = '0000000008' artid = 'StoryWorks' workname = '火神的眼淚'      showdate = '20260117' showtime = '143000'
    venue    = '臺北表演藝術中心大劇院' audience = 1380 revenue = '2170200.00' currency = 'TWD' )

  ( showid   = '0000000009' artid = 'StoryWorks' workname = '火神的眼淚'      showdate = '20260118' showtime = '143000'
    venue    = '臺北表演藝術中心大劇院' audience = 1450 revenue = '2392500.00' currency = 'TWD' )
).

* MODIFY： 更新資料庫(主鍵存在)/ 新增(主鍵不存在)
MODIFY zshow FROM TABLE @lt_show_list.

* 結果判斷  sy-subrc = 0：SQL成功執行
IF sy-subrc = 0.

  " 有資料被新增或更新 → 提交交易
  COMMIT WORK AND WAIT.
  WRITE: / | ✅ 資料庫操作成功，共處理 { sy-dbcnt } 筆資料 |.

ELSE.

  " 無資料異動或執行異常 → 回滾
  ROLLBACK WORK.
  WRITE: / | ❌ 資料庫操作失敗， sy-subrc = { sy-subrc } |.

ENDIF.
