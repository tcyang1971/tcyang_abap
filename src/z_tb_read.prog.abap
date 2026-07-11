REPORT z_tb_read.

SELECT artid, workname, premiere
    FROM zwork
    WHERE artid = 'Godot'
    ORDER BY premiere Descending
    INTO TABLE @DATA(works).

IF sy-subrc = 0.
    cl_demo_output=>display( works ).
ELSE.
    WRITE: / '沒有找到任何符合條件的資料'.
ENDIF.
