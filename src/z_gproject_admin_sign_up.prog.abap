*&---------------------------------------------------------------------*
*& Report Z_GPROJECT_SIGN_UP
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_gproject_admin_sign_up.

TABLES: sscrfields.


PARAMETERS:p_uname  TYPE string DEFAULT sy-uname,
           p_pwd    TYPE xuncode,
           p_cfmpwd TYPE xuncode.

SELECTION-SCREEN: FUNCTION KEY 1.

INITIALIZATION.
  sscrfields-functxt_01 = '返回'.

AT SELECTION-SCREEN.
  CASE sscrfields-ucomm.
    WHEN 'FC01'.
      SUBMIT z_gproject_main VIA SELECTION-SCREEN.
  ENDCASE.


AT SELECTION-SCREEN OUTPUT.
  LOOP AT SCREEN.
    IF screen-name = 'P_PWD' OR screen-name = 'P_CFMPWD'.
      screen-invisible = '1'.
      MODIFY SCREEN.
    ENDIF.
  ENDLOOP.

START-OF-SELECTION.
  PERFORM fm_sign_up.



FORM fm_sign_up.
  IF p_pwd = p_cfmpwd.
    INSERT zgpadmin FROM @( VALUE #( uname = p_uname
                                     password = p_pwd
                                 ) ).
    MESSAGE '添加成功' TYPE 'I'.

  ENDIF.
ENDFORM.
