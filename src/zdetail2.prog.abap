REPORT zdetail2.

PARAMETERS pArtType TYPE zart-arttype OBLIGATORY DEFAULT 'MD'.

START-OF-SELECTION.
    SELECT artId, artName, artUrl FROM zart
        WHERE artType = @pArtType
        INTO TABLE @DATA(arts).

    LOOP AT arts INTO DATA(art).
        WRITE: / art-artid, art-artname, art-arturl.
    ENDLOOP.

AT LINE-SELECTION.
    " 宣告變數用於儲存被點選的欄位名稱與其內容值
    DATA: fieldName TYPE string, fieldValue TYPE string.

    " 關鍵語法：動態捕捉使用者當前游標所點擊的「欄位名稱」與「欄位值」
    GET CURSOR FIELD fieldName VALUE fieldValue.

    " 依據當前清單層級(sy-lsind)判斷進入第幾層
    CASE sy-lsind.
        " 當進入第 1 層清單（在第 0 層主畫面雙擊時觸發）
        WHEN 1.
            WRITE: / '您點選的欄位名稱:', fieldName.
            WRITE: / '您點選的欄位值:', fieldValue.
  ENDCASE.
