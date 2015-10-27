unit uPublicSupply;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, BGRALED, DTAnalogClock, BCPanel,
  BGRASpriteAnimation, DividerBevel, Forms, Controls, Graphics, Dialogs,
  ActnList, Menus, ComCtrls, ExtCtrls, StdCtrls, LCLIntf, process;

type

  { TfrmPublicSupply }

  TfrmPublicSupply = class(TForm)
    actQuitApp: TAction;
    actPS: TActionList;
    BGRALEDConnection: TBGRALED;
    bgrSpriteLogo: TBGRASpriteAnimation;
    divExDatis: TDividerBevel;
    DTAnalogClock1: TDTAnalogClock;
    Image1: TImage;
    Image2: TImage;
    imgGeneral: TImageList;
    Label2: TLabel;
    Label3: TLabel;
    lblAboutFormsDoc: TLabel;
    lblAboutFormsPdf: TLabel;
    lblAboutModule: TLabel;
    lblAboutModuleDoc: TLabel;
    lblBackup: TLabel;
    lblDate: TLabel;
    lblEditDataDoc: TLabel;
    lblEditDataPdf: TLabel;
    lblModuleTitle: TLabel;
    MenuItem1: TMenuItem;
    MenuItem2: TMenuItem;
    MenuItem3: TMenuItem;
    mnuPS: TMainMenu;
    panelForms: TBCPanel;
    panelLogo: TPanel;
    panelMnu: TPanel;
    saveFbk: TSaveDialog;
    shapeLogo: TShape;
    statusBarGeneral: TStatusBar;
    stConnectionStatus: TStaticText;
    toolBarPS: TToolBar;
    ToolButton1: TToolButton;
    procedure actQuitAppExecute(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { private declarations }
    procedure closePriorForm;
    procedure backupDb(const fbkPath : String);
    procedure showHomePage;
  public
    { public declarations }
    HELP_PATH : String;
  end;

var
  frmPublicSupply: TfrmPublicSupply;
const
  PRJ_HOME : String = 'http://sourceforge.net/projects/emissoftware/';
  MAX_CTRLS : ShortInt = 5;
implementation
uses
  uDModule;
{$R *.lfm}

{ TfrmPublicSupply }

procedure TfrmPublicSupply.actQuitAppExecute(Sender: TObject);
begin
  {close main form and terminate app}
  Close;
  Application.Terminate;
end;

procedure TfrmPublicSupply.FormShow(Sender: TObject);
var
  userHome : String;
  gifAnimate : String;
  currDate : TDate;
  dayName : String;
begin
  HELP_PATH:= '-';
  {$IfDef WINDOWS}
    HELP_PATH:= 'c:\exdatis\hlp\';
    gifAnimate:= 'c:\exdatis\icons\exdatis.gif';
  {$EndIf}
  {$IfDef Linux}
    userHome:= GetUserDir;
    HELP_PATH:=  userHome + 'exdatis/hlp/';
    gifAnimate:= userHome + 'exdatis/icons/exdatis.gif';
  {$EndIf}
  //ShowMessage(HELP_PATH);
  {enable the clock}
  DTAnalogClock1.Enabled:= True;
  {set date}
  currDate:= Now;
  case DayOfWeek(currDate) of
    1: dayName:= 'Nedelja';
    2: dayName:= 'Ponedeljak';
    3: dayName:= 'Utorak';
    4: dayName:= 'Sreda';
    5: dayName:= 'Četvrtak';
    6: dayName:= 'Petak';
    7: dayName:= 'Subota';
  end;
  lblDate.Caption:= ' ' + dayName + ': ' + FormatDateTime('dd.MM.yyyy', currDate) + ' god.';
  {animated gif}
  bgrSpriteLogo.AnimatedGifToSprite(gifAnimate);
  bgrSpriteLogo.AnimRepeat:= 0;
  bgrSpriteLogo.AnimSpeed:= 100;
  bgrSpriteLogo.ShowHint:= True;
  Application.ProcessMessages;
end;

procedure TfrmPublicSupply.closePriorForm;
begin
  if(panelForms.ControlCount > MAX_CTRLS) then
    TForm(panelForms.Controls[MAX_CTRLS]).Close;
end;

procedure TfrmPublicSupply.backupDb(const fbkPath: String);
const
  winHeader : String = '@echo off ' ;
  linHeader : String = '#!/bin/sh ';
  successMsg : String = 'Arhiviranje je uspešno završeno. ';
var
  bcpProc : TProcess;
  thisDb : String;
  withUser, withPassword : String;
  cmdStrings : TStringList;
  fullCmd : String;
  cmdFile : String; {path of sh or bat}
  s : ansistring;
begin
  {show cursor sqlwait}
  Screen.Cursor:= crSQLWait;

  {find db for backup}
  thisDb:= ' ' + dModule.zdbh.HostName + ':';
  thisDb:= thisDb + dModule.zdbh.Database + '  ';
  {user and password}
  withUser:= ' -user ' + dModule.zdbh.User;
  withPassword:= ' -password ' + dModule.zdbh.Password;

  {concat full cmd}
  fullCmd:= 'gbak' + ' -b -g -v ';
  {add database(source) and destination}

  fullCmd:= fullCmd + thisDb + ' ';
  fullCmd:= fullCmd + fbkPath + ' ';

  {add user and password}
  fullCmd:= fullCmd + withUser + ' ';
  fullCmd:= fullCmd + withPassword  + ' ';
  {debug msg}
  //ShowMessage(fullCmd);

  cmdStrings:= TStringList.Create;
  {$IfDef windows}
    cmdStrings.Append(winHeader);
  {$EndIf}
  {$IfDef linux}
    cmdStrings.Append(linHeader);
  {$EndIf}

  //cmdStrings.Append('echo --ExDatis database backup --');
  {debug test}
  //cmdStrings.Append('sleep 1');
  {add cmd}
  cmdStrings.Append(fullCmd);

  {$IfDef windows}
    cmdStrings.Append('PAUSE');
  {$EndIf}
  {$IfDef linux}
    cmdStrings.Append(' sleep 3');
  {$EndIf}

  {save file}
  {$IfDef windows}
    cmdFile:= 'C:\exdatis\bcp.bat';
    cmdStrings.SaveToFile(cmdFile);
  {$EndIf}
  {$IfDef linux}
    cmdFile:= GetUserDir + 'exdatis/bcp.sh';
    cmdStrings.SaveToFile(cmdFile);
  {$EndIf}

  {process}
  {$IfDef WINDOWS}
    {creeate process}
    bcpProc:= TProcess.Create(nil);
    bcpProc.CommandLine:= cmdFile;
    {execute options}
    bcpProc.Options:= bcpProc.Options + [poWaitOnExit, poNewConsole];
    {execute}
    bcpProc.Execute;
    {free}
    bcpProc.Free;
  {$EndIf}
  {just run}
  {$IfDef Linux}
   RunCommand('sh', [cmdFile], s);
  {$EndIf}

  {clear shell cmd}
  cmdStrings.Clear;
  cmdStrings.Append(' -- END --');
  cmdStrings.Append(FormatDateTime('dd.MM.yyyy hh:nn', Now));
  cmdStrings.SaveToFile(cmdFile);
  {reset cursor}
  Screen.Cursor:= crDefault;
  Application.ProcessMessages;
  {free string_list}
  cmdStrings.Free;
  {success msg}
  ShowMessage(successMsg);
end;

procedure TfrmPublicSupply.showHomePage;
begin
  {open project home-page}
  Screen.Cursor:= crHourGlass;
  try
    OpenURL(PRJ_HOME);
  finally
    Screen.Cursor:= crDefault;
  end;
end;

end.

