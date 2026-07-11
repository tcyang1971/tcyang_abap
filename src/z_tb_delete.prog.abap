REPORT z_tb_delete.

DELETE FROM zwork
    WHERE artid = 'Godot'
    AND premiere = '2021'.

IF sy-subrc = 0.
    COMMIT WORK.
    WRITE: / '資料刪除成功：已刪除符合條件的作品資料。'.
ELSE.
    WRITE: / '資料刪除失敗：未能刪除符合條件的資料。'.
ENDIF.
