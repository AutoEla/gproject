*&---------------------------------------------------------------------*
*& Report Z_STEPHEN_PROJECT
*&---------------------------------------------------------------------*
*& 基于ABAP的商品库存管理系统
*&---------------------------------------------------------------------*
REPORT z_stephen_project.
TYPE-POOLS: icon.

PARAMETERS: p_uname TYPE string,
            p_pw    TYPE string.

DATA: gt_user TYPE TABLE OF zgpuser.

TABLES sscrfields.


*--------------------------------------------------------------*
*Selection-Screen
*--------------------------------------------------------------*
  SELECTION-SCREEN:
  BEGIN OF LINE,
  PUSHBUTTON (50) button1 USER-COMMAND but1 VISIBLE LENGTH 10, "40是按钮长度
  PUSHBUTTON (50) button2 USER-COMMAND but2 VISIBLE LENGTH 15,
  PUSHBUTTON (50) button3 USER-COMMAND but3 VISIBLE LENGTH 10,
  END OF LINE.
*--------------------------------------------------------------*
*At Selection-Screen
*--------------------------------------------------------------*
*start-OF-SELECTION.
*perform data.



*--------------------------------------------------------------*
*Initialization
*--------------------------------------------------------------*
INITIALIZATION.
  button1 = 'perform data'.
  button2 = 'forget password'.
  button3 = 'register'.
* 按钮上添加图标
  CALL FUNCTION 'ICON_CREATE'
    EXPORTING
      name   = icon_okay
      text   = 'Sign in'
      info   = 'Click to Continue'
    IMPORTING
      result = button1
    EXCEPTIONS
      OTHERS = 0.

  CALL FUNCTION 'ICON_CREATE'
    EXPORTING
      name   = icon_cancel
      text   = 'Forget password'
      info   = 'Click to Exit'
    IMPORTING
      result = button2
    EXCEPTIONS
      OTHERS = 0.

  CALL FUNCTION 'ICON_CREATE'
    EXPORTING
      name   = icon_create
      text   = 'Sign up'
      info   = 'Click to Exit'
    IMPORTING
      result = button3
    EXCEPTIONS
      OTHERS = 0.
START-OF-SELECTION.
perform data.

AT SELECTION-SCREEN.
* 相应按钮事件
  CASE sscrfields.
    WHEN 'BUT1'.
*      set SCREEN 2000.
      LEAVE TO SCREEN 1111.
    WHEN 'BUT2'.
      MESSAGE 'Button 2 was clicked' TYPE 'I'.
    WHEN 'BUT3'.
      MESSAGE 'Button 3 was clicked' TYPE 'I'.
  ENDCASE.



FORM data.
  set SCREEN 1111.
*  INSERT zgpuser FROM @( VALUE #( UNAME = 'AUTOELA' password = '111111' ) ).
  SELECT * FROM zgpuser INTO @DATA(lgpuser).
    IF p_uname = lgpuser-uname AND p_pw = lgpuser-password.
      WRITE: 'aa'.
    ENDIF.
  ENDSELECT.

ENDFORM.
