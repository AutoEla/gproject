*&---------------------------------------------------------------------*
*& Report Z_GPROJECT_1
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
*REPORT Z_GPROJECT_1.
set SCREEN 1111.
TABLES: stxftxt,AFPO,AUFK,vbak.
select-OPTIONS P_UNAME1 FOR SY-UNAME DEFAULT SY-UNAME   .

START-OF-SELECTION.

SELECTION-SCREEN: FUNCTION KEY 1,   "激活按钮
                  FUNCTION KEY 2,
                  FUNCTION KEY 3,
                  FUNCTION KEY 4,
                  FUNCTION KEY 5 .
INITIALIZATION.
  sscrfields-functxt_01 = '@O6@ ZPP006壓批     '      . "设置按钮
  sscrfields-functxt_02 = '@5Y@ ZCO02A核發     '      .
  sscrfields-functxt_03 = '@0X@ ZPP006A工單列印'      .
  sscrfields-functxt_04 = '@XP@ ZPP012發料     '      .
  sscrfields-functxt_05 = '@0X@ ZPP012A發料列印'      .
