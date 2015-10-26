unit uDModule;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, ZConnection, ZDataset;

type

  { TdModule }

  TdModule = class(TDataModule)
    zdbh: TZConnection;
    zqGeneral: TZReadOnlyQuery;
    procedure zdbhAfterConnect(Sender: TObject);
    procedure zdbhAfterDisconnect(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
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

end.

