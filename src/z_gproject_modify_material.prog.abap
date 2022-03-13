*&---------------------------------------------------------------------*
*& Report Z_GPROJECT_MODIFY_MATERIAL
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_gproject_modify_material.
TABLES: sscrfields.

SELECTION-SCREEN BEGIN OF BLOCK block1 WITH FRAME TITLE TEXT-001.
  PARAMETERS:p_matnr1 TYPE zmatnr1,
             p_mname  TYPE string,
             p_laeda  TYPE laeda DEFAULT sy-datum,
             p_aenam  TYPE aenam DEFAULT sy-uname,
             p_mtart  TYPE mtart,
             p_wrkst  TYPE wrkst,
             p_volum  TYPE volum,
             p_voleh  TYPE zvoleh,
             p_mprice TYPE netwr_ak,
             p_maadr  TYPE string.
SELECTION-SCREEN END OF BLOCK block1.

SELECTION-SCREEN BEGIN OF BLOCK block2 WITH FRAME TITLE TEXT-002.
  PARAMETERS:pn_mname TYPE string,
             pn_mtart TYPE mtart,
             pn_wrkst TYPE wrkst,
             pn_volum TYPE volum,
             pn_voleh TYPE zvoleh,
             pn_mpric TYPE netwr_ak,
             pn_maadr TYPE string.
SELECTION-SCREEN END OF BLOCK block2.

DATA: gt_gpmara TYPE TABLE OF zgpmara WITH HEADER LINE.

SELECTION-SCREEN: FUNCTION KEY 1.

INITIALIZATION.
  sscrfields-functxt_01 = '返回'.

AT SELECTION-SCREEN.
  CASE sscrfields-ucomm.
    WHEN 'FC01'.
      SUBMIT z_gproject_material_manage VIA SELECTION-SCREEN.
  ENDCASE.
  SELECT * FROM zgpmara INTO @DATA(lt_gpmara) WHERE zmatnr1 = @p_matnr1.
    p_mname = lt_gpmara-mname.
    p_mtart = lt_gpmara-mtart.
    p_wrkst = lt_gpmara-wrkst.
    p_volum = lt_gpmara-volum.
    p_voleh = lt_gpmara-voleh.
    p_mprice = lt_gpmara-mprice.
    p_maadr = lt_gpmara-maadr.
  ENDSELECT.


AT SELECTION-SCREEN OUTPUT.
  LOOP AT SCREEN.
    IF screen-name ='P_LAEDA' OR screen-name = 'P_AENAM' OR screen-name = 'P_MNAME' OR screen-name = 'P_MTART'
       OR screen-name = 'P_WRKST' OR screen-name = 'P_VOLUM' OR screen-name = 'P_VOLEH' OR screen-name = 'P_MPRICE'
       OR screen-name = 'P_MAADR'.
      screen-input = '0'.
      MODIFY SCREEN.
    ENDIF.
  ENDLOOP.


START-OF-SELECTION.
  PERFORM fm_modify.


FORM fm_modify.
  READ TABLE gt_gpmara INTO DATA(lt_gpmara) INDEX 1.
  lt_gpmara-zmatnr1 = p_matnr1.
  lt_gpmara-mname = pn_mname.
  lt_gpmara-laeda = p_laeda.
  lt_gpmara-aenam = p_aenam.
  lt_gpmara-mtart = pn_mtart.
  lt_gpmara-wrkst = pn_wrkst.
  lt_gpmara-volum = pn_volum.
  lt_gpmara-voleh = pn_voleh.
  lt_gpmara-mprice = pn_mpric.
  lt_gpmara-maadr = pn_maadr.
  SELECT * FROM zgpmara INTO @DATA(lt_zgpmara).
  ENDSELECT.
  IF lt_zgpmara-zmatnr1 = lt_gpmara-zmatnr1.
    UPDATE zgpmara FROM lt_gpmara.
    IF sy-subrc = 0.
      COMMIT WORK AND WAIT.
      MESSAGE '更新成功' TYPE 'I'.
    ELSE.
      ROLLBACK WORK.
      MESSAGE '保存出错' TYPE 'I' DISPLAY LIKE 'E'.
    ENDIF.
  ENDIF.

ENDFORM.
