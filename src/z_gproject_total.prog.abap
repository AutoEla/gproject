*&---------------------------------------------------------------------*
*& Report Z_GPROJECT_TOTAL
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT Z_GPROJECT_TOTAL.
TABLES sscrfields."引用词典对象


PARAMETERS:p_matnr1 TYPE zmatnr1.

DATA: gt_gpmara   TYPE TABLE OF zgpmara WITH HEADER LINE,
      it_fieldcat TYPE slis_t_fieldcat_alv.

SELECTION-SCREEN: FUNCTION KEY 1.

INITIALIZATION.
  sscrfields-functxt_01 = '返回'.

AT SELECTION-SCREEN.
  CASE sscrfields-ucomm.
    WHEN 'FC01'.
      SUBMIT z_gproject_custom_catalogue VIA SELECTION-SCREEN.
  ENDCASE.


START-OF-SELECTION.
  PERFORM fm_show_table.


FORM fm_show_table.
  SELECT * FROM zgpmara INTO TABLE @gt_gpmara.
  CALL FUNCTION 'REUSE_ALV_FIELDCATALOG_MERGE'
    EXPORTING
      i_structure_name       = 'ZSGPMARA'
    CHANGING
      ct_fieldcat            = it_fieldcat
    EXCEPTIONS
      inconsistent_interface = 1
      program_error          = 2
      OTHERS                 = 3.
  IF sy-subrc <> 0.
* Implement suitable error handling here
  ENDIF.

  CALL FUNCTION 'REUSE_ALV_GRID_DISPLAY'
    EXPORTING
      i_structure_name = 'ZSGPMARA'
      it_fieldcat      = it_fieldcat
    TABLES
      t_outtab         = gt_gpmara
    EXCEPTIONS
      program_error    = 1
      OTHERS           = 2.
  IF sy-subrc <> 0.
* Implement suitable error handling here
  ENDIF.

ENDFORM.
