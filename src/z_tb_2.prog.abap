REPORT z_tb_2.

SELECT SUM( revenue )
  FROM zshow
  WHERE venue = '桃園展演中心展演廳'
  INTO @DATA(total).

WRITE:/ '桃園展演中心展演廳的總營收:', total.
