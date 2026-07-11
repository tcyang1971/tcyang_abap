REPORT z_tb_insert.

DATA(ls_work) = VALUE zwork(
    artid    = 'Godot'
    workname = '生命中最美好的5分鐘'
    premiere = '2021'
    duration = 145
).

MODIFY zwork FROM @ls_work.

IF sy-subrc = 0.
  COMMIT WORK.
  WRITE: / '資料處理成功（已新增或已更新）'.
ENDIF.
