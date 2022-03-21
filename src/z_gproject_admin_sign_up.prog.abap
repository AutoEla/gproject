*&---------------------------------------------------------------------*
*& Report Z_GPROJECT_SIGN_UP
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_gproject_admin_sign_up.

PARAMETERS:p_uname  TYPE string DEFAULT sy-uname,
           p_pwd    TYPE xuncode,
           p_cfmpwd TYPE xuncode.


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
