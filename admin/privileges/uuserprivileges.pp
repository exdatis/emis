unit uUserPrivileges;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, ZDataset, ZSequence, ZSqlUpdate, Forms, Controls,
  Graphics, Dialogs, StdCtrls, ActnList, ExtCtrls, Buttons, DBGrids,
  uBaseDbForm, db;

type

  { TfrmUserPrivileges }

  TfrmUserPrivileges = class(TbaseDbForm)
    actCharFilter: TAction;
    actClearFilter: TAction;
    actFindUser: TActionList;
    btnCharFilter: TSpeedButton;
    btnShowAll: TSpeedButton;
    cmbCharFilter: TComboBox;
    cmbFieldArg: TComboBox;
    dsUsers: TDataSource;
    dsModule: TDataSource;
    dsDepartments: TDataSource;
    dbgUsers: TDBGrid;
    edtLocate: TEdit;
    panelParams: TPanel;
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
    zseqUsers: TZSequence;
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

