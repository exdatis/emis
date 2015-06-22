unit uGeneral;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, BCPanel, DividerBevel, Forms, Controls, Graphics,
  Dialogs, ActnList, Menus, ComCtrls, ExtCtrls, LCLIntf, StdCtrls;

type

  { TfrmGeneral }

  TfrmGeneral = class(TForm)
    actGeneral: TActionList;
    actDocWIn: TAction;
    actDocWOut: TAction;
    actDocSOInput: TAction;
    actDocSOOutput: TAction;
    actDocBuying: TAction;
    actDocSell: TAction;
    actDocContract: TAction;
    actDrugForms: TAction;
    actDocMedicalInput: TAction;
    actDocMedicalOutput: TAction;
    actDocMedicalOrders: TAction;
    actDocLab: TAction;
    actDocPayment: TAction;
    actDocOutgoings: TAction;
    actDocFinance: TAction;
    actDocRequisition: TAction;
    actDocReservation: TAction;
    actMeasure: TAction;
    actLocationFrm: TAction;
    actQuitApp: TAction;
    divExDatis: TDividerBevel;
    Image1: TImage;
    lblModuleTitle: TLabel;
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
    MenuItem30: TMenuItem;
    MenuItem31: TMenuItem;
    MenuItem32: TMenuItem;
    MenuItem33: TMenuItem;
    MenuItem34: TMenuItem;
    MenuItem35: TMenuItem;
    MenuItem4: TMenuItem;
    MenuItem5: TMenuItem;
    MenuItem6: TMenuItem;
    MenuItem7: TMenuItem;
    MenuItem8: TMenuItem;
    MenuItem9: TMenuItem;
    panelForms: TBCPanel;
    imgGeneral: TImageList;
    MenuItem1: TMenuItem;
    MenuItem2: TMenuItem;
    MenuItem3: TMenuItem;
    mnuGeneral: TMainMenu;
    panelMnu: TPanel;
    shapeLogo: TShape;
    statusBarGeneral: TStatusBar;
    toolBarGeneral: TToolBar;
    ToolButton1: TToolButton;
    ToolButton10: TToolButton;
    ToolButton11: TToolButton;
    ToolButton12: TToolButton;
    ToolButton13: TToolButton;
    ToolButton14: TToolButton;
    ToolButton15: TToolButton;
    ToolButton16: TToolButton;
    ToolButton17: TToolButton;
    ToolButton18: TToolButton;
    ToolButton19: TToolButton;
    ToolButton2: TToolButton;
    ToolButton20: TToolButton;
    ToolButton21: TToolButton;
    ToolButton22: TToolButton;
    ToolButton23: TToolButton;
    ToolButton24: TToolButton;
    ToolButton25: TToolButton;
    ToolButton26: TToolButton;
    ToolButton27: TToolButton;
    ToolButton28: TToolButton;
    ToolButton29: TToolButton;
    ToolButton3: TToolButton;
    ToolButton30: TToolButton;
    ToolButton31: TToolButton;
    ToolButton4: TToolButton;
    ToolButton5: TToolButton;
    ToolButton6: TToolButton;
    ToolButton7: TToolButton;
    ToolButton8: TToolButton;
    ToolButton9: TToolButton;
    procedure actDocBuyingExecute(Sender: TObject);
    procedure actDocContractExecute(Sender: TObject);
    procedure actDocFinanceExecute(Sender: TObject);
    procedure actDocLabExecute(Sender: TObject);
    procedure actDocMedicalInputExecute(Sender: TObject);
    procedure actDocMedicalOrdersExecute(Sender: TObject);
    procedure actDocMedicalOutputExecute(Sender: TObject);
    procedure actDocOutgoingsExecute(Sender: TObject);
    procedure actDocPaymentExecute(Sender: TObject);
    procedure actDocRequisitionExecute(Sender: TObject);
    procedure actDocReservationExecute(Sender: TObject);
    procedure actDocSellExecute(Sender: TObject);
    procedure actDocSOInputExecute(Sender: TObject);
    procedure actDocSOOutputExecute(Sender: TObject);
    procedure actDocWInExecute(Sender: TObject);
    procedure actDocWOutExecute(Sender: TObject);
    procedure actDrugFormsExecute(Sender: TObject);
    procedure actLocationFrmExecute(Sender: TObject);
    procedure actMeasureExecute(Sender: TObject);
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
  frmGeneral: TfrmGeneral;
const
  PRJ_HOME : String = 'http://sourceforge.net/projects/emissoftware/';
  MAX_CTRLS : ShortInt = 4;

