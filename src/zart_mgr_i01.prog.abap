*&---------------------------------------------------------------------*
*& Include          ZART_MGR_I01
*&---------------------------------------------------------------------*
MODULE user_command_9000 INPUT.
    DATA: currentUserCommand TYPE sy-ucomm.

    " 轉存指令並立即清空全域變數，避免重複觸發邏輯
    currentUserCommand = ok_code.
    CLEAR ok_code.

    CASE currentUserCommand.
      WHEN 'QUERY'.
        PERFORM f01_query.
        SET SCREEN 9000.  "覆寫暫存器中的「下一螢幕」屬性

      WHEN 'BYE'.
        LEAVE PROGRAM.  "終止當前整個ABAP程式的執行
  ENDCASE.

ENDMODULE.
