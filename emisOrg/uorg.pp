unit uorg;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, BCPanel, DTAnalogClock, BGRALED, strutils,
  BGRASpriteAnimation, DividerBevel, Forms, Controls, Graphics, Dialogs,
  ExtCtrls, StdCtrls, Menus, ActnList, LCLIntf, ComCtrls, process, IniFiles;

type

  { TfrmOrg }

  TfrmOrg = class(TForm)
    actGeneral: TActionList;
    actHospitalFrm: TAction;
    actDepartmentFrm: TAction;
    actDrugWarehouse: TAction;
    actAppliancesWarehouse: TAction;
    actFoodWarehouse: TAction;
    actHygieneWarehouse: TAction;
    actHEquipmentWarehouse: TAction;
    actAppliancesHPWarehouse: TAction;
    actDrugHPWarehouse: TAction;
    actFoodHPWarehouse: TAction;
    actHEquipmentHPWarehouse: TAction;
    actHygieneHPWarehouse: TAction;
    actHelp: TActionList;
    actHlpAboutModulePdf: TAction;
    actHlpAboutModuleDoc: TAction;
    actHlpAboutFormsPdf: TAction;
    actHlpAboutFormsDoc: TAction;
    actHlpEditDataPdf: TAction;
    actHlpEditDataDoc: TAction;
    actDbBackup: TAction;
    actOfficeHPWarehouse: TAction;
    actMaterialsHPWarehouse: TAction;
    actMaterialsWarehouse: TAction;
    actOfficeWarehouse: TAction;
    actQuitApp: TAction;
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
    MenuItem10: TMenuItem;
    MenuItem11: TMenuItem;
    MenuItem12: TMenuItem;
    MenuItem13: TMenuItem;
    MenuItem14: TMenuItem;
    MenuItem15: TMenuItem;
    MenuItem16: TMenuItem;
    MenuItem17: TMenuItem;
    MenuItem18: TMenuItem;
    MenuItem19: TMenuItem;
    MenuItem2: TMenuItem;
    MenuItem20: TMenuItem;
    MenuItem21: TMenuItem;
    MenuItem22: TMenuItem;
    MenuItem23: TMenuItem;
    MenuItem24: TMenuItem;
    MenuItem25: TMenuItem;
    MenuItem26: TMenuItem;
    MenuItem27: TMenuItem;
    MenuItem28: TMenuItem;
    MenuItem29: TMenuItem;
    MenuItem3: TMenuItem;
    MenuItem30: TMenuItem;
    MenuItem4: TMenuItem;
    MenuItem5: TMenuItem;
    MenuItem6: TMenuItem;
    MenuItem7: TMenuItem;
    MenuItem8: TMenuItem;
    MenuItem9: TMenuItem;
    mnuGeneral: TMainMenu;
    panelForms: TBCPanel;
    panelLogo: TPanel;
    panelMnu: TPanel;
    saveFbk: TSaveDialog;
    shapeLogo: TShape;
    statusBarGeneral: TStatusBar;
    stConnectionStatus: TStaticText;
    toolBarGeneral: TToolBar;
    ToolButton1: TToolButton;
    ToolButton10: TToolButton;
    ToolButton11: TToolButton;
    ToolButton12: TToolButton;
    ToolButton2: TToolButton;
    ToolButton3: TToolButton;
    ToolButton4: TToolButton;
    ToolButton5: TToolButton;
    ToolButton6: TToolButton;
    ToolButton7: TToolButton;
    ToolButton8: TToolButton;
    ToolButton9: TToolButton;
    procedure actAppliancesHPWarehouseExecute(Sender: TObject);
    procedure actAppliancesWarehouseExecute(Sender: TObject);
    procedure actDbBackupExecute(Sender: TObject);
    procedure actDepartmentFrmExecute(Sender: TObject);
    procedure actDrugHPWarehouseExecute(Sender: TObject);
    procedure actDrugWarehouseExecute(Sender: TObject);
    procedure actFoodHPWarehouseExecute(Sender: TObject);
    procedure actFoodWarehouseExecute(Sender: TObject);
    procedure actHEquipmentHPWarehouseExecute(Sender: TObject);
    procedure actHEquipmentWarehouseExecute(Sender: TObject);
    procedure actHlpAboutFormsDocExecute(Sender: TObject);
    procedure actHlpAboutFormsPdfExecute(Sender: TObject);
    procedure actHlpEditDataDocExecute(Sender: TObject);
    procedure actHlpEditDataPdfExecute(Sender: TObject);
    procedure actHospitalFrmExecute(Sender: TObject);
    procedure actHygieneHPWarehouseExecute(Sender: TObject);
    procedure actHygieneWarehouseExecute(Sender: TObject);
    procedure actMaterialsHPWarehouseExecute(Sender: TObject);
    procedure actMaterialsWarehouseExecute(Sender: TObject);
    procedure actOfficeHPWarehouseExecute(Sender: TObject);
    procedure actOfficeWarehouseExecute(Sender: TObject);
    procedure actQuitAppExecute(Sender: TObject);
    procedure divExDatisClick(Sender: TObject);
    procedure divExDatisMouseEnter(Sender: TObject);
    procedure divExDatisMouseLeave(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure lblAboutFormsDocClick(Sender: TObject);
    procedure lblAboutFormsDocMouseEnter(Sender: TObject);
    procedure lblAboutFormsDocMouseLeave(Sender: TObject);
    procedure lblAboutFormsPdfClick(Sender: TObject);
    procedure lblAboutFormsPdfMouseEnter(Sender: TObject);
    procedure lblAboutFormsPdfMouseLeave(Sender: TObject);
    procedure lblBackupClick(Sender: TObject);
    procedure lblBackupMouseEnter(Sender: TObject);
    procedure lblBackupMouseLeave(Sender: TObject);
    procedure lblEditDataDocClick(Sender: TObject);
    procedure lblEditDataDocMouseEnter(Sender: TObject);
    procedure lblEditDataDocMouseLeave(Sender: TObject);
    procedure lblEditDataPdfClick(Sender: TObject);
    procedure lblEditDataPdfMouseEnter(Sender: TObject);
    procedure lblEditDataPdfMouseLeave(Sender: TObject);
    procedure lblModuleTitleClick(Sender: TObject);
    procedure lblModuleTitleMouseEnter(Sender: TObject);
    procedure lblModuleTitleMouseLeave(Sender: TObject);
  private
    { private declarations }
    procedure closePriorForm;
    procedure backupDb(const fbkPath : String);
    function checkUser(const ini_file : String) : Boolean;
  public
    { public declarations }
    HELP_PATH : String;
    INI_PATH : String;
  end;

var
  frmOrg: TfrmOrg;
const
  PRJ_HOME : String = 'http://sourceforge.net/projects/emissoftware/';
  MAX_CTRLS : ShortInt = 5;
implementation
uses
  uhospital, uDModule, uDepartment, uDrugWarehouse, uAppliancesWarehouse,
  uFoodWarehouse, uOfficeWarehouse, uMaterialsWarehouse, uHygieneWarehouse,
  uHEquipmentWarehouse, uAppliancesHPWarehouse, uDrugHPWarehouse,
  uFoodHPWarehouse, uHEquipmentHPWarehouse, uHygieneHPWarehouse,
  uMaterialsHPWarehouse, uOfficeHPWarehouse, uLogin;
{$R *.lfm}

{ TfrmOrg }

procedure TfrmOrg.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  { free and nil }
  CloseAction:= caFree;
  self:= nil;
end;

procedure TfrmOrg.FormShow(Sender: TObject);
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

procedure TfrmOrg.lblAboutFormsDocClick(Sender: TObject);
begin
  {show help}
  actHlpAboutFormsDoc.Execute;
end;

procedure TfrmOrg.lblAboutFormsDocMouseEnter(Sender: TObject);
begin
  {pseudo-link, underline}
  lblAboutFormsDoc.Font.Underline:= True;
  {set color}
  lblAboutFormsDoc.Color:= clMaroon;
end;

procedure TfrmOrg.lblAboutFormsDocMouseLeave(Sender: TObject);
begin
  {reset pseudo-link, underline = False}
  lblAboutFormsDoc.Font.Underline:= False;
  {set color}
  lblAboutFormsDoc.Color:= clGray;
end;

procedure TfrmOrg.lblAboutFormsPdfClick(Sender: TObject);
begin
  {show help}
  actHlpAboutFormsPdf.Execute;
end;

procedure TfrmOrg.lblAboutFormsPdfMouseEnter(Sender: TObject);
begin
  {pseudo-link, underline}
  lblAboutFormsPdf.Font.Underline:= True;
  {set color}
  lblAboutFormsPdf.Color:= clMaroon;
end;

procedure TfrmOrg.lblAboutFormsPdfMouseLeave(Sender: TObject);
begin
  {reset pseudo-link, underline = False}
  lblAboutFormsPdf.Font.Underline:= False;
  {set color}
  lblAboutFormsPdf.Color:= clGray;
end;

procedure TfrmOrg.lblBackupClick(Sender: TObject);
begin
  {backup db}
  actDbBackup.Execute;
end;

procedure TfrmOrg.lblBackupMouseEnter(Sender: TObject);
begin
  {pseudo-link, underline}
  lblBackup.Font.Underline:= True;
  {set color}
  lblBackup.Color:= clMaroon;
end;

procedure TfrmOrg.lblBackupMouseLeave(Sender: TObject);
begin
  {reset pseud-link}
  lblBackup.Font.Underline:= False;
  {set color}
  lblBackup.Color:= clGray;
end;

procedure TfrmOrg.lblEditDataDocClick(Sender: TObject);
begin
  {show help}
  actHlpEditDataDoc.Execute;
end;

procedure TfrmOrg.lblEditDataDocMouseEnter(Sender: TObject);
begin
  {pseudo-link, underline}
  lblEditDataDoc.Font.Underline:= True;
  {set color}
  lblEditDataDoc.Color:= clMaroon;
end;

procedure TfrmOrg.lblEditDataDocMouseLeave(Sender: TObject);
begin
  {reset pseudo-link, underline = False}
  lblEditDataDoc.Font.Underline:= False;
  {set color}
  lblEditDataDoc.Color:= clGray;
end;

procedure TfrmOrg.lblEditDataPdfClick(Sender: TObject);
begin
  {show help}
  actHlpEditDataPdf.Execute;
end;

procedure TfrmOrg.lblEditDataPdfMouseEnter(Sender: TObject);
begin
  {pseudo-link, underline}
  lblEditDataPdf.Font.Underline:= True;
  {set color}
  lblEditDataPdf.Color:= clMaroon;
end;

procedure TfrmOrg.lblEditDataPdfMouseLeave(Sender: TObject);
begin
  {reset pseudo-link, underline = False}
  lblEditDataPdf.Font.Underline:= False;
  {set color}
  lblEditDataPdf.Color:= clGray;
end;

procedure TfrmOrg.divExDatisClick(Sender: TObject);
begin
  {open project home-page}
  Screen.Cursor:= crHourGlass;
  try
    OpenURL(PRJ_HOME);
  finally
    Screen.Cursor:= crDefault;
  end;
end;

procedure TfrmOrg.actQuitAppExecute(Sender: TObject);
begin
  {close main form and terminate app}
  self.Close;
  Application.Terminate;
end;

procedure TfrmOrg.actHospitalFrmExecute(Sender: TObject);
var
  newForm : TfrmHospital;
begin
  {set cursor(wait)}
  Screen.Cursor:= crHourGlass;
  {clear old forms}
  closePriorForm;
  try
    newForm:= TfrmHospital.Create(nil);
    {set parent ctrl}
    newForm.Parent:= panelForms;
    {set position}
    newForm.Left:= 0;
    newForm.Top:= 0;
    {open dataSets}
    newForm.openDataSet;
    {set help-path}
    newForm.HELP_PATH:= HELP_PATH;
    {show form}
    newForm.Show;
    {set focus to enable shortcuts}
    newForm.SetFocus;
  finally
    Screen.Cursor:= crDefault;
  end;

end;

procedure TfrmOrg.actHygieneHPWarehouseExecute(Sender: TObject);
var
  newForm : TfrmHygieneHPWarehouse;
begin
  {set cursor(wait)}
  Screen.Cursor:= crHourGlass;
  {clear old forms}
  closePriorForm;
  try
    newForm:= TfrmHygieneHPWarehouse.Create(nil);
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

procedure TfrmOrg.actHygieneWarehouseExecute(Sender: TObject);
var
  newForm : TfrmHygieneWarehouse;
begin
  {set cursor(wait)}
  Screen.Cursor:= crHourGlass;
  {clear old forms}
  closePriorForm;
  try
    newForm:= TfrmHygieneWarehouse.Create(nil);
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

procedure TfrmOrg.actMaterialsHPWarehouseExecute(Sender: TObject);
var
  newForm : TfrmMaterialsHPWarehouse;
begin
  {set cursor(wait)}
  Screen.Cursor:= crHourGlass;
  {clear old forms}
  closePriorForm;
  try
    newForm:= TfrmMaterialsHPWarehouse.Create(nil);
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

procedure TfrmOrg.actMaterialsWarehouseExecute(Sender: TObject);
var
  newForm : TfrmMaterialsWarehouse;
begin
  {set cursor(wait)}
  Screen.Cursor:= crHourGlass;
  {clear old forms}
  closePriorForm;
  try
    newForm:= TfrmMaterialsWarehouse.Create(nil);
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

procedure TfrmOrg.actOfficeHPWarehouseExecute(Sender: TObject);
var
  newForm : TfrmOfficeHPWarehouse;
begin
  {set cursor(wait)}
  Screen.Cursor:= crHourGlass;
  {clear old forms}
  closePriorForm;
  try
    newForm:= TfrmOfficeHPWarehouse.Create(nil);
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

procedure TfrmOrg.actOfficeWarehouseExecute(Sender: TObject);
var
  newForm : TfrmOfficeWarehouse;
begin
  {set cursor(wait)}
  Screen.Cursor:= crHourGlass;
  {clear old forms}
  closePriorForm;
  try
    newForm:= TfrmOfficeWarehouse.Create(nil);
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

procedure TfrmOrg.actDepartmentFrmExecute(Sender: TObject);
var
  newForm : TfrmDepartment;
begin
  {set cursor(wait)}
  Screen.Cursor:= crHourGlass;
  {clear old forms}
  closePriorForm;
  try
    newForm:= TfrmDepartment.Create(nil);
    {set parent ctrl}
    newForm.Parent:= panelForms;
    {set position}
    newForm.Left:= 0;
    newForm.Top:= 0;
    {open dataSets}
    newForm.openDataSet;
    {set help-path}
    newForm.HELP_PATH:= HELP_PATH;
    {show form}
    newForm.Show;
    {set focus to enable shortcuts}
    newForm.SetFocus;
  finally
    Screen.Cursor:= crDefault;
  end;
end;

procedure TfrmOrg.actDrugHPWarehouseExecute(Sender: TObject);
var
  newForm : TfrmDrugHPWarehouse;
begin
  {set cursor(wait)}
  Screen.Cursor:= crHourGlass;
  {clear old forms}
  closePriorForm;
  try
    newForm:= TfrmDrugHPWarehouse.Create(nil);
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

procedure TfrmOrg.actAppliancesWarehouseExecute(Sender: TObject);
var
  newForm : TfrmAppliancesWarehouse;
begin
  {set cursor(wait)}
  Screen.Cursor:= crHourGlass;
  {clear old forms}
  closePriorForm;
  try
    newForm:= TfrmAppliancesWarehouse.Create(nil);
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

procedure TfrmOrg.actDbBackupExecute(Sender: TObject);
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

procedure TfrmOrg.actAppliancesHPWarehouseExecute(Sender: TObject);
var
  newForm : TfrmAppliancesHPWarehouse;
begin
  {set cursor(wait)}
  Screen.Cursor:= crHourGlass;
  {clear old forms}
  closePriorForm;
  try
    newForm:= TfrmAppliancesHPWarehouse.Create(nil);
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

procedure TfrmOrg.actDrugWarehouseExecute(Sender: TObject);
var
  newForm : TfrmDrugWarehouse;
begin
  {set cursor(wait)}
  Screen.Cursor:= crHourGlass;
  {clear old forms}
  closePriorForm;
  try
    newForm:= TfrmDrugWarehouse.Create(nil);
    {set parent ctrl}
    newForm.Parent:= panelForms;
    {set position}
    newForm.Left:= 0;
    newForm.Top:= 0;
    {open dataSets}
    newForm.openDataSet;
    {set help-path}
    newForm.HELP_PATH:= HELP_PATH;
    {show form}
    newForm.Show;
    {set focus to enable shortcuts}
    newForm.SetFocus;
  finally
    Screen.Cursor:= crDefault;
  end;
end;

procedure TfrmOrg.actFoodHPWarehouseExecute(Sender: TObject);
var
  newForm : TfrmFoodHPWarehouse;
begin
  {set cursor(wait)}
  Screen.Cursor:= crHourGlass;
  {clear old forms}
  closePriorForm;
  try
    newForm:= TfrmFoodHPWarehouse.Create(nil);
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

procedure TfrmOrg.actFoodWarehouseExecute(Sender: TObject);
var
  newForm : TfrmFoodWarehouse;
begin
  {set cursor(wait)}
  Screen.Cursor:= crHourGlass;
  {clear old forms}
  closePriorForm;
  try
    newForm:= TfrmFoodWarehouse.Create(nil);
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

procedure TfrmOrg.actHEquipmentHPWarehouseExecute(Sender: TObject);
var
  newForm : TfrmHEquipmentHPWarehouse;
begin
  {set cursor(wait)}
  Screen.Cursor:= crHourGlass;
  {clear old forms}
  closePriorForm;
  try
    newForm:= TfrmHEquipmentHPWarehouse.Create(nil);
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

procedure TfrmOrg.actHEquipmentWarehouseExecute(Sender: TObject);
var
  newForm : TfrmHEquipmentWarehouse;
begin
  {set cursor(wait)}
  Screen.Cursor:= crHourGlass;
  {clear old forms}
  closePriorForm;
  try
    newForm:= TfrmHEquipmentWarehouse.Create(nil);
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

procedure TfrmOrg.actHlpAboutFormsDocExecute(Sender: TObject);
var
  full_path : String;
begin
  {help file path(pdf file)}
  full_path:= HELP_PATH + 'forms.doc';
  {open doc}
  Screen.Cursor:= crHourGlass;
  try
    OpenDocument(full_path);
  finally
    Screen.Cursor:= crDefault;
  end;
end;

procedure TfrmOrg.actHlpAboutFormsPdfExecute(Sender: TObject);
var
  full_path : String;
begin
  {help file path(pdf file)}
  full_path:= HELP_PATH + 'forms.pdf';
  {open doc}
  Screen.Cursor:= crHourGlass;
  try
    OpenDocument(full_path);
  finally
    Screen.Cursor:= crDefault;
  end;
end;

procedure TfrmOrg.actHlpEditDataDocExecute(Sender: TObject);
var
  full_path : String;
begin
  {help file path(pdf file)}
  full_path:= HELP_PATH + 'editData.doc';
  {open doc}
  Screen.Cursor:= crHourGlass;
  try
    OpenDocument(full_path);
  finally
    Screen.Cursor:= crDefault;
  end;
end;

procedure TfrmOrg.actHlpEditDataPdfExecute(Sender: TObject);
var
  full_path : String;
begin
  {help file path(pdf file)}
  full_path:= HELP_PATH + 'editData.pdf';
  {open doc}
  Screen.Cursor:= crHourGlass;
  try
    OpenDocument(full_path);
  finally
    Screen.Cursor:= crDefault;
  end;
end;

procedure TfrmOrg.divExDatisMouseEnter(Sender: TObject);
begin
  {underline}
  divExDatis.Font.Underline:= True;
end;

procedure TfrmOrg.divExDatisMouseLeave(Sender: TObject);
begin
  {reset underline}
  divExDatis.Font.Underline:= False;
end;

procedure TfrmOrg.lblModuleTitleClick(Sender: TObject);
begin
  {open project home-page}
  Screen.Cursor:= crHourGlass;
  try
    OpenURL(PRJ_HOME);
  finally
    Screen.Cursor:= crDefault;
  end;
end;

procedure TfrmOrg.lblModuleTitleMouseEnter(Sender: TObject);
begin
  {underline}
  lblModuleTitle.Font.Underline:= True;
end;

procedure TfrmOrg.lblModuleTitleMouseLeave(Sender: TObject);
begin
  {reset - underline = False}
  lblModuleTitle.Font.Underline:= False;
end;

procedure TfrmOrg.closePriorForm;
begin
  if(panelForms.ControlCount > MAX_CTRLS) then
    TForm(panelForms.Controls[MAX_CTRLS]).Close;
end;

procedure TfrmOrg.backupDb(const fbkPath: String);
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

function TfrmOrg.checkUser(const ini_file: String): Boolean;
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

end.

