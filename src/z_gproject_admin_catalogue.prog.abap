*&---------------------------------------------------------------------*
*& report Z_GPROJECT_CATALOGUE
*&---------------------------------------------------------------------*
REPORT z_gproject_admin_catalogue.
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
SELECTION-SCREEN SKIP."换行
SELECTION-SCREEN SKIP."换行
*&---------------------------------------------------------------------*
SELECTION-SCREEN PUSHBUTTON /83(50) lb4 USER-COMMAND lb4.
*&---------------------------------------------------------------------*
SELECTION-SCREEN SKIP."换行
SELECTION-SCREEN SKIP."换行
*&---------------------------------------------------------------------*
SELECTION-SCREEN PUSHBUTTON /83(50) lb5 USER-COMMAND lb5.
*&---------------------------------------------------------------------*
SELECTION-SCREEN SKIP."换行
SELECTION-SCREEN SKIP."换行
*&---------------------------------------------------------------------*
SELECTION-SCREEN PUSHBUTTON /83(50) lb6 USER-COMMAND lb6.
*&---------------------------------------------------------------------*
SELECTION-SCREEN SKIP."换行
SELECTION-SCREEN SKIP."换行
*&---------------------------------------------------------------------*
SELECTION-SCREEN PUSHBUTTON /83(50) lb7 USER-COMMAND lb7.
*&---------------------------------------------------------------------*
SELECTION-SCREEN PUSHBUTTON /83(50) lb8 USER-COMMAND lb8.
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
      name   = icon_okay
      text   = TEXT-003
    IMPORTING
      result = lb3
    EXCEPTIONS
      OTHERS = 0.

  CALL FUNCTION 'ICON_CREATE'
    EXPORTING
      name   = icon_okay
      text   = TEXT-004
    IMPORTING
      result = lb4
    EXCEPTIONS
      OTHERS = 0.

  CALL FUNCTION 'ICON_CREATE'
    EXPORTING
      name   = icon_okay
      text   = TEXT-005
    IMPORTING
      result = lb5
    EXCEPTIONS
      OTHERS = 0.

  CALL FUNCTION 'ICON_CREATE'
    EXPORTING
      name   = icon_okay
      text   = TEXT-006
    IMPORTING
      result = lb6
    EXCEPTIONS
      OTHERS = 0.

  CALL FUNCTION 'ICON_CREATE'
    EXPORTING
      name   = ICON_change
      text   = TEXT-007
    IMPORTING
      result = lb7
    EXCEPTIONS
      OTHERS = 0.

  CALL FUNCTION 'ICON_CREATE'
    EXPORTING
      name   = icon_cancel
      text   = TEXT-008
    IMPORTING
      result = lb8
    EXCEPTIONS
      OTHERS = 0.

AT SELECTION-SCREEN.
  CASE sscrfields.
    WHEN 'LB1'.  "入库管理
      SUBMIT Z_GPROJECT_IN_STORAGE VIA SELECTION-SCREEN.
    WHEN 'LB2'.  "出库管理
      SUBMIT Z_GPROJECT_OUT_OF_STORAGE VIA SELECTION-SCREEN.
    WHEN 'LB3'.  "商品管理
      SUBMIT Z_GPROJECT_MATERIAL_MANAGE VIA SELECTION-SCREEN.
    WHEN 'LB4'.  "库存管理
      SUBMIT Z_GPROJECT_STOCK_MANAGE VIA SELECTION-SCREEN.
    WHEN 'LB5'.  "财务报表管理
      SUBMIT Z_GPROJECT_DOCUMENT_MANAGE VIA SELECTION-SCREEN.
    WHEN 'LB6'.  "统计分析
      SUBMIT Z_GPROJECT_TOTAL VIA SELECTION-SCREEN.
    WHEN 'LB7'.  "修改密码
      SUBMIT Z_GPROJECT_CHANGE_PASSWORD VIA SELECTION-SCREEN.
    WHEN 'LB8'.  "返回主界面
      SUBMIT z_gproject_main VIA SELECTION-SCREEN.
  ENDCASE.
