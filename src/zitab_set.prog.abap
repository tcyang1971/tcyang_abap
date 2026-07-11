REPORT zitab_set.

TYPES: worksType TYPE SORTED TABLE OF zwork WITH NON-UNIQUE KEY duration.

DATA(works) = VALUE worksType(
    ( workname = '解憂雜貨店'  premiere = '2020' duration = 155 )
    ( workname = '火神的眼淚' premiere = '2025'  duration = 165 )
    ( workname = 'VALO二部曲-島嶼' premiere = '2021' duration = 110 )
     ( workname = '奇幻旅程'  premiere = '2012' duration = 115 )
).

DATA(recentWorks) = VALUE worksType(
    FOR wa IN works WHERE ( premiere >= '2020' )
    ( wa )
).

DATA(totalDuration) = REDUCE i(
    INIT sum = 0
    FOR  work  IN recentWorks
    NEXT sum = sum + work-duration
).

WRITE: / |2020年以後首演的作品數量：{ lines( recentWorks ) } 部|.
WRITE: / |篩選後的總演出時間：{ totalDuration } 分鐘|.
