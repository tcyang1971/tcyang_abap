REPORT zalv3.

" 全域資料宣告
DATA: OK_CODE LIKE SY-UCOMM,
      alvGrid     TYPE REF TO cl_gui_alv_grid,
      artResults  TYPE TABLE OF zart.

" 程式進入點
START-OF-SELECTION.
  " 1. 從資料表讀取資料 (Model)
  SELECT * FROM zart INTO TABLE @artResults.

  " 呼叫自訂畫面 (View)
  CALL SCREEN 9000.

INCLUDE zalv3_status_9000o01.
INCLUDE zalv3_user_command_9000i01.
