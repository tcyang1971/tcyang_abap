REPORT zif.

" PARAMETERS 宣告輸入欄位 ，供使用者輸入人數
PARAMETERS capacity TYPE i.

DATA theater_size TYPE string.

IF capacity < 300.
    theater_size = '小劇場'.
ELSEIF capacity <= 800.
    theater_size = '中劇場'.
ELSE.
    theater_size = '大劇場'.
ENDIF.

WRITE: / |劇場容量：{ capacity } 人，屬於 { theater_size }|.