implementation
uses
  uLocation, uDocWarehouseIn, uDocWarehouseOut, uDocSOInput, uDocSOOutput,
  uDocBuying, uDocSell, uDocContract, uMeasure, uDrugForms, uDocMedicalInput,
  uDocMedicalOutput, uDocMedicalOrders, uDocLab, uDocPayment, uDocOutgoings,
  uDocFinance, uDocRequisition, uDocReservation;
{$R *.lfm}

{ TfrmGeneral }

procedure TfrmGeneral.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  { free and nil }
  CloseAction:= caFree;
  self:= nil;
end;

procedure TfrmGeneral.lblModuleTitleClick(Sender: TObject);
begin
  {open project home-page}
  Screen.Cursor:= crHourGlass;
  try
    OpenURL(PRJ_HOME);
  finally
    Screen.Cursor:= crDefault;
  end;
end;

procedure TfrmGeneral.lblModuleTitleMouseEnter(Sender: TObject);
begin
  {underline}
  lblModuleTitle.Font.Underline:= True;
end;

procedure TfrmGeneral.lblModuleTitleMouseLeave(Sender: TObject);
begin
  {reset - underline = False}
  lblModuleTitle.Font.Underline:= False;
end;

procedure TfrmGeneral.closePriorForm;
begin
  if(panelForms.ControlCount > MAX_CTRLS) then
    TForm(panelForms.Controls[MAX_CTRLS]).Close;
end;

procedure TfrmGeneral.actQuitAppExecute(Sender: TObject);
begin
  {close main form and terminate app}
  self.Close;
  Application.Terminate;
end;

procedure TfrmGeneral.actLocationFrmExecute(Sender: TObject);
var
  newForm : TfrmLocation;
begin
  {set cursor(wait)}
  Screen.Cursor:= crHourGlass;
  {clear old forms}
  closePriorForm;
  try
    newForm:= TfrmLocation.Create(nil);
    {set parent ctrl}
    newForm.Parent:= panelForms;
    {set position}
    newForm.Left:= 0;
    newForm.Top:= 0;
    {open dataSets}
    newForm.applyCharFilter; {with default char}
    {show form}
    newForm.Show;
    {set focus to enable shortcuts}
    newForm.SetFocus;
  finally
    Screen.Cursor:= crDefault;
  end;
end;

procedure TfrmGeneral.actMeasureExecute(Sender: TObject);
var
  newForm : TfrmMeasure;
begin
  {set cursor(wait)}
  Screen.Cursor:= crHourGlass;
  {clear old forms}
  closePriorForm;
  try
    newForm:= TfrmMeasure.Create(nil);
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

procedure TfrmGeneral.actDocWInExecute(Sender: TObject);
var
  newForm : TfrmDocWarehouseIn;
begin
  {set cursor(wait)}
  Screen.Cursor:= crHourGlass;
  {clear old forms}
  closePriorForm;
  try
    newForm:= TfrmDocWarehouseIn.Create(nil);
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

procedure TfrmGeneral.actDocSOInputExecute(Sender: TObject);
var
  newForm : TfrmDocSOInput;
begin
  {set cursor(wait)}
  Screen.Cursor:= crHourGlass;
  {clear old forms}
  closePriorForm;
  try
    newForm:= TfrmDocSOInput.Create(nil);
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

procedure TfrmGeneral.actDocBuyingExecute(Sender: TObject);
var
  newForm : TfrmDocBuying;
begin
  {set cursor(wait)}
  Screen.Cursor:= crHourGlass;
  {clear old forms}
  closePriorForm;
  try
    newForm:= TfrmDocBuying.Create(nil);
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

procedure TfrmGeneral.actDocContractExecute(Sender: TObject);
var
  newForm : TfrmDocContract;
begin
  {set cursor(wait)}
  Screen.Cursor:= crHourGlass;
  {clear old forms}
  closePriorForm;
  try
    newForm:= TfrmDocContract.Create(nil);
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

procedure TfrmGeneral.actDocFinanceExecute(Sender: TObject);
var
  newForm : TfrmDocFinance;
begin
  {set cursor(wait)}
  Screen.Cursor:= crHourGlass;
  {clear old forms}
  closePriorForm;
  try
    newForm:= TfrmDocFinance.Create(nil);
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

procedure TfrmGeneral.actDocLabExecute(Sender: TObject);
var
  newForm : TfrmDocLab;
