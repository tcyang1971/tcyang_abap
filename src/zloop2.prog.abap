REPORT zloop2.

PARAMETERS n TYPE i.

DATA(sum) = REDUCE i(
    INIT s = 0
    FOR i = 1 THEN i + 1 UNTIL i > n
    NEXT s = s + i
).

WRITE: / |使用FOR迴圈及REDUCE計算結果：{ sum }|.
