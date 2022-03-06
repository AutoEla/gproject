*&---------------------------------------------------------------------*
*& Report Z_GPROJECT_CUSTOM_CATALOGUE
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT Z_GPROJECT_CUSTOM_CATALOGUE.
TABLES sscrfields."引用词典对象

SELECTION-SCREEN SKIP."换行
SELECTION-SCREEN SKIP."换行
SELECTION-SCREEN SKIP."换行
SELECTION-SCREEN SKIP."换行
SELECTION-SCREEN SKIP."换行
SELECTION-SCREEN SKIP."换行
SELECTION-SCREEN SKIP."换行
SELECTION-SCREEN SKIP."换行
SELECTION-SCREEN SKIP."换行
*&---------------------------------------------------------------------*
SELECTION-SCREEN PUSHBUTTON /83(50) lb1 USER-COMMAND lb1.
*&---------------------------------------------------------------------*
SELECTION-SCREEN SKIP."换行
SELECTION-SCREEN SKIP."换行
*&---------------------------------------------------------------------*
SELECTION-SCREEN PUSHBUTTON /83(50) lb2 USER-COMMAND lb2.
*&---------------------------------------------------------------------*
SELECTION-SCREEN SKIP."换行
SELECTION-SCREEN SKIP."换行
*&---------------------------------------------------------------------*
SELECTION-SCREEN PUSHBUTTON /83(50) lb3 USER-COMMAND lb3.
*&---------------------------------------------------------------------*
SELECTION-SCREEN PUSHBUTTON /83(50) lb4 USER-COMMAND lb4.
*&---------------------------------------------------------------------*


*--------------------------------------------------------------*
*Initialization
*--------------------------------------------------------------*
INITIALIZATION.
* 按钮上添加图标
  CALL FUNCTION 'ICON_CREATE'
    EXPORTING
      name   = icon_okay
      text   = TEXT-001
    IMPORTING
      result = lb1
    EXCEPTIONS
      OTHERS = 0.

  CALL FUNCTION 'ICON_CREATE'
    EXPORTING
      name   = icon_okay
      text   = TEXT-002
    IMPORTING
      result = lb2
    EXCEPTIONS
      OTHERS = 0.

  CALL FUNCTION 'ICON_CREATE'
    EXPORTING
      name   = ICON_change
      text   = TEXT-003
    IMPORTING
      result = lb3
    EXCEPTIONS
      OTHERS = 0.

  CALL FUNCTION 'ICON_CREATE'
    EXPORTING
      name   = icon_cancel
      text   = TEXT-004
    IMPORTING
      result = lb4
    EXCEPTIONS
      OTHERS = 0.

AT SELECTION-SCREEN.
  CASE sscrfields.
    WHEN 'LB1'.
*      SELECT * FROM zgpuser INTO TABLE @gt_user.
*      LOOP AT gt_user INTO DATA(lt_user).
*        IF p_uname = lt_user-uname AND p_pw = lt_user-password.
*          SUBMIT z_gproject_catalogue VIA SELECTION-SCREEN.
*        ENDIF.
*      ENDLOOP.


    WHEN 'LB2'.
      MESSAGE 'Button 2 was clicked' TYPE 'I'.
    WHEN 'LB3'.
      MESSAGE 'Button 3 was clicked' TYPE 'I'.
    WHEN 'LB4'.
      SUBMIT z_gproject_main VIA SELECTION-SCREEN.
  ENDCASE.
