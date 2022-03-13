*&---------------------------------------------------------------------*
*& Report Z_GPROJECT_DEL_MATERIAL
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT Z_GPROJECT_DEL_MATERIAL.

TABLES: sscrfields.

PARAMETERS:p_matnr1 TYPE zmatnr1.

SELECTION-SCREEN: FUNCTION KEY 1.

INITIALIZATION.
  sscrfields-functxt_01 = '返回'.

AT SELECTION-SCREEN.
  CASE sscrfields-ucomm.
    WHEN 'FC01'.
      SUBMIT z_gproject_material_manage VIA SELECTION-SCREEN.
  ENDCASE.

START-OF-SELECTION.
  PERFORM fm_del.


FORM fm_del.
  delete zgpmara FROM @( VALUE #( zmatnr1 = p_matnr1 ) ).
  MESSAGE '删除成功' TYPE 'I'.
ENDFORM.
