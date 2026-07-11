*&---------------------------------------------------------------------*
*& Include          ZART_MGR_F01
*&---------------------------------------------------------------------*
FORM f01_query.
  IF zart-artid IS INITIAL.
    MESSAGE '請輸入劇團編號' TYPE 'S' DISPLAY LIKE 'E'.
    RETURN.
  ENDIF.

  "進行「不分大小寫」(Case-Insensitive)的資料比對
  SELECT SINGLE *
    FROM zart
    WHERE upper( artid ) = @( to_upper( zart-artid ) )
    INTO @zart.

  IF sy-subrc <> 0.
    CLEAR: zart-artname, zart-arttype, zart-arturl.
    MESSAGE '查無此劇團資料' TYPE 'I' DISPLAY LIKE 'E'.
  ENDIF.
ENDFORM.
