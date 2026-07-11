REPORT zitab_readold.

DATA artGroupsById TYPE SORTED TABLE OF zart WITH UNIQUE KEY artid.
DATA artGroup TYPE zart.

artGroup-artId = 'Godot'.
artGroup-artName = '果陀劇場'.
INSERT artGroup INTO TABLE artGroupsById.

READ TABLE artGroupsById WITH KEY artid = 'Godot2' INTO artGroup.

IF sy-subrc = 0.
  WRITE |劇團名稱：{ artGroup-artName }|.
ELSE.
  WRITE '未找到劇團資料'.
ENDIF.
