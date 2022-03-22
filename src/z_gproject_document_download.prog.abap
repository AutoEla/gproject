*&---------------------------------------------------------------------*
*& Report Z_GPROJECT_DOCUMENT_DOWNLOAD
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT Z_GPROJECT_DOCUMENT_DOWNLOAD.
TABLES sscrfields."引用词典对象


PARAMETERS:p_belnr TYPE belnr_d,
           p_gjahr TYPE gjahr,
           p_blart TYPE blart.

DATA: gt_gpbkpf   TYPE TABLE OF zgpbkpf WITH HEADER LINE,
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
  SELECT * FROM zgpbkpf INTO TABLE @gt_gpbkpf.
  CALL FUNCTION 'REUSE_ALV_FIELDCATALOG_MERGE'
    EXPORTING
      i_structure_name       = 'ZSGPBKPF'
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
      i_structure_name = 'ZSGPBKPF'
      it_fieldcat      = it_fieldcat
    TABLES
      t_outtab         = gt_gpbkpf
    EXCEPTIONS
      program_error    = 1
      OTHERS           = 2.
  IF sy-subrc <> 0.
* Implement suitable error handling here
  ENDIF.

ENDFORM.
