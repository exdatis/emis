unit uPanel;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  StdCtrls, ActnList, LCLIntf, Buttons, Menus;

type

  { TfrmPanel }

  TfrmPanel = class(TForm)
    actAppQuit: TAction;
    actPanel: TActionList;
    btnQuitApp: TBitBtn;
    GroupBox1: TGroupBox;
    Image1: TImage;
    imgPanel: TImageList;
    lblPanelTitle: TLabel;
    MenuItem1: TMenuItem;
    pupPanel: TPopupMenu;
    Shape1: TShape;
    tryIcoPanel: TTrayIcon;
    procedure actAppQuitExecute(Sender: TObject);
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

implementation

{$R *.lfm}

{ TfrmPanel }

procedure TfrmPanel.actAppQuitExecute(Sender: TObject);
begin
  {close main form and terminate app}
  self.Close;
  Application.Terminate;
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

