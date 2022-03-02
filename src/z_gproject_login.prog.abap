*&---------------------------------------------------------------------*
*& Include Z_GPROJECT_MAIN
*&---------------------------------------------------------------------*
*& 基于ABAP的商品库存管理系统
*&---------------------------------------------------------------------*
*REPORT z_stephen_project.
TYPE-POOLS: icon.

PARAMETERS: p_uname TYPE string,
            p_pw    TYPE string,
            p_auth1 RADIOBUTTON GROUP rg1 DEFAULT 'X',
            p_auth2 RADIOBUTTON GROUP rg1.


DATA: gt_user TYPE TABLE OF zgpuser WITH HEADER LINE.



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
AT SELECTION-SCREEN.
* 相应按钮事件
  CASE sscrfields.
    WHEN 'BUT1'.
      SELECT * FROM zgpuser INTO TABLE @gt_user.
      LOOP AT gt_user INTO DATA(lt_user).
        IF p_uname = lt_user-uname AND p_pw = lt_user-password.
          SUBMIT z_gproject_catalogue VIA SELECTION-SCREEN.
        ENDIF.
      ENDLOOP.


    WHEN 'BUT2'.
      MESSAGE 'Button 2 was clicked' TYPE 'I'.
    WHEN 'BUT3'.
      MESSAGE 'Button 3 was clicked' TYPE 'I'.
  ENDCASE.
MODULE exit INPUT.
  CALL SCREEN 1000.
ENDMODULE.

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
  PERFORM data.


FORM data.

*  INSERT zgpuser FROM @( VALUE #( UNAME = 'AUTOELA' password = '111111' ) ).
  SELECT * FROM zgpuser INTO @DATA(lgpuser).
    IF p_uname = lgpuser-uname AND p_pw = lgpuser-password.
      WRITE: 'aa'.
    ENDIF.
  ENDSELECT.

ENDFORM.
