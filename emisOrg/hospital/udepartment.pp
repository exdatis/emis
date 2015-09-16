unit uDepartment;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,
  ActnList, DbCtrls, Buttons, DBGrids, ExtCtrls, Menus, uBaseDbForm, db,
  ZDataset, ZSequence, ZSqlUpdate, ZAbstractDataset, ZAbstractRODataset, LCLIntf;

type

  { TfrmDepartment }

  TfrmDepartment = class(TbaseDbForm)
    actFind: TActionList;
    actFindLocationByCode: TAction;
    actFindLocationByName: TAction;
    actFindLocationHelpPdf: TAction;
    actFindLocationHelpDoc: TAction;
    btnFindLocation: TSpeedButton;
    btnLocationCancel: TButton;
    btnLocationOk: TButton;
    dbFax: TDBEdit;
    dbgDepartment: TDBGrid;
    dbgLocation: TDBGrid;
    dbPhone: TDBEdit;
    dblHospital: TDBLookupComboBox;
    dsFindLocation: TDataSource;
    dsHospital: TDataSource;
    dbCode: TDBEdit;
    dbAddress: TDBEdit;
    dbMail: TDBEdit;
    dbLocation: TDBEdit;
    dbName: TDBEdit;
    dsDepartment: TDataSource;
    groupBoxEdit: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    MenuItem1: TMenuItem;
    MenuItem2: TMenuItem;
    MenuItem3: TMenuItem;
    MenuItem4: TMenuItem;
    MenuItem5: TMenuItem;
    panelFindLocation: TPanel;
    pupFindLocation: TPopupMenu;
    zqDepartment: TZQuery;
    zqDepartmentD_ADDRESS: TStringField;
    zqDepartmentD_CODE: TStringField;
    zqDepartmentD_FAX: TStringField;
    zqDepartmentD_HOSPITAL: TLongintField;
    zqDepartmentD_ID: TLongintField;
    zqDepartmentD_LOCATION: TLongintField;
    zqDepartmentD_MAIL: TStringField;
    zqDepartmentD_NAME: TStringField;
    zqDepartmentD_PHONE: TStringField;
    zqDepartmentHOSPITAL_CODE: TStringField;
    zqDepartmentHOSPITAL_NAME: TStringField;
    zqDepartmentLOCATION_NAME: TStringField;
    zqDepartmentREG_NUMBER: TStringField;
    zqDepartmentTAX_NUMBER: TStringField;
    zqDepartmentZIP_NAME: TStringField;
    zroFindLocation: TZReadOnlyQuery;
    zroFindLocationL_CODE: TStringField;
    zroFindLocationL_ID: TLongintField;
    zroFindLocationL_NAME: TStringField;
    zroHospital: TZReadOnlyQuery;
    zroHospitalH_ID: TLongintField;
    zroHospitalH_NAME: TStringField;
    zsecDepartment: TZSequence;
    zupdDepartment: TZUpdateSQL;
    procedure actFindLocationByCodeExecute(Sender: TObject);
    procedure actFindLocationByNameExecute(Sender: TObject);
    procedure actFindLocationHelpDocExecute(Sender: TObject);
    procedure actFindLocationHelpPdfExecute(Sender: TObject);
    procedure btnFindLocationClick(Sender: TObject);
    procedure btnLocationCancelClick(Sender: TObject);
    procedure btnLocationOkClick(Sender: TObject);
    procedure dbgDepartmentMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure dbgDepartmentTitleClick(Column: TColumn);
    procedure dbgLocationKeyPress(Sender: TObject; var Key: char);
    procedure dbgLocationMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure dbgLocationTitleClick(Column: TColumn);
    procedure dbLocationKeyPress(Sender: TObject; var Key: char);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure zqDepartmentAfterDelete(DataSet: TDataSet);
    procedure zqDepartmentAfterOpen(DataSet: TDataSet);
    procedure zqDepartmentAfterPost(DataSet: TDataSet);
    procedure zqDepartmentAfterScroll(DataSet: TDataSet);
  private
    { private declarations }
    locationArg : String;
    procedure saveBeforeClose;
    procedure findLocation(textArg : String);
    procedure useThisLocation;
  public
    { public declarations }
    HELP_PATH : String;
    procedure onActFirst; override;
    procedure onActPrior; override;
    procedure onActNext; override;
    procedure onActLast; override;
    procedure onActInsert; override;
    procedure onActDelete; override;
    procedure onActEdit; override;
    procedure onActSave; override;
    procedure onActCancel; override;
    // open data-set
    procedure openDataSet;
  end;

