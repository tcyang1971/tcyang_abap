REPORT zswitch.

PARAMETERS art_type TYPE c LENGTH 2.

DATA(full_type) = SWITCH string( art_type
    WHEN 'MD' THEN 'Modern Drama (現代戲劇)'
    WHEN 'TC' THEN 'Traditional Chinese Opera (傳統戲曲)'
    WHEN 'CA' THEN 'Circus/Acrobatics (馬戲雜技)'
    ELSE           '未知類型'
).

WRITE: / |劇團類型：{ art_type }  全名：{ full_type }|.