begin
  {set cursor(wait)}
  Screen.Cursor:= crHourGlass;
  {clear old forms}
  closePriorForm;
  try
    newForm:= TfrmDocLab.Create(nil);
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

procedure TfrmGeneral.actDocMedicalInputExecute(Sender: TObject);
var
  newForm : TfrmDocMedicalInput;
begin
  {set cursor(wait)}
  Screen.Cursor:= crHourGlass;
  {clear old forms}
  closePriorForm;
  try
    newForm:= TfrmDocMedicalInput.Create(nil);
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

procedure TfrmGeneral.actDocMedicalOrdersExecute(Sender: TObject);
var
  newForm : TfrmDocMedicalOrders;
begin
  {set cursor(wait)}
  Screen.Cursor:= crHourGlass;
  {clear old forms}
  closePriorForm;
  try
    newForm:= TfrmDocMedicalOrders.Create(nil);
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

procedure TfrmGeneral.actDocMedicalOutputExecute(Sender: TObject);
var
  newForm : TfrmDocMedicalOutput;
begin
  {set cursor(wait)}
  Screen.Cursor:= crHourGlass;
  {clear old forms}
  closePriorForm;
  try
    newForm:= TfrmDocMedicalOutput.Create(nil);
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

procedure TfrmGeneral.actDocOutgoingsExecute(Sender: TObject);
var
  newForm : TfrmDocOutgoings;
begin
  {set cursor(wait)}
  Screen.Cursor:= crHourGlass;
  {clear old forms}
  closePriorForm;
  try
    newForm:= TfrmDocOutgoings.Create(nil);
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

procedure TfrmGeneral.actDocPaymentExecute(Sender: TObject);
var
  newForm : TfrmDocPayment;
begin
  {set cursor(wait)}
  Screen.Cursor:= crHourGlass;
  {clear old forms}
  closePriorForm;
  try
    newForm:= TfrmDocPayment.Create(nil);
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

procedure TfrmGeneral.actDocRequisitionExecute(Sender: TObject);
var
  newForm : TfrmDocRequisition;
begin
  {set cursor(wait)}
  Screen.Cursor:= crHourGlass;
  {clear old forms}
  closePriorForm;
  try
    newForm:= TfrmDocRequisition.Create(nil);
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

procedure TfrmGeneral.actDocReservationExecute(Sender: TObject);
var
  newForm : TfrmDocReservation;
begin
  {set cursor(wait)}
  Screen.Cursor:= crHourGlass;
  {clear old forms}
  closePriorForm;
  try
    newForm:= TfrmDocReservation.Create(nil);
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

procedure TfrmGeneral.actDocSellExecute(Sender: TObject);
var
  newForm : TfrmDocSell;
begin
  {set cursor(wait)}
  Screen.Cursor:= crHourGlass;
  {clear old forms}
  closePriorForm;
  try
    newForm:= TfrmDocSell.Create(nil);
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

procedure TfrmGeneral.actDocSOOutputExecute(Sender: TObject);
var
  newForm : TfrmDocSOOutput;
begin
  {set cursor(wait)}
  Screen.Cursor:= crHourGlass;
  {clear old forms}
  closePriorForm;
  try
    newForm:= TfrmDocSOOutput.Create(nil);
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

procedure TfrmGeneral.actDocWOutExecute(Sender: TObject);
var
  newForm : TfrmDocWarehouseOut;
begin
  {set cursor(wait)}
  Screen.Cursor:= crHourGlass;
  {clear old forms}
  closePriorForm;
  try
    newForm:= TfrmDocWarehouseOut.Create(nil);
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

procedure TfrmGeneral.actDrugFormsExecute(Sender: TObject);
var
  newForm : TfrmDrugForms;
begin
  {set cursor(wait)}
  Screen.Cursor:= crHourGlass;
  {clear old forms}
  closePriorForm;
  try
    newForm:= TfrmDrugForms.Create(nil);
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

procedure TfrmGeneral.divExDatisClick(Sender: TObject);
begin
  {open project home-page}
  Screen.Cursor:= crHourGlass;
  try
    OpenURL(PRJ_HOME);
  finally
    Screen.Cursor:= crDefault;
  end;
end;

procedure TfrmGeneral.divExDatisMouseEnter(Sender: TObject);
begin
  {underline}
  divExDatis.Font.Underline:= True;
end;

procedure TfrmGeneral.divExDatisMouseLeave(Sender: TObject);
begin
  {underline}
  divExDatis.Font.Underline:= False;
end;

end.

