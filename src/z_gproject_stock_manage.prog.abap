*&---------------------------------------------------------------------*
*& Report Z_GPROJECT_STOCK_MANAGE
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT Z_GPROJECT_STOCK_MANAGE.
TABLES sscrfields."引用词典对象


PARAMETERS:p_matnr1 TYPE zmatnr1,
           p_mname  TYPE string.

DATA: gt_gpstock   TYPE TABLE OF zgpstock WITH HEADER LINE,
      it_fieldcat TYPE slis_t_fieldcat_alv.


SELECTION-SCREEN:
BEGIN OF LINE,
PUSHBUTTON (50) lb1 USER-COMMAND lb1 VISIBLE LENGTH 20,
PUSHBUTTON (50) lb2 USER-COMMAND lb2 VISIBLE LENGTH 20,
PUSHBUTTON (50) lb3 USER-COMMAND lb3 VISIBLE LENGTH 20,
PUSHBUTTON (50) lb4 USER-COMMAND lb4 VISIBLE LENGTH 20,
END OF LINE.

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
      name   = icon_cancel
      text   = TEXT-004
    IMPORTING
      result = lb4
    EXCEPTIONS
      OTHERS = 0.


AT SELECTION-SCREEN.
  CASE sscrfields.
    WHEN 'LB1'.  "添加库存
      SUBMIT z_gproject_add_stock VIA SELECTION-SCREEN.
    WHEN 'LB2'.  "修改库存
      SUBMIT z_gproject_modify_stock VIA SELECTION-SCREEN.
    WHEN 'LB3'.  "删除库存
      SUBMIT z_gproject_del_stock VIA SELECTION-SCREEN.
    WHEN 'LB4'.  "返回选择界面
      SUBMIT z_gproject_admin_catalogue VIA SELECTION-SCREEN.
  ENDCASE.


START-OF-SELECTION.
  PERFORM fm_show_table.




FORM fm_show_table.
  SELECT * FROM zgpstock INTO TABLE @gt_gpstock.
  CALL FUNCTION 'REUSE_ALV_FIELDCATALOG_MERGE'
    EXPORTING
      i_structure_name       = 'ZSGPSTOCK'
    CHANGING
      ct_fieldcat            = it_fieldcat
    EXCEPTIONS
      inconsistent_interface = 1
      program_error          = 2
      OTHERS                 = 3.
  IF sy-subrc <> 0.
* Implement suitable error handling here
  ENDIF.

  CALL FUNCTION 'REUSE_ALV_GRID_DISPLAY'
    EXPORTING
      i_structure_name = 'ZSGPSTOCK'
      it_fieldcat      = it_fieldcat
    TABLES
      t_outtab         = gt_gpstock
    EXCEPTIONS
      program_error    = 1
      OTHERS           = 2.
  IF sy-subrc <> 0.
* Implement suitable error handling here
  ENDIF.

ENDFORM.
