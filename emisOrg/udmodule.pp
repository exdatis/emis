unit uDModule;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, FileUtil, ZDataset, ZConnection;

type
  TAppUser = Record
    u_id : Integer;
    u_title : String;
    u_full_name : String;
    u_user_name : String;
    u_password : String;
    u_department : Integer;
    u_code : String;
    privileges_type : Integer;
  end;

type

  { TdModule }

  TdModule = class(TDataModule)
    zdbh: TZConnection;
    zqGeneral: TZReadOnlyQuery;
    zqUser: TZReadOnlyQuery;
    zqUserAU_CODE: TStringField;
    zqUserAU_DEPARTMENT: TLongintField;
    zqUserAU_FULL_NAME: TStringField;
    zqUserAU_ID: TLongintField;
    zqUserAU_TITLE: TStringField;
    zqUserAU_USER_NAME: TStringField;
    zqUserAU_USER_PWD: TStringField;
    zqUserAU_VALID: TSmallintField;
    zqPrivileges: TZReadOnlyQuery;
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
  uExDatis;
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
  MODULE_ORG : Integer = 3;
begin
  zqPrivileges.ParamByName('MODULE_ID').AsInteger:= MODULE_ORG;
end;

end.

