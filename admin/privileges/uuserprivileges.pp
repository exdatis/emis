unit uUserPrivileges;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, DBDateTimePicker, ZDataset, ZSequence,
  ZSqlUpdate, Forms, Controls, Graphics, Dialogs, StdCtrls, ActnList, ExtCtrls,
  Buttons, DBGrids, ComCtrls, DbCtrls, uBaseDbForm, db, ZAbstractDataset;

type

  { TfrmUserPrivileges }

  TfrmUserPrivileges = class(TbaseDbForm)
    actCharFilter: TAction;
    actClearFilter: TAction;
    actFindUser: TActionList;
    btnCharFilter: TSpeedButton;
    btnShowAll: TSpeedButton;
    btnShowCharacters: TButton;
    cmbCharFilter: TComboBox;
    cmbFieldArg: TComboBox;
    dbcValidPriveleges: TDBCheckBox;
    dbcValid: TDBCheckBox;
    dbCode: TDBEdit;
    dbControlDate: TDBDateTimePicker;
    dbgPrivileges: TDBGrid;
    dblDepartment: TDBLookupComboBox;
    dblModule: TDBLookupComboBox;
    dbgPrivilegesType: TDBRadioGroup;
    dbUserPwd: TDBEdit;
    dbUserName: TDBEdit;
    dbTitle: TDBEdit;
    dbName: TDBEdit;
    dsUserPrivileges: TDataSource;
    dsUsers: TDataSource;
    dsModule: TDataSource;
    dsDepartments: TDataSource;
    dbgUsers: TDBGrid;
    edtLocate: TEdit;
    gbEditUser: TGroupBox;
    gbPrivileges: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    pcUsers: TPageControl;
    panelParams: TPanel;
    tsPrivileges: TTabSheet;
    tsUsers: TTabSheet;
    zqUserPrivileges: TZQuery;
    zqUserPrivilegesMODULE_CODE: TStringField;
    zqUserPrivilegesNAME_OF_MODULE: TStringField;
    zqUserPrivilegesUP_CONTROL_DATE: TDateField;
    zqUserPrivilegesUP_ID: TLongintField;
    zqUserPrivilegesUP_MODULE: TLongintField;
    zqUserPrivilegesUP_PRIVILEGES: TSmallintField;
    zqUserPrivilegesUP_USER: TLongintField;
    zqUserPrivilegesUP_VALID: TSmallintField;
    zqUserPrivilegesUSER_NAME: TStringField;
    zqUserPrivilegesUSER_TITLE: TStringField;
    zqUsers: TZQuery;
    zqUsersAU_CODE: TStringField;
    zqUsersAU_DEPARTMENT: TLongintField;
    zqUsersAU_FULL_NAME: TStringField;
    zqUsersAU_ID: TLongintField;
    zqUsersAU_TITLE: TStringField;
    zqUsersAU_USER_NAME: TStringField;
    zqUsersAU_USER_PWD: TStringField;
    zqUsersAU_VALID: TSmallintField;
    zqUsersDEPARTMENT_CODE: TStringField;
    zqUsersDEPARTMENT_NAME: TStringField;
    zqUsersVALID: TBooleanField;
    zroModule: TZReadOnlyQuery;
    zroDepartments: TZReadOnlyQuery;
    zroDepartmentsD_ID: TLongintField;
    zroDepartmentsD_NAME: TStringField;
    zroModuleM_ID: TLongintField;
    zroModuleM_NAME: TStringField;
    zseqUserPrivileges: TZSequence;
    zseqUsers: TZSequence;
    zupdUserPrivileges: TZUpdateSQL;
    zupdUsers: TZUpdateSQL;
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  frmUserPrivileges: TfrmUserPrivileges;

implementation

{$R *.lfm}

end.

