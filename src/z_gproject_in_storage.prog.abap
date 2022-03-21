*&---------------------------------------------------------------------*
*& Report Z_GPROJECT_IN_STORAGE
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_gproject_in_storage.

TABLES: sscrfields.

PARAMETERS:p_matnr1 TYPE zmatnr1,
           p_mname  TYPE string,
           p_volum  TYPE volum,
           p_voleh  TYPE zvoleh,
           p_mprice TYPE netwr_ak,
           p_maadr  TYPE string,
           p_wared  TYPE dats DEFAULT sy-datum.

DATA: gt_otf   TYPE STANDARD TABLE OF itcoo,
      gt_docs  TYPE STANDARD TABLE OF docs,
      gt_lines TYPE STANDARD TABLE OF tline,
      gt_gpstock TYPE TABLE OF zgpstock.

* Declaration of local variables.
DATA:
  gs_job_output_info      TYPE ssfcrescl,
  gs_document_output_info TYPE ssfcrespd,
  gs_job_output_options   TYPE ssfcresop,
  gs_output_options       TYPE ssfcompop,
  gs_control_parameters   TYPE ssfctrlop,
  gv_len_in               TYPE so_obj_len,
  gv_language             TYPE sflangu VALUE 'E',
  gv_e_devtype            TYPE rspoptype,
  gv_bin_filesize         TYPE i,
  gv_name                 TYPE string,
  gv_path                 TYPE string,
  gv_fullpath             TYPE string,
  gv_filter               TYPE string,
  gv_uact                 TYPE i,
  gv_guiobj               TYPE REF TO cl_gui_frontend_services,
  gv_filename             TYPE string,
  gv_fm_name              TYPE rs38l_fnam,
  gv_total_usd            TYPE netwr,
  gv_total_eur            TYPE netwr.


SELECTION-SCREEN: FUNCTION KEY 1.

INITIALIZATION.
  sscrfields-functxt_01 = '返回'.

AT SELECTION-SCREEN.
  CASE sscrfields-ucomm.
    WHEN 'FC01'.
      SUBMIT z_gproject_admin_catalogue VIA SELECTION-SCREEN.
  ENDCASE.


start-OF-SELECTION.
perform fm_judge_matnr.
perform fm_get_device.
perform fm_smartforms.
perform fm_otf_2_pdf.
perform fm_get_file_name.
perform fm_download_file.

form fm_judge_matnr.
  select ZMATNR1,volum FROM zgpstock into @DATA(lt_zgpstock) WHERE ZMATNR1 = @p_matnr1.
  endselect.
  IF sy-subrc = 0.
    lt_zgpstock-volum = lt_zgpstock-volum + p_volum.
    update zgpstock SET volum = @lt_zgpstock-volum , wared = @p_wared WHERE ZMATNR1 = @p_matnr1.
    IF sy-subrc = 0.
      COMMIT WORK AND WAIT.
    ELSE.
      ROLLBACK WORK.
    ENDIF.
  else.
    INSERT zgpstock FROM @( VALUE #( zmatnr1 = p_matnr1
                                  mname = p_mname
                                  volum = p_volum
                                  voleh = p_voleh
                                  mprice = p_mprice
                                  maadr = p_maadr
                                  wared = p_wared
                               ) ).
  ENDIF.

endform.


*&---------------------------------------------------------------------*
*&     GET DEVICE
*&---------------------------------------------------------------------*
form fm_get_device.
gs_output_options-tdprinter = gv_e_devtype.
gs_control_parameters-no_dialog = 'X'.
gs_control_parameters-getotf = 'X'.


CONSTANTS c_formname TYPE tdsfname VALUE 'ZF_GPROJECT_IN_STORAGE'.
CALL FUNCTION 'SSF_GET_DEVICE_TYPE'
  EXPORTING
    i_language    = gv_language
    i_application = 'SAPDEFAULT'
  IMPORTING
    e_devtype     = gv_e_devtype.


CALL FUNCTION 'SSF_FUNCTION_MODULE_NAME'
  EXPORTING
    formname           = c_formname
  IMPORTING
    fm_name            = gv_fm_name
  EXCEPTIONS
    no_form            = 1
    no_function_module = 2
    OTHERS             = 3.
endform.


*&---------------------------------------------------------------------*
*&     SMARTFORMS '/1BCDWB/SF00000093'
*&---------------------------------------------------------------------*
form fm_smartforms.
CALL FUNCTION gv_fm_name
  EXPORTING
    control_parameters   = gs_control_parameters
    output_options       = gs_output_options
*   USER_SETTINGS        = 'X'
    matnr                      = p_matnr1
    mname                      = p_mname
    volum                      = p_volum
  IMPORTING
    document_output_info = gs_document_output_info
    job_output_info      = gs_job_output_info
    job_output_options   = gs_job_output_options
  EXCEPTIONS
    formatting_error     = 1
    internal_error       = 2
    send_error           = 3
    user_canceled        = 4
    OTHERS               = 5.
IF sy-subrc <> 0.
* Implement suitable error handling here
ENDIF.
endform.



*&---------------------------------------------------------------------*
*&     CONVERT OTF TO PDF
*&---------------------------------------------------------------------*
form fm_otf_2_pdf.
CALL FUNCTION 'CONVERT_OTF_2_PDF'
  IMPORTING
    bin_filesize           = gv_bin_filesize
  TABLES
    otf                    = gs_job_output_info-otfdata
    doctab_archive         = gt_docs
    lines                  = gt_lines
  EXCEPTIONS
    err_conv_not_possible  = 1
    err_otf_mc_noendmarker = 2
    OTHERS                 = 3.
IF sy-subrc <> 0.
* Implement suitable error handling here
ENDIF.
ENDFORM.


*&---------------------------------------------------------------------*
*&     GET FILE NAME
*&---------------------------------------------------------------------*
form fm_get_file_name.
CONCATENATE 'smartform' '.pdf' INTO gv_name.
CREATE OBJECT gv_guiobj.
CALL METHOD gv_guiobj->file_save_dialog
  EXPORTING
    default_extension = 'pdf'
    default_file_name = gv_name
    file_filter       = gv_filter
  CHANGING
    filename          = gv_name
    path              = gv_path
    fullpath          = gv_fullpath
    user_action       = gv_uact.
IF gv_uact = gv_guiobj->action_cancel.
  EXIT.
ENDIF.
endform.


*&---------------------------------------------------------------------*
*&     DOWNLOAD FILE
*&---------------------------------------------------------------------*
form fm_download_file.
MOVE gv_fullpath TO gv_filename.
CALL FUNCTION 'GUI_DOWNLOAD'
  EXPORTING
    bin_filesize            = gv_bin_filesize
    filename                = gv_filename
    filetype                = 'BIN'
  TABLES
    data_tab                = gt_lines
  EXCEPTIONS
    file_write_error        = 1
    no_batch                = 2
    gui_refuse_filetransfer = 3
    invalid_type            = 4
    no_authority            = 5
    unknown_error           = 6
    header_not_allowed      = 7
    separator_not_allowed   = 8
    filesize_not_allowed    = 9
    header_too_long         = 10
    dp_error_create         = 11
    dp_error_send           = 12
    dp_error_write          = 13
    unknown_dp_error        = 14
    access_denied           = 15
    dp_out_of_memory        = 16
    disk_full               = 17
    dp_timeout              = 18
    file_not_found          = 19
    dataprovider_exception  = 20
    control_flush_error     = 21
    OTHERS                  = 22.
ENDFORM.
