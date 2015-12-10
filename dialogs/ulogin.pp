unit uLogin;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls;

type

  { TdlgLogin }

  TdlgLogin = class(TForm)
    btnOk: TButton;
    btnCancel: TButton;
    cmbDbList: TComboBox;
    edtPwd: TEdit;
    edtUser: TEdit;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  dlgLogin: TdlgLogin;

implementation

{$R *.lfm}

end.

