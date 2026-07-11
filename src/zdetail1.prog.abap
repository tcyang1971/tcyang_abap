REPORT zdetail1.

" 定義單一參數pArtType，必填且設定預設值'MD'
PARAMETERS pArtType TYPE zart-arttype OBLIGATORY DEFAULT 'MD'.

" START-OF-SELECTION事件，撈取第0層(基礎清單)劇團主檔並輸出
START-OF-SELECTION.
    SELECT artId, artName, artUrl FROM zart
        WHERE artType = @pArtType
        INTO TABLE @DATA(arts).

  LOOP AT arts INTO DATA(art).
    WRITE: / art-artid, art-artname, art-arturl.
    " 關鍵語法：將當前列的劇團ID隱藏存入記憶體，供點選時提取
    HIDE: art-artid.
  ENDLOOP.

" AT LINE-SELECTION事件，當使用者雙擊畫面的某一行時觸發
AT LINE-SELECTION.
    " 依據當前清單層級(sy-lsind)判斷進入第幾層挖掘
    CASE sy-lsind.

        " 當進入第1層清單（在第0層主畫面雙擊時觸發）
        WHEN 1.
            WRITE: / '劇團:',  art-artid, '的作品明細 (層級:', sy-lsind, ')'.
            ULINE.

            " 使用第0層 HIDE 記住的 art-artid 撈取第1層作品明細
            SELECT workName, premiere, duration FROM zwork
                WHERE  artid = @art-artid
                INTO TABLE @DATA(works).

            IF sy-subrc = 0.
                LOOP AT works INTO DATA(work).
                    WRITE: / work-workName, work-premiere, work-duration.
                    " 將當前列的作品名稱隱藏存入記憶體，供下次點選使用
                    HIDE: work-workName.
                ENDLOOP.
            ELSE.
                WRITE: / '查無作品明細資料。'.
            ENDIF.

    " 當進入第2層清單（在第1層畫面雙擊時觸發）
    WHEN 2.
        " 使用第1層 HIDE 記住的 work-workName 顯示最終結果
        WRITE: / '您選取的作品名稱是:',  work-workName.

  ENDCASE.
