*&---------------------------------------------------------------------*
*& Report Z_GPROJECT_ADD_DOCUMENT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_gproject_add_document.

TABLES: sscrfields.

PARAMETERS:p_bukrs TYPE bukrs,
           p_belnr TYPE belnr_d,
           p_gjahr TYPE gjahr,
           p_blart TYPE blart,
           p_bldat TYPE bldat,
           p_budat TYPE budat,
           p_cpudt TYPE cpudt,
           p_monat TYPE monat.


SELECTION-SCREEN: FUNCTION KEY 1.

INITIALIZATION.
  sscrfields-functxt_01 = '返回'.

AT SELECTION-SCREEN.
  CASE sscrfields-ucomm.
    WHEN 'FC01'.
      SUBMIT z_gproject_document_manage VIA SELECTION-SCREEN.
  ENDCASE.


START-OF-SELECTION.
  PERFORM fm_add.


FORM fm_add.
  INSERT zgpbkpf FROM @( VALUE #( bukrs = p_bukrs
                                  belnr = p_belnr
                                  gjahr = p_gjahr
                                  blart = p_blart
                                  bldat = p_bldat
                                  budat = p_budat
                                  cpudt = p_cpudt
                                  monat = p_monat
                               ) ).
  MESSAGE '添加成功' TYPE 'I'.
ENDFORM.
