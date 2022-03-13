*&---------------------------------------------------------------------*
*& Report Z_GPROJECT_ADD_MATERIAL
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_gproject_add_material.

TABLES: sscrfields.

PARAMETERS:p_matnr1 TYPE zmatnr1,
           p_mname  TYPE string,
           p_ersda  TYPE ersda DEFAULT sy-datum,
           p_cat    TYPE created_at_time DEFAULT sy-uzeit,
           p_ernam  TYPE ernam DEFAULT sy-uname,
           p_mtart  TYPE mtart,
           p_wrkst  TYPE wrkst,
           p_volum  TYPE volum,
           p_voleh  TYPE zvoleh,
           p_mprice TYPE netwr_ak,
           p_maadr  TYPE string.


SELECTION-SCREEN: FUNCTION KEY 1.

INITIALIZATION.
  sscrfields-functxt_01 = '返回'.

AT SELECTION-SCREEN.
  CASE sscrfields-ucomm.
    WHEN 'FC01'.
      SUBMIT z_gproject_material_manage VIA SELECTION-SCREEN.
  ENDCASE.


AT SELECTION-SCREEN OUTPUT.
  LOOP AT SCREEN.
    IF screen-name ='P_ERSDA' OR screen-name = 'P_CAT' OR screen-name = 'P_ERNAM'.
      screen-input = '0'.
      MODIFY SCREEN.
    ENDIF.
  ENDLOOP.


START-OF-SELECTION.
  PERFORM fm_add.


FORM fm_add.
  INSERT zgpmara FROM @( VALUE #( zmatnr1 = p_matnr1
                                  mname = p_mname
                                  mtart = p_mtart
                                  ersda = p_ersda
                                  created_at_time = p_cat
                                  ernam = p_ernam
                                  wrkst = p_wrkst
                                  volum = p_volum
                                  voleh = p_voleh
                                  mprice = p_mprice
                                  maadr = p_maadr
                               ) ).
  MESSAGE '添加成功' TYPE 'I'.
ENDFORM.
