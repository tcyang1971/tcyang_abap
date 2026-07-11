REPORT z_tb_3.

DATA totalDebitHsl TYPE acdoca-hsl.

SELECT *
    FROM acdoca
    INTO TABLE @DATA(journalEntries)
    WHERE drcrk = 'S'.   " 僅過濾借方

DATA(entryCount) = lines( journalEntries ).

LOOP AT journalEntries INTO DATA(entry).
    totalDebitHsl = totalDebitHsl + entry-hsl.
ENDLOOP.

WRITE: / '財務分錄總筆數 (借方):', entryCount.
WRITE: / '本幣借方金額合計 (Data-to-Code):', totalDebitHsl.
