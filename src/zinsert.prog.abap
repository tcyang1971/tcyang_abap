REPORT zmodify_zart.

* 建立內表，用於暫存欲寫入 ZART 的資料
DATA lt_art_group TYPE TABLE OF zart.

* 使用 VALUE # 依據左側型別自動推導內表結構
* MANDT 不需指定，Open SQL 會自動帶入 sy-mandt
lt_art_group = VALUE #(
  ( artid   = 'Godot'
    artname = '果陀劇場'
    arttype = 'MD'
    arturl  = 'https://godot.org.tw/' )

  ( artid   = 'StoryWorks'
    artname = '故事工廠'
    arttype = 'MD'
    arturl  = 'https://www.storyworks.com.tw/' )

( artid   = 'GuoGuang'
    artname = '國光劇團'
    arttype = 'TC'
    arturl  = 'https://www.ncfta.gov.tw/cp.aspx?n=2874' )

  ( artid   = 'Diabolo'
    artname = '舞鈴劇場'
    arttype = 'CA'
    arturl  = 'https://www.diabolo.tw/' )
).

* MODIFY：  更新資料庫(主鍵存在)/ 新增(主鍵不存在)
MODIFY zart FROM TABLE @lt_art_group.

* 結果判斷  sy-subrc = 0：SQL 成功執行
IF sy-subrc = 0.

  " 有資料被新增或更新 → 提交交易
  COMMIT WORK AND WAIT.
  WRITE: / | ✅ 資料庫操作成功，共處理 { sy-dbcnt } 筆資料 |.

ELSE.

  " 無資料異動或執行異常 → 回滾
  ROLLBACK WORK.
  WRITE: / | ❌ 資料庫操作失敗， sy-subrc = { sy-subrc } |.

ENDIF.
