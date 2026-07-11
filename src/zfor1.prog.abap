*&---------------------------------------------------------------------*
*& Report zfor1
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zfor1.

" 宣告整數內表的型別（table type of integers）
TYPES tt_ints TYPE STANDARD TABLE OF i WITH EMPTY KEY.

DATA(lt_numbers) = VALUE tt_ints(
    FOR lv_index = 1 THEN lv_index + 1 UNTIL lv_index > 5
    ( lv_index )
).

cl_demo_output=>display( lt_numbers ).
