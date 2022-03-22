*&---------------------------------------------------------------------*
*& Report Z_GPROJECT_DEL_DOCUMENT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_gproject_del_document.

TABLES: sscrfields.

PARAMETERS:p_belnr TYPE belnr_d.

SELECTION-SCREEN: FUNCTION KEY 1.

INITIALIZATION.
  sscrfields-functxt_01 = '返回'.

AT SELECTION-SCREEN.
  CASE sscrfields-ucomm.
    WHEN 'FC01'.
      SUBMIT Z_GPROJECT_DOCUMENT_MANAGE VIA SELECTION-SCREEN.
  ENDCASE.

START-OF-SELECTION.
  PERFORM fm_del.


FORM fm_del.
  DELETE ZGPBKPF FROM @( VALUE #( belnr = p_belnr ) ).
  MESSAGE '删除成功' TYPE 'I'.
ENDFORM.
