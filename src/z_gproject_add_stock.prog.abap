*&---------------------------------------------------------------------*
*& Report Z_GPROJECT_ADD_STOCK
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_gproject_add_stock.

TABLES: sscrfields.

PARAMETERS:p_matnr1 TYPE zmatnr1,
           p_mname  TYPE string,
           p_volum  TYPE volum,
           p_voleh  TYPE zvoleh,
           p_mprice TYPE netwr_ak,
           p_maadr  TYPE string,
           p_wared  TYPE dats DEFAULT sy-datum,
           p_ouosd  TYPE dats NO-DISPLAY.


SELECTION-SCREEN: FUNCTION KEY 1.

INITIALIZATION.
  sscrfields-functxt_01 = '返回'.

AT SELECTION-SCREEN.
  CASE sscrfields-ucomm.
    WHEN 'FC01'.
      SUBMIT z_gproject_stock_manage VIA SELECTION-SCREEN.
  ENDCASE.


START-OF-SELECTION.
  PERFORM fm_add.


FORM fm_add.
  INSERT zgpstock FROM @( VALUE #( zmatnr1 = p_matnr1
                                  mname = p_mname
                                  volum = p_volum
                                  voleh = p_voleh
                                  mprice = p_mprice
                                  maadr = p_maadr
                                  wared = p_wared
                                  ouosd = p_ouosd
                               ) ).
  MESSAGE '添加成功' TYPE 'I'.
ENDFORM.
