REPORT zadobe.

DATA: fmName          TYPE funcname,
      fpOutputParams  TYPE sfpoutputparams,
      fpDocParams     TYPE sfpdocparams,
      artData         TYPE ZART_TBLTYPE.

SELECT * FROM zart INTO TABLE @artData.

fpOutputParams-preview  = 'X'.
fpOutputParams-nodialog = 'X'.

CALL FUNCTION 'FP_JOB_OPEN'
    CHANGING
        job_outputparams = fpOutputParams
    EXCEPTIONS
        others           = 1.

CALL FUNCTION 'FP_FUNCTION_MODULE_NAME'
    EXPORTING
        i_name     = 'ZF_ART_LAYOUT'
    IMPORTING
        e_funcname = fmName.

CALL FUNCTION fmName
    EXPORTING
        /1bcdwb/docparams = fpDocParams
        it_art            = artData
    EXCEPTIONS
        usage_error    = 1
        system_error   = 2
        internal_error = 3
        others         = 4.

CALL FUNCTION 'FP_JOB_CLOSE'
    EXCEPTIONS
        others = 1.
