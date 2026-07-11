REPORT zitab_demo2 no standard page heading.

DATA:
  artGroups        TYPE STANDARD TABLE OF zart WITH EMPTY KEY,
  artGroupsById    TYPE SORTED   TABLE OF zart WITH UNIQUE KEY ArtId,
  artGroupsByIdMap TYPE HASHED   TABLE OF zart WITH UNIQUE KEY ArtId.

" Standard: 隨意插入，順序即為插入順序
APPEND VALUE #( ArtId = 'Godot' ArtName = '果陀劇場' ) TO artGroups.
APPEND VALUE #( ArtId = 'StoryWorks' ArtName = '故事工廠' ) TO artGroups.
" Standard: 插入於第1順序
INSERT VALUE #( ArtId = 'GuoGuang' ArtName = '國光劇團' ) INTO artGroups index 1.

" Sorted: 自動根據 Key (ID) 排序，不論插入順序為何
INSERT VALUE #( ArtId = 'Godot' ArtName = '果陀劇場' ) INTO TABLE artGroupsById.
INSERT VALUE #( ArtId = 'StoryWorks' ArtName = '故事工廠' ) INTO TABLE artGroupsById.
INSERT VALUE #( ArtId = 'GuoGuang' ArtName = '國光劇團' ) INTO TABLE artGroupsById.

" Hashed: 無順序概念，純粹依雜湊值存放，必須使用 INSERT
INSERT VALUE #( ArtId = 'Godot' ArtName = '果陀劇場' ) INTO TABLE artGroupsByIdMap.
INSERT VALUE #( ArtId = 'StoryWorks' ArtName = '故事工廠' ) INTO TABLE artGroupsByIdMap.
INSERT VALUE #( ArtId = 'GuoGuang' ArtName = '國光劇團' ) INTO TABLE artGroupsByIdMap.

WRITE: / '1. 輸出結果展示差異'.
DATA artGroup TYPE zart.

WRITE: / 'Standard Table (Keep Order):'.
LOOP AT artGroups INTO artGroup.
    WRITE: | { artGroup-ArtId } { artGroup-ArtName } ; |.
ENDLOOP.

WRITE: / 'Sorted Table (Auto Sorted by ID):'.
LOOP AT artGroupsById INTO artGroup.
    WRITE: | { artGroup-ArtId } { artGroup-ArtName } ; |.
ENDLOOP.

WRITE: / 'Hashed Table (No Order, Key Lookup Fast):'.
LOOP AT artGroupsByIdMap INTO artGroup.
    WRITE: | { artGroup-ArtId } { artGroup-ArtName } ; |.
ENDLOOP.
uline.

WRITE: / '2. 讀取方式的差異'.

READ TABLE artGroups WITH KEY ArtId = 'GuoGuang' INTO artGroup.
WRITE: / |Standard Table使用Linear Search，效率較差: { artGroup-ArtId } { artGroup-ArtName } |.

READ TABLE artGroupsById WITH KEY ArtId = 'Godot' INTO artGroup.
"artGroup = artGroupsById[ ArtId = 'GuoGuang'  ]. " 使用 Table Expression (7.40 語法)
WRITE: / |Sorted Table自動使用Binary Search，效率高: { artGroup-ArtId } { artGroup-ArtName } |.

READ TABLE artGroupsByIdMap WITH KEY ArtId = 'StoryWorks' INTO artGroup.
"artGroup = artGroupsByIdMap[ ArtId = 'GuoGuang' ].
WRITE: / |Hashed Table: 使用 Hash Algorithm，在大數據量下最快: { artGroup-ArtId } { artGroup-ArtName } |.
uline.

WRITE: / '3. 修改資料操作，針對Standard Table分別使用index與key進行修改'.

MODIFY artGroups FROM VALUE #( ArtId = 'GuoGuang2' ArtName = '國光劇團2' ) INDEX 1.
MODIFY artGroups
    FROM VALUE #( ArtName = '故事工廠2' )
    TRANSPORTING ArtName
    WHERE ArtId = 'StoryWorks'.

WRITE: / '4. 刪除資料資料操作'.
DELETE artGroups WHERE ArtId = 'Godot'.
WRITE: / 'Standard Table:'.
LOOP AT artGroups INTO artGroup.
    WRITE: | { artGroup-ArtId } { artGroup-ArtName } ; |.
ENDLOOP.
uline.

WRITE: / '5. 清空整張內表，但保留記憶體預留空間'.
CLEAR artGroups. " 最常用，清空內容但保留記憶體預留空間
WRITE: / 'Standard Table:'.
LOOP AT artGroups INTO artGroup.
    WRITE: | { artGroup-ArtId } { artGroup-ArtName } ; |.
ENDLOOP.

FREE artGroups. " 釋放記憶體
