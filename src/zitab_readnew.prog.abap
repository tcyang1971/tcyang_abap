REPORT zitab_readnew.

TYPES: ArtGroupsSorted TYPE SORTED TABLE OF zart WITH UNIQUE KEY artid.

DATA(artGroupsById) = VALUE ArtGroupsSorted(
    ( artId = 'Godot'      artName = '果陀劇場' )
).

TRY.
    DATA(artGroup) = artGroupsById[ artId = 'Godot2' ].

    " 直接使用欄位
    WRITE |劇團名稱：{ artGroup-artName }|.

  CATCH cx_sy_itab_line_not_found.
    WRITE '未找到劇團資料'.
ENDTRY.
