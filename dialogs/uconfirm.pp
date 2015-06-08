unit uConfirm;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,
  ExtCtrls;

type

  { TdlgConfirm }

  TdlgConfirm = class(TForm)
    btnOk: TButton;
    btnCancel: TButton;
    GroupBox1: TGroupBox;
    Image1: TImage;
    memoMsg: TMemo;
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  dlgConfirm: TdlgConfirm;

implementation

{$R *.lfm}

end.

