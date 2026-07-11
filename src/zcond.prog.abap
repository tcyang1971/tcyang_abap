REPORT zcond.

PARAMETERS capacity TYPE i.

DATA(theater_size) = COND string(
  WHEN capacity < 300  THEN '小劇場'
  WHEN capacity <= 800 THEN '中劇場'
  ELSE                      '大劇場'
).

WRITE: / |劇場容量：{ capacity } 人，屬於 { theater_size }|.
