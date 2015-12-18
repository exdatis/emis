unit uDModule;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, FileUtil, ZConnection, ZDataset;

type

  { TdModule }

  TdModule = class(TDataModule)
    zdbh: TZConnection;
    zqGeneral: TZReadOnlyQuery;
    zqPrivileges: TZReadOnlyQuery;
    zqUser: TZReadOnlyQuery;
    zqUserAU_CODE: TStringField;
    zqUserAU_DEPARTMENT: TLongintField;
    zqUserAU_FULL_NAME: TStringField;
    zqUserAU_ID: TLongintField;
    zqUserAU_TITLE: TStringField;
    zqUserAU_USER_NAME: TStringField;
    zqUserAU_USER_PWD: TStringField;
    zqUserAU_VALID: TSmallintField;
    procedure zdbhAfterConnect(Sender: TObject);
    procedure zdbhAfterDisconnect(Sender: TObject);
    procedure zqPrivilegesBeforeOpen(DataSet: TDataSet);
  private
    { private declarations }
  public
    { public declarations }
    validDate : TDate;
  end;

var
  dModule: TdModule;

implementation
uses
  uExDatisShare;
{$R *.lfm}

{ TdModule }

procedure TdModule.zdbhAfterConnect(Sender: TObject);
begin
  showConnectionStatus(True);
end;

procedure TdModule.zdbhAfterDisconnect(Sender: TObject);
begin
  showConnectionStatus(False);
end;

procedure TdModule.zqPrivilegesBeforeOpen(DataSet: TDataSet);
const
  MODULE_GENERAL : Integer = 2;
begin
  zqPrivileges.ParamByName('MODULE_ID').AsInteger:= MODULE_GENERAL;
end;

end.

