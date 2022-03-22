*&---------------------------------------------------------------------*
*& Report Z_GPROJECT_MODIFY_DOCUMENT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT Z_GPROJECT_MODIFY_DOCUMENT.
TABLES: sscrfields.

SELECTION-SCREEN BEGIN OF BLOCK block1 WITH FRAME TITLE TEXT-001.
PARAMETERS:p_bukrs TYPE bukrs,
           p_belnr TYPE belnr_d,
           p_gjahr TYPE gjahr,
           p_blart TYPE blart,
           p_bldat TYPE bldat,
           p_budat TYPE budat,
           p_cpudt TYPE cpudt,
           p_monat TYPE monat.
SELECTION-SCREEN END OF BLOCK block1.

SELECTION-SCREEN BEGIN OF BLOCK block2 WITH FRAME TITLE TEXT-002.
PARAMETERS:pn_bukrs TYPE bukrs,
           pn_belnr TYPE belnr_d,
           pn_gjahr TYPE gjahr,
           pn_blart TYPE blart,
           pn_bldat TYPE bldat,
           pn_budat TYPE budat,
           pn_cpudt TYPE cpudt,
           pn_monat TYPE monat.
SELECTION-SCREEN END OF BLOCK block2.

DATA: gt_gpbkpf TYPE TABLE OF zgpbkpf WITH HEADER LINE.

SELECTION-SCREEN: FUNCTION KEY 1.

INITIALIZATION.
  sscrfields-functxt_01 = '返回'.

AT SELECTION-SCREEN.
  CASE sscrfields-ucomm.
    WHEN 'FC01'.
      SUBMIT z_gproject_document_manage VIA SELECTION-SCREEN.
  ENDCASE.
  SELECT * FROM zgpbkpf INTO @DATA(lt_gpbkpf) WHERE belnr = @p_belnr.
    p_bukrs = lt_gpbkpf-bukrs.
    p_gjahr = lt_gpbkpf-gjahr.
    p_blart = lt_gpbkpf-blart.
    p_bldat = lt_gpbkpf-bldat.
    p_budat = lt_gpbkpf-budat.
    p_cpudt = lt_gpbkpf-cpudt.
    p_monat = lt_gpbkpf-monat.
  ENDSELECT.


AT SELECTION-SCREEN OUTPUT.
  LOOP AT SCREEN.
    IF screen-name = 'P_BLART' OR screen-name = 'P_BLDAT' OR screen-name = 'P_BUDAT'
       OR screen-name = 'P_CPUDT' OR screen-name = 'P_MONAT'.
      screen-input = '0'.
      MODIFY SCREEN.
    ENDIF.
  ENDLOOP.


START-OF-SELECTION.
  PERFORM fm_modify.


FORM fm_modify.
  READ TABLE gt_gpbkpf INTO DATA(lt_gpbkpf) INDEX 1.
  lt_gpbkpf-bukrs = pn_bukrs.
  lt_gpbkpf-belnr = pn_belnr.
  lt_gpbkpf-gjahr = pn_gjahr.
  lt_gpbkpf-blart = pn_blart.
  lt_gpbkpf-bldat = pn_bldat.
  lt_gpbkpf-budat = pn_budat.
  lt_gpbkpf-cpudt = pn_cpudt.
  lt_gpbkpf-monat = pn_monat.
  SELECT * FROM zgpbkpf INTO @DATA(lt_zgpbkpf).
  ENDSELECT.
  IF lt_zgpbkpf-belnr = lt_gpbkpf-belnr.
    UPDATE zgpbkpf FROM lt_gpbkpf.
    IF sy-subrc = 0.
      COMMIT WORK AND WAIT.
      MESSAGE '更新成功' TYPE 'I'.
    ELSE.
      ROLLBACK WORK.
      MESSAGE '保存出错' TYPE 'I' DISPLAY LIKE 'E'.
    ENDIF.
  ENDIF.

ENDFORM.
