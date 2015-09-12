unit uorg;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, BCPanel, DividerBevel, Forms, Controls, Graphics,
  Dialogs, ExtCtrls, StdCtrls, Menus, ActnList, LCLIntf, ComCtrls;

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
    actMaterialsHPWarehouse: TAction;
    actMaterialsWarehouse: TAction;
    actOfficeWarehouse: TAction;
    actQuitApp: TAction;
    divExDatis: TDividerBevel;
    Image1: TImage;
    imgGeneral: TImageList;
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
    MenuItem4: TMenuItem;
    MenuItem5: TMenuItem;
    MenuItem6: TMenuItem;
    MenuItem7: TMenuItem;
    MenuItem8: TMenuItem;
    MenuItem9: TMenuItem;
    mnuGeneral: TMainMenu;
    panelForms: TBCPanel;
    panelMnu: TPanel;
    shapeLogo: TShape;
    statusBarGeneral: TStatusBar;
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
    procedure actDepartmentFrmExecute(Sender: TObject);
    procedure actDrugHPWarehouseExecute(Sender: TObject);
    procedure actDrugWarehouseExecute(Sender: TObject);
    procedure actFoodHPWarehouseExecute(Sender: TObject);
    procedure actFoodWarehouseExecute(Sender: TObject);
    procedure actHEquipmentHPWarehouseExecute(Sender: TObject);
    procedure actHEquipmentWarehouseExecute(Sender: TObject);
    procedure actHospitalFrmExecute(Sender: TObject);
    procedure actHygieneHPWarehouseExecute(Sender: TObject);
    procedure actHygieneWarehouseExecute(Sender: TObject);
    procedure actMaterialsHPWarehouseExecute(Sender: TObject);
    procedure actMaterialsWarehouseExecute(Sender: TObject);
    procedure actOfficeWarehouseExecute(Sender: TObject);
    procedure actQuitAppExecute(Sender: TObject);
    procedure divExDatisClick(Sender: TObject);
    procedure divExDatisMouseEnter(Sender: TObject);
    procedure divExDatisMouseLeave(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure lblModuleTitleClick(Sender: TObject);
    procedure lblModuleTitleMouseEnter(Sender: TObject);
    procedure lblModuleTitleMouseLeave(Sender: TObject);
  private
    { private declarations }
    procedure closePriorForm;
  public
    { public declarations }
  end;

var
  frmOrg: TfrmOrg;
const
  PRJ_HOME : String = 'http://sourceforge.net/projects/emissoftware/';
  MAX_CTRLS : ShortInt = 4;
implementation
uses
  uhospital, uDModule, uDepartment, uDrugWarehouse, uAppliancesWarehouse,
  uFoodWarehouse, uOfficeWarehouse, uMaterialsWarehouse, uHygieneWarehouse,
  uHEquipmentWarehouse, uAppliancesHPWarehouse, uDrugHPWarehouse,
  uFoodHPWarehouse, uHEquipmentHPWarehouse, uHygieneHPWarehouse,
  uMaterialsHPWarehouse;
{$R *.lfm}

{ TfrmOrg }

procedure TfrmOrg.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  { free and nil }
  CloseAction:= caFree;
  self:= nil;
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

end.

