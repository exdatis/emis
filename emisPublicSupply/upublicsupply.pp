unit uPublicSupply;

{$mode objfpc}{$H+}
{-------------------------------------------------------------------------------
 Morar 2015-10-27 public-procurement
 ------------------------------------------------------------------------------}
interface

uses
  Classes, SysUtils, FileUtil, BGRALED, DTAnalogClock, BCPanel,
  BGRASpriteAnimation, DividerBevel, Forms, Controls, Graphics, Dialogs,
  ActnList, Menus, ComCtrls, ExtCtrls, StdCtrls, LCLIntf, process, strutils,
  IniFiles;

type

  { TfrmPublicSupply }

  TfrmPublicSupply = class(TForm)
    actItemsOrderType: TAction;
    actSupplyType: TAction;
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
    MenuItem4: TMenuItem;
    MenuItem5: TMenuItem;
    MenuItem6: TMenuItem;
    MenuItem7: TMenuItem;
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
    ToolButton2: TToolButton;
    ToolButton3: TToolButton;
    ToolButton4: TToolButton;
    ToolButton5: TToolButton;
    procedure actItemsOrderTypeExecute(Sender: TObject);
    procedure actQuitAppExecute(Sender: TObject);
    procedure actSupplyTypeExecute(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { private declarations }
    procedure closePriorForm;
    procedure backupDb(const fbkPath : String);
    function checkUser(const ini_file : String) : Boolean;
    procedure showHomePage;
  public
    { public declarations }
    HELP_PATH : String;
    INI_PATH : String;
  end;

var
  frmPublicSupply: TfrmPublicSupply;
const
  PRJ_HOME : String = 'http://sourceforge.net/projects/emissoftware/';
  MAX_CTRLS : ShortInt = 5;
implementation
uses
  uDModule, uSupplyType, uItemsOrderType, uLogin;
{$R *.lfm}

{ TfrmPublicSupply }

procedure TfrmPublicSupply.actQuitAppExecute(Sender: TObject);
begin
  {close main form and terminate app}
  Close;
  Application.Terminate;
end;

procedure TfrmPublicSupply.actItemsOrderTypeExecute(Sender: TObject);
var
  newForm : TfrmItemsOrderType;
begin
  {set cursor(wait)}
  Screen.Cursor:= crHourGlass;
  {clear old forms}
  closePriorForm;
  try
    newForm:= TfrmItemsOrderType.Create(nil);
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

procedure TfrmPublicSupply.actSupplyTypeExecute(Sender: TObject);
var
  newForm : TfrmSupplyType;
begin
  {set cursor(wait)}
  Screen.Cursor:= crHourGlass;
  {clear old forms}
  closePriorForm;
  try
    newForm:= TfrmSupplyType.Create(nil);
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
    INI_PATH:= 'c:\exdatis\db.ini';
  {$EndIf}
  {$IfDef Linux}
    userHome:= GetUserDir;
    HELP_PATH:=  userHome + 'exdatis/hlp/';
    gifAnimate:= userHome + 'exdatis/icons/exdatis.gif';
    INI_PATH:= userHome + 'exdatis/db.ini';
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
  // close db and check user
  if(dModule.zdbh.Connected) then
    dModule.zdbh.Disconnect;
  Application.ProcessMessages;
  if(not checkUser(INI_PATH)) then
    begin
      self.Visible:= False;
      self.Close;
      Application.Terminate;
    end;
  // regards user and show form
  self.Caption:= self.Caption + '  ' + dModule.zqUserAU_TITLE.AsString + ' ' + dModule.zqUserAU_FULL_NAME.AsString;
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

function TfrmPublicSupply.checkUser(const ini_file: String): Boolean;
const
  ERR_MSG : String = 'Greška u inicijalizovanju podataka(ini file)';
  WRONG_USER : STring = 'Nepoznat korisnik/Neispravni podaci';
  NOT_VALID : String = 'Vaša licenca je istekla(nije validna).';
  FAILED_PRIVILEGES : String = 'Vi nemate privilegije za ovaj modul.';
  SQL : String = 'SELECT CURRENT_DATE FROM RDB$DATABASE';
  WRONG_DATE : String = 'Datum na vašem računaru nije ispravan!';
var
  newDialog : TdlgLogin;
  dbIni : TIniFile;
  dbList : TStringList;
  defaultIndex, i : Integer;
  currentSection, defaultSection : String;
  myDelimiter : TSysCharSet;
  localDate, srvDate : TDate;
  srvDateTxt, localDateTxt : String;
begin
  if(not FileExistsUTF8(ini_file)) then
   begin
     ShowMessage(ERR_MSG);
     Result:= False;
     Exit;
   end;
  //read sections
   try
     dbIni:= TIniFile.Create(INI_PATH);
     dbList:= TStringList.Create;
     dbIni.ReadSections(dbList);
     if(dbList.Count < 1) then
       begin
         ShowMessage(ERR_MSG);
         Result:= False;
         dbIni.Free;
         dbList.Free;
         Exit;
       end;
   except
    on e : Exception do
    begin
     ShowMessage(ERR_MSG);
     Result:= False;
     dbIni.Free;
     dbList.Free;
     Exit;
    end;
   end;
   // set TSysCharSet
   myDelimiter:= TSysCharSet(['_']);
   // create dialog
   newDialog:= TdlgLogin.Create(nil);
   //set default index
   defaultIndex:= 0; //the first
   for i := 0 to dbList.Count - 1 do
   begin
     currentSection:= dbList[i];
     //apend to comboBox
     newDialog.cmbDbList.Items.Append(currentSection);
     defaultSection:= ExtractDelimited(2, currentSection,myDelimiter);
     if(LowerCase(defaultSection) = 'default') then
       defaultIndex:= i;
   end;
   newDialog.cmbDbList.ItemIndex:= defaultIndex;
   if not(newDialog.ShowModal = mrOK) then
     begin
       Result:= False;
       dbIni.Free;
       dbList.Free;
       newDialog.Free;
       Exit;
     end;
   //check user

   dModule.zdbh.Database:= Trim(dbIni.ReadString(newDialog.cmbDbList.Text, 'db', ''));
   dModule.zdbh.HostName:= Trim(dbIni.ReadString(newDialog.cmbDbList.Text, 'host', ''));
   try
     dModule.zdbh.Connected:= True;
   except
     on e : Exception do
     begin
       ShowMessage(e.Message);
       Result:= False;
       dbIni.Free;
       dbList.Free;
       newDialog.Free;
       Exit;
     end;
   end;
   // open zquery user
   try
     dModule.zqUser.Close;
     dModule.zqUser.ParamByName('USER_NAME').AsString:= Trim(newDialog.edtUser.Text);
     dModule.zqUser.ParamByName('PASSWORD').AsString:= Trim(newDialog.edtPwd.Text);
     dModule.zqUser.Open;
     if(dModule.zqUser.IsEmpty) then
       begin
         ShowMessage(WRONG_USER);
         Result:= False;
         dbIni.Free;
         dbList.Free;
         newDialog.Free;
         Exit;
       end;
   except
     on e : Exception do
     begin
       ShowMessage(e.Message);
       Result:= False;
       dbIni.Free;
       dbList.Free;
       newDialog.Free;
       Exit;
     end;
   end;
   //validate
   if(dModule.zqUserAU_VALID.AsInteger < 1) then
     begin
       ShowMessage(NOT_VALID);
       Result:= False;
       dbIni.Free;
       dbList.Free;
       newDialog.Free;
       Exit;
     end;
   // privileges
   try
     dModule.zqPrivileges.Close;
     dModule.zqPrivileges.ParamByName('USER_ID').AsInteger:= dModule.zqUserAU_ID.AsInteger;
     dModule.zqPrivileges.Open;
     if(dModule.zqPrivileges.IsEmpty) then
       begin
         ShowMessage(FAILED_PRIVILEGES);
         Result:= False;
         dbIni.Free;
         dbList.Free;
         newDialog.Free;
         Exit;
       end;
   except
     on e : Exception do
     begin
       ShowMessage(e.Message);
       Result:= False;
       dbIni.Free;
       dbList.Free;
       newDialog.Free;
       Exit;
     end;
   end;
   //CHECK DATE
   try
     dModule.zqGeneral.Close;
     dModule.zqGeneral.SQL.Clear;
     dModule.zqGeneral.SQL.Text:= SQL;
     dModule.zqGeneral.Open;
     srvDate:= dModule.zqGeneral.Fields[0].AsDateTime;
     localDate:= TDate(Now());
     srvDateTxt:= FormatDateTime('dd.mm.yyyy', srvDate);
     localDateTxt:= FormatDateTime('dd.mm.yyyy', localDate);
     if (srvDateTxt <> localDateTxt) then
       ShowMessage(WRONG_DATE);
     //debug
     //ShowMessage(DateToStr(dModule.zqGeneral.Fields[0].AsDateTime));
     //ShowMessage(DateToStr(Now()));
     //ShowMessage(srvDateTxt + '-' + localDateTxt);
   except
     on e : Exception do
     begin
       ShowMessage(e.Message);
       Result:= False;
       dbIni.Free;
       dbList.Free;
       newDialog.Free;
       Exit;
     end;
   end;
   //return true
   dbIni.Free;
   dbList.Free;
   newDialog.Free;
   Result:= True;
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

