REPORT zreport5.

" 利用內聯宣告搭配 CONV 強制設定 String 型態
DATA(artID)   = CONV string( 'Godot' ).
DATA(artName) = CONV string( '果陀劇場' ).
DATA(artType) = CONV string( 'MD' ).
WRITE:/ '原始劇團資料之內容：', artID, artName, artType.

" 呼叫子程序。
PERFORM processArtData
    USING artID
    CHANGING artName artType.
WRITE:/ '返回主程式後之內容：', artID, artName, artType.

" 定義子程序參數傳遞機制
" id   -> Call by Value (傳值呼叫)
" name -> Call by Value and Result (傳值後回傳結果)
" tp   -> Call by Reference (傳址呼叫)
FORM processArtData
    USING VALUE(id) TYPE string
    CHANGING VALUE(name) TYPE string
                        tp TYPE string.

    id   = 'GuoGuang'.
    name = '國光劇團'.
    tp   = 'TC'.
    WRITE:/ '副程式處理中之內容：', id, name, tp.
ENDFORM.
