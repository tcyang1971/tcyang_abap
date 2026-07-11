REPORT zloop1 no standard page heading.

PARAMETERS n TYPE i DEFAULT 10.

* ==========================================
* 使用 DO 迴圈計算
* ==========================================
DATA(sum) = 0.

DO n TIMES.
    sum += sy-index.  "  sy-index 是紀錄執行次數的系統欄位
ENDDO.

WRITE: / |使用 DO 迴圈計算結果：1 + 2 + ... + { n } = { sum }|.
ULINE.              " 在程式中畫出底線

* ==========================================
* 使用 WHILE 迴圈計算
* ==========================================
DATA(i) = 0.
sum = 0.            " 將 sum 歸零，初始化累加變數

WHILE i < n.        " 使用 WHILE 迴圈計算累加總和
    i += 1.
    sum += i.
ENDWHILE.

WRITE: / |使用 WHILE 迴圈計算結果：1 + 2 + ... + { n } = { sum }|.
