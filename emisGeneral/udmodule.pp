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
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  dModule: TdModule;

implementation

{$R *.lfm}

end.
