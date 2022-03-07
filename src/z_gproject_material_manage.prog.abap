*&---------------------------------------------------------------------*
*& Report Z_GPROJECT_MATERIAL_MANAGE
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_gproject_material_manage.

PARAMETERS:p_matnr TYPE matnr,
           p_mname TYPE string.

DATA: gt_gpmara   TYPE TABLE OF zgpmara,
      it_fieldcat TYPE slis_t_fieldcat_alv.

*START-OF-SELECTION.
*  PERFORM fm_add.
*  PERFORM fm_delete.
*  PERFORM fm_modify.
*  PERFORM fm_show_table.
*
*FORM fm_add.
*
*
*ENDFORM.
*
*
*
*FORM fm_delete.
*
*
*ENDFORM.
*
*
*
*FORM fm_modify.
*
*
*ENDFORM.
*
*
*
*FORM fm_show_table.
*  CALL FUNCTION 'REUSE_ALV_FIELDCATALOG_MERGE'
*    EXPORTING
*      i_structure_name       =
*    changing
*      ct_fieldcat            =
*    exceptions
*      inconsistent_interface = 1
*      program_error          = 2
*      others                 = 3.
*  IF sy-subrc <> 0.
** Implement suitable error handling here
*  ENDIF.
*
*  CALL FUNCTION 'REUSE_ALV_GRID_DISPLAY'
*    EXPORTING
*      i_structure_name =
*      it_fieldcat      =
*    TABLES
*      t_outtab         =
*    exceptions
*      program_error    = 1
*      OTHERS           = 2.
*  IF sy-subrc <> 0.
** Implement suitable error handling here
*  ENDIF.
*
*ENDFORM.
