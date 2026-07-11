*&---------------------------------------------------------------------*
*& Report zinsert_work
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zinsert_work.

DATA lt_zwork TYPE TABLE OF zwork.

" 2. 填入您的作品資料 (實例資料 4 筆)
" 注意：MANDT 建議使用 sy-mandt 以符合當前登入的 Client
lt_zwork = VALUE #(

  ( mandt = sy-mandt artid = 'Test'    workname = '奇幻旅程'        premiere = '2012' duration = 115 )
).

" 3. 將資料批次寫入資料庫表 ZWORK
" 使用 @lt_zwork (Host Variable) 確保與資料庫安全隔離
INSERT zwork FROM TABLE @lt_zwork
    ACCEPTING DUPLICATE KEYS.   " 若主鍵重複則自動跳過，不拋出異常

" 4. 提交與結果檢查
IF sy-subrc = 0.
    COMMIT WORK.  " 正式存入資料庫
    WRITE: / '戲劇作品資料批次新增成功！'.
ELSE.
    ROLLBACK WORK. " 若失敗則撤銷異動
    WRITE: / '資料批次新增失敗，請檢查資料表結構或主鍵是否衝突。'.
ENDIF.
