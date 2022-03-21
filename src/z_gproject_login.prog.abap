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


DATA: gt_user  TYPE TABLE OF zgpuser WITH HEADER LINE,
      gt_admin TYPE TABLE OF zgpadmin WITH HEADER LINE..



TABLES sscrfields.

*--------------------------------------------------------------*
*Selection-Screen
*--------------------------------------------------------------*
SELECTION-SCREEN:
BEGIN OF LINE,
PUSHBUTTON (50) button1 USER-COMMAND but1 VISIBLE LENGTH 10, "40是按钮长度
PUSHBUTTON (50) button2 USER-COMMAND but2 VISIBLE LENGTH 10,
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
      IF p_auth1 IS NOT INITIAL.
        SELECT * FROM zgpadmin INTO TABLE @gt_admin.
        LOOP AT gt_admin INTO DATA(lt_admin).
          IF p_uname = lt_admin-uname AND p_pw = lt_admin-password.
            SUBMIT z_gproject_admin_catalogue VIA SELECTION-SCREEN.
          ENDIF.
        ENDLOOP.
      ELSE.
        SELECT * FROM zgpuser INTO TABLE @gt_user.
        LOOP AT gt_user INTO DATA(lt_user_1).
          IF p_uname = lt_user_1-uname AND p_pw = lt_user_1-password.
            SUBMIT z_gproject_custom_catalogue VIA SELECTION-SCREEN.
          ENDIF.
        ENDLOOP.
      ENDIF.
    WHEN 'BUT2'.
      IF p_auth1 IS NOT INITIAL.
        SUBMIT z_gproject_admin_sign_up VIA SELECTION-SCREEN.
      ELSE.
        SUBMIT z_gproject_custom_sign_up VIA SELECTION-SCREEN.
      ENDIF.
  ENDCASE.


*--------------------------------------------------------------*
*Initialization
*--------------------------------------------------------------*
INITIALIZATION.
  button1 = 'perform data'.
  button2 = 'register'.
* 按钮上添加图标
  CALL FUNCTION 'ICON_CREATE'
    EXPORTING
      name   = icon_okay
      text   = '登录'
      info   = '登录'
    IMPORTING
      result = button1
    EXCEPTIONS
      OTHERS = 0.

  CALL FUNCTION 'ICON_CREATE'
    EXPORTING
      name   = icon_create
      text   = '注册'
      info   = '注册'
    IMPORTING
      result = button2
    EXCEPTIONS
      OTHERS = 0.
