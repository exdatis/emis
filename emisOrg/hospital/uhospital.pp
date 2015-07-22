unit uhospital;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,
  ActnList, uBaseDbForm, db, ZDataset, ZSequence, ZSqlUpdate;

type

  { TfrmHospital }

  TfrmHospital = class(TbaseDbForm)
    dsHospital: TDataSource;
    groupBoxEdit: TGroupBox;
    zqHospital: TZQuery;
    zqHospitalH_ADDRESS: TStringField;
    zqHospitalH_CODE: TStringField;
    zqHospitalH_FAX: TStringField;
    zqHospitalH_ID: TLongintField;
    zqHospitalH_LOCATION: TLongintField;
    zqHospitalH_MAIL: TStringField;
    zqHospitalH_NAME: TStringField;
    zqHospitalH_PHONE: TStringField;
    zqHospitalH_REG_NUMBER: TStringField;
    zqHospitalH_SITE: TStringField;
    zqHospitalH_TAX_NUMBER: TStringField;
    zqHospitalLOCATION_NAME: TStringField;
    zqHospitalZIP_CODE: TStringField;
    zseqHospital: TZSequence;
    zupdHospital: TZUpdateSQL;
  private
    { private declarations }
    procedure saveBeforeClose;
  public
    { public declarations }
    procedure onActFirst; override;
    procedure onActPrior; override;
    procedure onActNext; override;
    procedure onActLast; override;
    procedure onActInsert; override;
    procedure onActDelete; override;
    procedure onActEdit; override;
    procedure onActSave; override;
    procedure onActCancel; override;
  end;

var
  frmHospital: TfrmHospital;
const
  {fields of tbl location(FH -> fields hospital)}
  FH_ID : String = 'H_ID';
  FH_CODE : String = 'H_CODE';
  FH_NAME : String = 'H_NAME';
  FH_LOCATION : String = 'H_LOCATION';
  FH_ADDRESS : String = 'H_ADDRESS';
  FH_TAX_NUMBER : String = 'H_TAX_NUMBER';
  FH_REG_NUMBER : String = 'H_REG_NUMBER';
  FH_PHONE : String = 'H_PHONE';
  FH_FAX : String = 'H_FAX';
  FH_MAIL : String = 'H_MAIL';
  FH_SITE : String = 'H_SITE';
implementation
uses
  uDModule, uConfirm;
{$R *.lfm}

{ TfrmHospital }

procedure TfrmHospital.saveBeforeClose;
begin

end;

procedure TfrmHospital.onActFirst;
begin

end;

procedure TfrmHospital.onActPrior;
begin

end;

procedure TfrmHospital.onActNext;
begin

end;

procedure TfrmHospital.onActLast;
begin

end;

procedure TfrmHospital.onActInsert;
begin

end;

procedure TfrmHospital.onActDelete;
begin

end;

procedure TfrmHospital.onActEdit;
begin

end;

procedure TfrmHospital.onActSave;
begin

end;

procedure TfrmHospital.onActCancel;
begin

end;

end.

