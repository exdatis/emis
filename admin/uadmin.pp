unit uAdmin;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, BGRALED, DTAnalogClock, BCPanel,
  BGRASpriteAnimation, DividerBevel, Forms, Controls, Graphics, Dialogs,
  ExtCtrls, StdCtrls, ComCtrls, ActnList, Menus, process;

type

  { TfrmAdmin }

  TfrmAdmin = class(TForm)
    actHelp: TActionList;
    actDbBackup: TAction;
    actXorIni: TAction;
    actUserPrivileges: TAction;
    actModule: TAction;
    actQuitApp: TAction;
    alAdmin: TActionList;
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
    MenuItem4: TMenuItem;
    MenuItem5: TMenuItem;
    MenuItem6: TMenuItem;
    MenuItem7: TMenuItem;
    MenuItem8: TMenuItem;
    MenuItem9: TMenuItem;
    mnuAdmin: TMainMenu;
    panelForms: TBCPanel;
    panelLogo: TPanel;
    panelMnu: TPanel;
    saveFbk: TSaveDialog;
    shapeLogo: TShape;
    statusBarAdmin: TStatusBar;
    stConnectionStatus: TStaticText;
    tbAdmin: TToolBar;
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
    ToolButton3: TToolButton;
    ToolButton4: TToolButton;
    ToolButton5: TToolButton;
    ToolButton6: TToolButton;
    ToolButton7: TToolButton;
    procedure actDbBackupExecute(Sender: TObject);
    procedure actModuleExecute(Sender: TObject);
    procedure actQuitAppExecute(Sender: TObject);
    procedure actUserPrivilegesExecute(Sender: TObject);
    procedure actXorIniExecute(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure lblBackupClick(Sender: TObject);
    procedure lblBackupMouseEnter(Sender: TObject);
    procedure lblBackupMouseLeave(Sender: TObject);
  private
    { private declarations }
    procedure closePriorForm;
    procedure backupDb(const fbkPath : String);
  public
    { public declarations }
    HELP_PATH : String;
  end;

var
  frmAdmin: TfrmAdmin;
const
  PRJ_HOME : String = 'http://sourceforge.net/projects/emissoftware/';
  MAX_CTRLS : ShortInt = 5;
implementation
uses
  uDModule, uModule, uUserPrivileges;
{$R *.lfm}

{ TfrmAdmin }

procedure TfrmAdmin.actQuitAppExecute(Sender: TObject);
begin
  {close main form and terminate app}
  self.Close;
  Application.Terminate;
end;

procedure TfrmAdmin.actUserPrivilegesExecute(Sender: TObject);
const
  sql : String = 'SELECT CURRENT_DATE + 180 FROM RDB$DATABASE';
var
  newForm : TfrmUserPrivileges;
  controlDate : TDate;
begin
  {set cursor(wait)}
  Screen.Cursor:= crHourGlass;
  {clear old forms}
  closePriorForm;
  try
    //find control-date
    dModule.zqGeneral.Close;
    dModule.zqGeneral.SQL.Clear;
    dModule.zqGeneral.SQL.Text:= sql;
    dModule.zqGeneral.Open;
    if(not dModule.zqGeneral.IsEmpty) then
      controlDate:= dModule.zqGeneral.Fields[0].AsDateTime
    else
      controlDate:= Now;
    //create form
    newForm:= TfrmUserPrivileges.Create(nil);
    {set parent ctrl}
    newForm.Parent:= panelForms;
    {set position}
    newForm.Left:= 0;
    newForm.Top:= 0;
    //set control-date
    newForm.setControlDate(controlDate);
    {open dataSets}
    newForm.openRODataSets;
    Application.ProcessMessages;
    newForm.applyCharFilter; {with default char}
    {show form}
    newForm.Show;
    {set focus to enable shortcuts}
    newForm.SetFocus;
  finally
    Screen.Cursor:= crDefault;
  end;
end;

procedure TfrmAdmin.actXorIniExecute(Sender: TObject);
var
  startApp : TProcess;
  appName : String;
begin
  // create p[rocess
  startApp:= TProcess.Create(nil);
  {$IfDef Windows}
    appName:= 'xorIni.exe';
  {$EndIf}
  {$IfDef linux}
    appName:= 'xorIni';
  {$EndIf}

  startApp.Executable:= appName;
  startApp.Options:= startApp.Options + [poWaitOnExit];
  startApp.Execute;
  // free process
  startApp.Free;
end;


procedure TfrmAdmin.actDbBackupExecute(Sender: TObject);
var
  defaultPath : String;
  fbkFile : String;
  currDate : String;
  fbkName : String;
  currMonth : String;
begin
  {find initial folder}
  {$IfDef windows}
    defaultPath:= 'C:\exdatis\bcp\';
  {$EndIf}
  {$IfDef linux}
    defaultPath:= GetUserDir + 'exdatis/bcp/';
  {$EndIf}
  saveFbk.InitialDir:= defaultPath;
  {set default name of fbk}
  currDate:= FormatDateTime('dd.MM.yyyy', Now);
  fbkName:= ExtractFileNameOnly(dModule.zdbh.Database);

  fbkName:= fbkName + LeftStr(currDate, 2);
  currMonth:= Copy(currDate, 4, 2);
  fbkName:= fbkName + currMonth;
  fbkName:= fbkName + RightStr(currDate, 4);
  {add extension}
  fbkName:= fbkName + '.fbk';
  saveFbk.FileName:= fbkName;
  {run dialog}
  if saveFbk.Execute then
    if(Length(saveFbk.FileName) > 5) then
      begin
        fbkFile:= saveFbk.FileName;
        backupDb(fbkFile);
      end;
end;

procedure TfrmAdmin.actModuleExecute(Sender: TObject);
var
  newForm : TfrmModule;
begin
  {set cursor(wait)}
  Screen.Cursor:= crHourGlass;
  {clear old forms}
  closePriorForm;
  try
    newForm:= TfrmModule.Create(nil);
    {set parent ctrl}
    newForm.Parent:= panelForms;
    {set position}
    newForm.Left:= 0;
    newForm.Top:= 0;
    {open dataSets}
    newForm.openDataSet;
    {show form}
    newForm.Show;
    {set focus to enable shortcuts}
    newForm.SetFocus;
  finally
    Screen.Cursor:= crDefault;
  end;
end;

procedure TfrmAdmin.FormShow(Sender: TObject);
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

procedure TfrmAdmin.lblBackupClick(Sender: TObject);
begin
  {backup db}
  actDbBackup.Execute;
end;

procedure TfrmAdmin.lblBackupMouseEnter(Sender: TObject);
begin
  {pseudo-link, underline}
  lblBackup.Font.Underline:= True;
  {set color}
  lblBackup.Color:= clMaroon;
end;

procedure TfrmAdmin.lblBackupMouseLeave(Sender: TObject);
begin
  {reset pseud-link}
  lblBackup.Font.Underline:= False;
  {set color}
  lblBackup.Color:= clGray;
end;

procedure TfrmAdmin.closePriorForm;
begin
  if(panelForms.ControlCount > MAX_CTRLS) then
    TForm(panelForms.Controls[MAX_CTRLS]).Close;
end;

procedure TfrmAdmin.backupDb(const fbkPath: String);
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

end.