var
  frmDepartment: TfrmDepartment;
const
  EMPTY_SET : String = 'Prazan skup podataka.';
  {fields of tbl department(FD -> fields department) and view(department_v)}
  FD_ID : String = 'D_ID';
  FD_CODE : String = 'D_CODE';
  FD_NAME : String = 'H_NAME';
  FD_LOCATION : String = 'D_LOCATION';
  FD_ADDRESS : String = 'D_ADDRESS';
  FD_PHONE : String = 'D_PHONE';
  FD_FAX : String = 'D_FAX';
  FD_MAIL : String = 'D_MAIL';
  //VIEW  DEPARTMENT_V
  FD_ZIP_CODE : String = 'ZIP_CODE';
  FD_LOCATION_NAME :String = 'LOCATION_NAME';
  FD_HOSPITAL_CODE : String = 'HOSPITAL_CODE';
  FD_HOSPITAL_NAME : String = 'HOSPITAL_NAME';
  FD_TAX_NUMBER : String = 'TAX_NUMBER';
  FD_REG_NUMBER : String = 'REG_NUMBER';
implementation
uses
  uDModule, uConfirm;
{$R *.lfm}

{ TfrmDepartment }

procedure TfrmDepartment.FormCreate(Sender: TObject);
begin
  {default arg - location(NAME)}
  locationArg:= FD_LOCATION_NAME;
end;

procedure TfrmDepartment.dbgDepartmentMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
  dbgDepartment.Cursor:= crHandPoint;
end;

procedure TfrmDepartment.actFindLocationByCodeExecute(Sender: TObject);
begin
  locationArg:= FD_ZIP_CODE; //set search arg
  findLocation(dbLocation.Text); //set text arg
end;

procedure TfrmDepartment.actFindLocationByNameExecute(Sender: TObject);
begin
  locationArg:= FD_LOCATION_NAME; //set search arg
  findLocation(dbLocation.Text); //set text arg
end;

procedure TfrmDepartment.actFindLocationHelpDocExecute(Sender: TObject);
var
  full_path : String;
begin
  {help file path(pdf file)}
  full_path:= HELP_PATH + 'FindLocation.doc';
  {open doc}
  Screen.Cursor:= crHourGlass;
  try
    OpenDocument(full_path);
  finally
    Screen.Cursor:= crDefault;
  end;
end;

procedure TfrmDepartment.actFindLocationHelpPdfExecute(Sender: TObject);
var
  full_path : String;
begin
  {help file path(pdf file)}
  full_path:= HELP_PATH + 'FindLocation.pdf';
  {open doc}
  Screen.Cursor:= crHourGlass;
  try
    OpenDocument(full_path);
  finally
    Screen.Cursor:= crDefault;
  end;
end;

procedure TfrmDepartment.btnFindLocationClick(Sender: TObject);
begin
  {show popUpMnu}
  pupFindLocation.PopUp(Mouse.CursorPos.x, Mouse.CursorPos.y);
end;

procedure TfrmDepartment.btnLocationCancelClick(Sender: TObject);
begin
  {hide panel and set focus}
  panelFindLocation.Visible:= False;
  //set ficus
  dbLocation.SetFocus;
  dbLocation.SelectAll;
  Application.ProcessMessages;
end;

procedure TfrmDepartment.btnLocationOkClick(Sender: TObject);
begin
  {use current location}
  useThisLocation;
end;

procedure TfrmDepartment.dbgDepartmentTitleClick(Column: TColumn);
var
  recCount, recNo : String;
  recMsg : String = '0 od 0'; {find again recNo}
begin
  {sort}
  doSortDbGrid(TZAbstractDataset(zqDepartment), Column);
  {refresh after sort}
  dbgDepartment.Refresh;
  { find recNo}
  recCount:= IntToStr(TZAbstractDataset(zqDepartment).RecordCount);
  recNo:= IntToStr(TZAbstractDataset(zqDepartment).RecNo);
  {create recMsg}
  recMsg:= recNo + ' od ' + recCount;
  edtRecNo.Text:= recMsg;
end;

