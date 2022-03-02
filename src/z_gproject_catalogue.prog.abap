*&---------------------------------------------------------------------*
*& report Z_GPROJECT_CATALOGUE
*&---------------------------------------------------------------------*
report Z_GPROJECT_CATALOGUE.

PARAMETERS:p_p1 TYPE string NO-DISPLAY.

selection-SCREEN:
PUSHBUTTON 83(50) lb1 USER-COMMAND lb1.

*--------------------------------------------------------------*
*Initialization
*--------------------------------------------------------------*
INITIALIZATION.
* 按钮上添加图标
  CALL FUNCTION 'ICON_CREATE'
    EXPORTING
      name   = icon_okay
      text   = text-001
    IMPORTING
      result = lb1
    EXCEPTIONS
      OTHERS = 0.
