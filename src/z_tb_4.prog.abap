REPORT z_tb_4.

SELECT COUNT( * ) AS entryCount,
    SUM( hsl ) AS totalDebitHsl
    FROM acdoca
    WHERE drcrk = 'S'   " 僅過濾借方
    INTO @DATA(summary).

WRITE: / '財務分錄總筆數 (借方):', summary-entryCount.
WRITE: / '本幣借方金額合計 (Code-to-Data):', summary-totalDebitHsl.
