*&---------------------------------------------------------------------*
*& Report Z_GPROJECT_CHANGE_PASSWORD
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_gproject_change_password.
TABLES sscrfields."引用词典对象

PARAMETERS:p_old TYPE xuncode,
           p_new TYPE xuncode.

DATA: gt_user TYPE TABLE OF zgpadmin WITH HEADER LINE.

SELECTION-SCREEN PUSHBUTTON /1(50) lb1 USER-COMMAND lb1 VISIBLE LENGTH 20.

INITIALIZATION.
* 按钮上添加图标
  CALL FUNCTION 'ICON_CREATE'
    EXPORTING
      name   = ICON_SYSTEM_BACK
      text   = TEXT-001
    IMPORTING
      result = lb1
    EXCEPTIONS
      OTHERS = 0.

AT SELECTION-SCREEN.
  CASE sscrfields.
    WHEN 'LB1'.  "返回主界面
      SUBMIT z_gproject_admin_catalogue VIA SELECTION-SCREEN.
  ENDCASE.

START-OF-SELECTION.
  PERFORM change_password.

FORM change_password.
  SELECT * FROM zgpadmin INTO TABLE @gt_user.
  LOOP AT gt_user INTO DATA(lt_user).
    IF p_old = lt_user-password.
      lt_user-password = p_new.
      MODIFY gt_user FROM lt_user.
      update zgpadmin FROM lt_user.
      IF sy-subrc = 0.
        COMMIT WORK AND WAIT.
        MESSAGE '更新成功' TYPE 'I'.
      ELSE.
        ROLLBACK WORK.
        MESSAGE '保存出错' TYPE 'I' DISPLAY LIKE 'E'.
      ENDIF.

    ENDIF.
  ENDLOOP.
ENDFORM.
