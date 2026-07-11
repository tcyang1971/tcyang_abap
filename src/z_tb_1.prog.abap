REPORT z_tb_1.

SELECT *
    FROM zshow
    INTO TABLE @DATA(shows).

DATA total TYPE zshow-revenue.

LOOP AT shows INTO DATA(show).
    IF show-venue = '桃園展演中心展演廳'.
        total += show-revenue.
    ENDIF.
ENDLOOP.

WRITE:/ '桃園展演中心展演廳的總營收:', total.
