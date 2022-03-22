*&---------------------------------------------------------------------*
*& Report Z_GPROJECT_MODIFY_STOCK
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT Z_GPROJECT_MODIFY_STOCK.
TABLES: sscrfields.

SELECTION-SCREEN BEGIN OF BLOCK block1 WITH FRAME TITLE TEXT-001.
  PARAMETERS:p_matnr1 TYPE zmatnr1,
             p_mname  TYPE string,
             p_volum  TYPE volum,
             p_voleh  TYPE zvoleh,
             p_mprice TYPE netwr_ak,
             p_maadr  TYPE string.
SELECTION-SCREEN END OF BLOCK block1.

SELECTION-SCREEN BEGIN OF BLOCK block2 WITH FRAME TITLE TEXT-002.
  PARAMETERS:pn_mname TYPE string,
             pn_volum TYPE volum,
             pn_voleh TYPE zvoleh,
             pn_mpric TYPE netwr_ak,
             pn_maadr TYPE string.
SELECTION-SCREEN END OF BLOCK block2.

DATA: gt_gpstock TYPE TABLE OF zgpstock WITH HEADER LINE.

SELECTION-SCREEN: FUNCTION KEY 1.

INITIALIZATION.
  sscrfields-functxt_01 = '返回'.

AT SELECTION-SCREEN.
  CASE sscrfields-ucomm.
    WHEN 'FC01'.
      SUBMIT z_gproject_stock_manage VIA SELECTION-SCREEN.
  ENDCASE.
  SELECT * FROM zgpstock INTO @DATA(lt_gpstock) WHERE zmatnr1 = @p_matnr1.
    p_mname = lt_gpstock-mname.
    p_volum = lt_gpstock-volum.
    p_voleh = lt_gpstock-voleh.
    p_mprice = lt_gpstock-mprice.
    p_maadr = lt_gpstock-maadr.
  ENDSELECT.


AT SELECTION-SCREEN OUTPUT.
  LOOP AT SCREEN.
    IF screen-name = 'P_MNAME' OR screen-name = 'P_VOLUM' OR screen-name = 'P_VOLEH'
       OR screen-name = 'P_MPRICE' OR screen-name = 'P_MAADR'.
      screen-input = '0'.
      MODIFY SCREEN.
    ENDIF.
  ENDLOOP.


START-OF-SELECTION.
  PERFORM fm_modify.


FORM fm_modify.
  READ TABLE gt_gpstock INTO DATA(lt_gpstock) INDEX 1.
  lt_gpstock-zmatnr1 = p_matnr1.
  lt_gpstock-mname = pn_mname.
  lt_gpstock-volum = pn_volum.
  lt_gpstock-voleh = pn_voleh.
  lt_gpstock-mprice = pn_mpric.
  lt_gpstock-maadr = pn_maadr.
  SELECT * FROM zgpstock INTO @DATA(lt_zgpstock).
  ENDSELECT.
  IF lt_zgpstock-zmatnr1 = lt_gpstock-zmatnr1.
    UPDATE zgpstock FROM lt_gpstock.
    IF sy-subrc = 0.
      COMMIT WORK AND WAIT.
      MESSAGE '更新成功' TYPE 'I'.
    ELSE.
      ROLLBACK WORK.
      MESSAGE '保存出错' TYPE 'I' DISPLAY LIKE 'E'.
    ENDIF.
  ENDIF.

ENDFORM.
