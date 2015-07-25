unit uPanel;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  StdCtrls, ActnList, LCLIntf, Buttons, Menus, process;

type

  { TfrmPanel }

  TfrmPanel = class(TForm)
    actAppQuit: TAction;
    actGeneralData: TAction;
    actShowMenu: TAction;
    actPanel: TActionList;
    btnQuitApp: TBitBtn;
    GroupBox1: TGroupBox;
    Image1: TImage;
    imgPanel: TImageList;
    lblGeneralTbls: TLabel;
    lblPanelTitle: TLabel;
    MenuItem1: TMenuItem;
    MenuItem2: TMenuItem;
    MenuItem3: TMenuItem;
    pupPanel: TPopupMenu;
    Shape1: TShape;
    btnGeneralData: TSpeedButton;
    tryIcoPanel: TTrayIcon;
    procedure actAppQuitExecute(Sender: TObject);
    procedure actGeneralDataExecute(Sender: TObject);
    procedure actShowMenuExecute(Sender: TObject);
    procedure lblGeneralTblsClick(Sender: TObject);
    procedure lblGeneralTblsMouseEnter(Sender: TObject);
    procedure lblGeneralTblsMouseLeave(Sender: TObject);
    procedure lblPanelTitleClick(Sender: TObject);
    procedure lblPanelTitleMouseEnter(Sender: TObject);
    procedure lblPanelTitleMouseLeave(Sender: TObject);
    procedure tryIcoPanelClick(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  frmPanel: TfrmPanel;
const
  PRJ_HOME : String = 'http://sourceforge.net/projects/emissoftware/';
{$Define WORK_VER}
implementation

{$R *.lfm}

{ TfrmPanel }

procedure TfrmPanel.actAppQuitExecute(Sender: TObject);
begin
  {close main form and terminate app}
  self.Close;
  Application.Terminate;
end;

procedure TfrmPanel.actGeneralDataExecute(Sender: TObject);
var
  startApp : TProcess;
  exeFile : String;
begin
  {standard path of exe}
  exeFile:= 'emisGeneral.exe';
  {in work}
  {$IfDef WORK_VER}
    exeFile:= 'd:\emissoftware-code\emisGeneral\emisGeneral.exe';
  {$EndIf}
  startApp:= TProcess.Create(nil);
  try
    startApp.Executable:= exeFile;
    startApp.Options:= startApp.Options + [poNoConsole];
    startApp.Execute;
    startApp.Free;
  except
    on e : Exception do
    begin
      startApp.Free;
      ShowMessage(e.Message);
      Exit;
    end;
  end;
  {hide panel}
  frmPanel.Visible:= False;
end;

procedure TfrmPanel.actShowMenuExecute(Sender: TObject);
begin
  {show formPanel}
  frmPanel.Visible:= True;
end;

procedure TfrmPanel.lblGeneralTblsClick(Sender: TObject);
begin
  {start app generalData}
  actGeneralData.Execute;
end;

procedure TfrmPanel.lblGeneralTblsMouseEnter(Sender: TObject);
begin
  {set font-underline}
  lblGeneralTbls.Font.Underline:= True;
end;

procedure TfrmPanel.lblGeneralTblsMouseLeave(Sender: TObject);
begin
  {set font-underline}
  lblGeneralTbls.Font.Underline:= False;
end;

procedure TfrmPanel.lblPanelTitleClick(Sender: TObject);
begin
  {open project home page(sourceforge)}
  Screen.Cursor:= crHourGlass;
  try
    OpenURL(PRJ_HOME);
  finally
    Screen.Cursor:= crDefault;
  end;
end;

procedure TfrmPanel.lblPanelTitleMouseEnter(Sender: TObject);
begin
  {underline, link}
  lblPanelTitle.Font.Underline:= True;
end;

procedure TfrmPanel.lblPanelTitleMouseLeave(Sender: TObject);
begin
  {reset, underlane = false}
  lblPanelTitle.Font.Underline:= False;
end;

procedure TfrmPanel.tryIcoPanelClick(Sender: TObject);
begin
  {pop up}
  pupPanel.PopUp(Mouse.CursorPos.x, Mouse.CursorPos.y);
end;

end.

