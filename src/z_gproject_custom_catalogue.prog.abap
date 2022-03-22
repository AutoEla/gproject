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
      SUBMIT Z_GPROJECT_TOTAL VIA SELECTION-SCREEN.
    WHEN 'LB2'.
      SUBMIT Z_GPROJECT_DOCUMENT_DOWNLOAD VIA SELECTION-SCREEN.
    WHEN 'LB3'.
      SUBMIT Z_GPROJECT_CHANGE_PASSWORD_CUS VIA SELECTION-SCREEN.
    WHEN 'LB4'.
      SUBMIT z_gproject_main VIA SELECTION-SCREEN.
  ENDCASE.
