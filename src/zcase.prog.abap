REPORT zcase.

PARAMETERS art_type TYPE c LENGTH 2.
DATA full_type TYPE string.

CASE art_type.
    WHEN 'MD'.
        full_type = 'Modern Drama (現代戲劇)'.
    WHEN 'TC'.
        full_type = 'Traditional Chinese Opera (傳統戲曲)'.
    WHEN 'CA'.
        full_type = 'Circus/Acrobatics (馬戲雜技)'.
    WHEN OTHERS.
        full_type = '未知類型'.
ENDCASE.

WRITE: / |劇團類型：{ art_type }  全名：{ full_type }|.