procedure TfrmDepartment.dbgLocationKeyPress(Sender: TObject; var Key: char);
begin
  {space}
  if(Key = #32) then
    btnLocationOk.Click;
end;

procedure TfrmDepartment.dbgLocationMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
  dbgLocation.Cursor:= crHandPoint;
end;

procedure TfrmDepartment.dbgLocationTitleClick(Column: TColumn);
begin
  doSortDbGrid(TZAbstractDataset(TZAbstractRODataset(zroFindLocation)), Column);
end;

procedure TfrmDepartment.dbLocationKeyPress(Sender: TObject; var Key: char);
begin
  {on pres Return}
  if(Key = #13) then
    begin
      locationArg:= FD_LOCATION_NAME;
      findLocation(dbLocation.Text);
    end;
end;

procedure TfrmDepartment.FormClose(Sender: TObject;
  var CloseAction: TCloseAction);
begin
  saveBeforeClose;
  inherited;
end;

procedure TfrmDepartment.zqDepartmentAfterDelete(DataSet: TDataSet);
var
  recCount, recNo : String;
  recMsg : String = '0 od 0';
begin
  {upply updates}
  TZAbstractDataset(DataSet).ApplyUpdates;
  {show recNo and countRec}
  if(TZAbstractDataset(DataSet).IsEmpty) then
    begin
      edtRecNo.Text:= recMsg;
      Exit;
    end;
  {find vars}
  recCount:= IntToStr(TZAbstractDataset(DataSet).RecordCount);
  recNo:= IntToStr(TZAbstractDataset(DataSet).RecNo);
  {create recMsg}
  recMsg:= recNo + ' od ' + recCount;
  edtRecNo.Text:= recMsg;
end;

procedure TfrmDepartment.zqDepartmentAfterOpen(DataSet: TDataSet);
var
  recCount, recNo : String;
  recMsg : String = '0 od 0';
begin
  {set btns cheking recCount}
  doAfterOpenDataSet(TZAbstractDataset(DataSet));
  {show recNo and countRec}
  if(TZAbstractDataset(DataSet).IsEmpty) then
    begin
      edtRecNo.Text:= recMsg;
      Exit;
    end;
  {find vars}
  recCount:= IntToStr(TZAbstractDataset(DataSet).RecordCount);
  recNo:= IntToStr(TZAbstractDataset(DataSet).RecNo);
  {create recMsg}
  recMsg:= recNo + ' od ' + recCount;
  edtRecNo.Text:= recMsg;
end;

procedure TfrmDepartment.zqDepartmentAfterPost(DataSet: TDataSet);
var
  {calc records(recNo and countRec)}
  recCount, recNo : String;
  recMsg : String = '0 od 0';
begin
  {upply updates}
  TZAbstractDataset(DataSet).ApplyUpdates;
  {rtefresh current row}
  TZAbstractDataset(DataSet).DisableControls;
  TZAbstractDataset(DataSet).Refresh;
  TZAbstractDataset(DataSet).EnableControls;
  {show recNo and countRec}
  if(TZAbstractDataset(DataSet).IsEmpty) then {*** never ***}
    begin
      edtRecNo.Text:= recMsg;
      Exit;
    end;
  {find vars}
  recCount:= IntToStr(TZAbstractDataset(DataSet).RecordCount);
  recNo:= IntToStr(TZAbstractDataset(DataSet).RecNo);
  {create recMsg}
  recMsg:= recNo + ' od ' + recCount;
  edtRecNo.Text:= recMsg;
end;

procedure TfrmDepartment.zqDepartmentAfterScroll(DataSet: TDataSet);
var
  recCount, recNo : String;
  recMsg : String = '0 od 0';
begin
  {set btns cheking recCount}
  if(TZAbstractDataset(DataSet).State in [dsEdit, dsInsert]) then
    Exit;
  {show recNo and countRec}
  if(TZAbstractDataset(DataSet).IsEmpty) then
    begin
      edtRecNo.Text:= recMsg;
      Exit;
    end;
  {find vars}
  recCount:= IntToStr(TZAbstractDataset(DataSet).RecordCount);
  recNo:= IntToStr(TZAbstractDataset(DataSet).RecNo);
  {create recMsg}
  recMsg:= recNo + ' od ' + recCount;
  edtRecNo.Text:= recMsg;
end;

procedure TfrmDepartment.saveBeforeClose;
var
  newDlg : TdlgConfirm;
  confirmMsg : String = 'Postoje izmene koje nisu sačuvane!';
  saveAll : Boolean = False;
begin
  {set confirm msg}
  confirmMsg:= confirmMsg + #13#10;
  confirmMsg:= confirmMsg + 'Želite da sačuvamo izmene?';
  if(TZAbstractDataset(zqDepartment).State in [dsEdit, dsInsert]) then
    begin
      {ask user to confirm}
      newDlg:= TdlgConfirm.Create(nil);
      newDlg.memoMsg.Lines.Text:= confirmMsg;
      if(newDlg.ShowModal = mrOK) then
        saveAll:= True;
      {free dialog}
      newDlg.Free;
    end;
  {check all}
  if saveAll then
    doSaveRec(TZAbstractDataset(zqDepartment)); {in this case just one dataSet}
end;

procedure TfrmDepartment.findLocation(textArg: String);
var
  argCode, argName : String;
begin
  {find argument}
  if(locationArg = FD_LOCATION_NAME) then
    begin
      argCode:= '%';
      argName:= '%' + textArg + '%';
    end
  else
    begin
      argCode:= '%' + textArg + '%';
      argName:= '%';
    end;
  {set params}
  zroFindLocation.DisableControls;
  zroFindLocation.Params[0].AsString:= argCode;
  zroFindLocation.Params[1].AsString:= argName;
  try
    zroFindLocation.Open;
    zroFindLocation.EnableControls;
  except
    on e : Exception do
    begin
      ShowMessage(e.Message);
      zroFindLocation.EnableControls;
      //focus(back)
      dbLocation.SetFocus;
      dbLocation.SelectAll;
      Exit;
    end;
  end;
  {again if dataSet is empty}
  if(zroFindLocation.IsEmpty) then
    begin
      ShowMessage(EMPTY_SET);
      //set focus
      dbLocation.SetFocus;
      dbLocation.SelectAll;
      Exit;
    end;
  {else show panel(results)}
  panelFindLocation.Visible:= True;
  dbgLocation.SetFocus;
  Application.ProcessMessages;
end;

procedure TfrmDepartment.useThisLocation;
begin
  TZAbstractDataset(zqDepartment).FieldByName(FD_LOCATION).AsInteger:= zroFindLocation.Fields[0].AsInteger;
  TZAbstractDataset(zqDepartment).FieldByName(FD_LOCATION_NAME).AsString:= zroFindLocation.Fields[2].AsString;
  //hide panel
  panelFindLocation.Visible:= False;
  //set focus
  dbAddress.SetFocus;
  Application.ProcessMessages;
end;

procedure TfrmDepartment.onActFirst;
begin
  {jump to first rec}
  doFirstRec(TZAbstractDataset(zqDepartment));
end;

procedure TfrmDepartment.onActPrior;
begin
  {jump to prior rec}
  doPriorRec(TZAbstractDataset(zqDepartment));
end;

procedure TfrmDepartment.onActNext;
begin
  {jump to next rec}
  doNextRec(TZAbstractDataset(zqDepartment));
end;

procedure TfrmDepartment.onActLast;
begin
  {jump to last rec}
  doLastRec(TZAbstractDataset(zqDepartment));
end;

procedure TfrmDepartment.onActInsert;
begin
  {set focus and insert new rec}
  dbCode.SetFocus;
  doInsertRec(TZAbstractDataset(zqDepartment));
end;

procedure TfrmDepartment.onActDelete;
begin
  {delete rec}
  doDeleteRec(TZAbstractDataset(zqDepartment));
end;

procedure TfrmDepartment.onActEdit;
begin
  {set focus and edit rec}
  dbCode.SetFocus;
  doEditRec(TZAbstractDataset(zqDepartment));
end;

procedure TfrmDepartment.onActSave;
begin
  {save rec}
  doSaveRec(TZAbstractDataset(zqDepartment));
end;

procedure TfrmDepartment.onActCancel;
begin
  {cancel rec}
  doCancelRec(TZAbstractDataset(zqDepartment));
end;

procedure TfrmDepartment.openDataSet;
begin
  {hospital(read only)}
  TZAbstractDataset(TZAbstractRODataset(zroHospital)).DisableControls;
  TZAbstractDataset(TZAbstractRODataset(zroHospital)).Close;
  {department}
  TZAbstractDataset(zqDepartment).DisableControls;
  TZAbstractDataset(zqDepartment).Close;
  try
    TZAbstractDataset(TZAbstractRODataset(zroHospital)).Open;
    TZAbstractDataset(TZAbstractRODataset(zroHospital)).EnableControls;
    TZAbstractDataset(zqDepartment).Open;
    TZAbstractDataset(zqDepartment).EnableControls;
  except
    on e : Exception do
    begin
      dModule.zdbh.Rollback;
      TZAbstractDataset(TZAbstractRODataset(zroHospital)).EnableControls;
      TZAbstractDataset(zqDepartment).EnableControls;
      ShowMessage(e.Message);
    end;
  end;
end;

end.

