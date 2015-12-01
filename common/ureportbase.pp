unit uReportBase;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls;

type

  { TfrmReportBase }

  TfrmReportBase = class(TForm)
    lblReportTitle: TLabel;
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  frmReportBase: TfrmReportBase;

implementation

{$R *.lfm}

end.

