unit uMaterialsHPWarehouse;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, ZDataset, ZSequence, ZSqlUpdate, Forms, Controls,
  Graphics, Dialogs, StdCtrls, ActnList, Menus, DbCtrls, Buttons, DBGrids,
  ExtCtrls, uBaseDbForm, db, ZAbstractDataset, ZAbstractRODataset, LCLType;

type

  { TfrmMaterialsHPWarehouse }

  TfrmMaterialsHPWarehouse = class(TbaseDbForm)
    actFind: TActionList;
    actFindLocationByCode: TAction;
    actFindLocationByName: TAction;
    actFindLocationHelp: TAction;
    btnFindLocation: TSpeedButton;
    btnLocationCancel: TButton;
    btnLocationOk: TButton;
    dbAddress: TDBEdit;
    dbCode: TDBEdit;
    dbFax: TDBEdit;
    dbgLocation: TDBGrid;
    dbgWarehouse: TDBGrid;
    dblDepartment: TDBLookupComboBox;
    dbLocation: TDBEdit;
    dbMail: TDBEdit;
    dbName: TDBEdit;
    dbPhone: TDBEdit;
    dsDepartment: TDataSource;
    dsFindLocation: TDataSource;
    dsWarehouse: TDataSource;
    edtGridSearch: TEdit;
    edtLocate: TEdit;
    groupBoxEdit: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    MenuItem1: TMenuItem;
    MenuItem2: TMenuItem;
    MenuItem3: TMenuItem;
    MenuItem4: TMenuItem;
    panelFindLocation: TPanel;
    panelSearch: TPanel;
    pupFindLocation: TPopupMenu;
    zqWarehouse: TZQuery;
    zqWarehouseDEPARTMENT_CODE: TStringField;
    zqWarehouseDEPARTMENT_NAME: TStringField;
    zqWarehouseLOCATION_NAME: TStringField;
    zqWarehouseMHPW_ADDRESS: TStringField;
    zqWarehouseMHPW_CODE: TStringField;
    zqWarehouseMHPW_DEPARTMENT: TLongintField;
    zqWarehouseMHPW_FAX: TStringField;
    zqWarehouseMHPW_ID: TLongintField;
    zqWarehouseMHPW_LOCATION: TLongintField;
    zqWarehouseMHPW_MAIL: TStringField;
    zqWarehouseMHPW_NAME: TStringField;
    zqWarehouseMHPW_PHONE: TStringField;
    zqWarehouseZIP_CODE: TStringField;
    zroDepartment: TZReadOnlyQuery;
    zroDepartmentD_ID: TLongintField;
    zroDepartmentD_NAME: TStringField;
    zroFindLocation: TZReadOnlyQuery;
    zroFindLocationL_CODE: TStringField;
    zroFindLocationL_ID: TLongintField;
    zroFindLocationL_NAME: TStringField;
    zseqWarehouse: TZSequence;
    zupdWarehouse: TZUpdateSQL;
    procedure actFindLocationByCodeExecute(Sender: TObject);
    procedure actFindLocationByNameExecute(Sender: TObject);
    procedure btnFindLocationClick(Sender: TObject);
    procedure btnLocationCancelClick(Sender: TObject);
    procedure btnLocationOkClick(Sender: TObject);
    procedure dbgLocationKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure dbgLocationMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure dbgLocationTitleClick(Column: TColumn);
    procedure dbgWarehouseMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure dbgWarehouseTitleClick(Column: TColumn);
    procedure dbLocationKeyPress(Sender: TObject; var Key: char);
    procedure edtGridSearchKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edtGridSearchKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edtLocateEnter(Sender: TObject);
    procedure edtLocateExit(Sender: TObject);
    procedure edtLocateKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState
      );
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure zqWarehouseAfterDelete(DataSet: TDataSet);
    procedure zqWarehouseAfterOpen(DataSet: TDataSet);
    procedure zqWarehouseAfterPost(DataSet: TDataSet);
    procedure zqWarehouseAfterScroll(DataSet: TDataSet);
  private
    { private declarations }
    locationArg : String;
    procedure saveBeforeClose;
    procedure findLocation(textArg : String);
    procedure useThisLocation;
  public
    { public declarations }
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
  frmMaterialsHPWarehouse: TfrmMaterialsHPWarehouse;
const
  EMPTY_SET : String = 'Prazan skup podataka.';
  {fields of tbl MaterialsHPWarehouse(FW -> fields Warehouse) and view(materials_hpwarehouse_v)}
  FW_ID : String = 'MHPW_ID';
  FW_CODE : String = 'MHPW_CODE';
  FW_NAME : String = 'MHPW_NAME';
  FW_LOCATION : String = 'MHPW_LOCATION';
  FW_ADDRESS : String = 'MHPW_ADDRESS';
  FW_PHONE : String = 'MHPW_PHONE';
  FW_FAX : String = 'MHPW_FAX';
  FW_MAIL : String = 'MHPW_MAIL';
  //VIEW  MATERIALS_HPWAREHOUSE_V
  FW_ZIP_CODE : String = 'ZIP_CODE';
  FW_LOCATION_NAME :String = 'LOCATION_NAME';
  FW_DEPARTMENT_CODE : String = 'DEPARTMENT_CODE';
  FW_DEPARTMENT_NAME : String = 'DEPARTMENT_NAME';
implementation
uses
  uDModule, uConfirm;
{$R *.lfm}

{ TfrmMaterialsHPWarehouse }

procedure TfrmMaterialsHPWarehouse.FormCreate(Sender: TObject);
begin
  {default arg - location(NAME)}
  locationArg:= FW_LOCATION_NAME;
end;

procedure TfrmMaterialsHPWarehouse.dbgWarehouseMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
  dbgWarehouse.Cursor:= crHandPoint;
end;

procedure TfrmMaterialsHPWarehouse.dbgLocationMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
  dbgLocation.Cursor:= crHandPoint;
end;

procedure TfrmMaterialsHPWarehouse.dbgLocationTitleClick(Column: TColumn);
begin
  doSortDbGrid(TZAbstractDataset(TZAbstractRODataset(zroFindLocation)), Column);
end;

procedure TfrmMaterialsHPWarehouse.actFindLocationByCodeExecute(Sender: TObject
  );
begin
  locationArg:= FW_ZIP_CODE; //set search arg
  findLocation(dbLocation.Text); //set text arg
end;

procedure TfrmMaterialsHPWarehouse.actFindLocationByNameExecute(Sender: TObject
  );
begin
  locationArg:= FW_LOCATION_NAME; //set search arg
  findLocation(dbLocation.Text); //set text arg
end;

procedure TfrmMaterialsHPWarehouse.btnFindLocationClick(Sender: TObject);
begin
  {show popUpMnu}
  pupFindLocation.PopUp(Mouse.CursorPos.x, Mouse.CursorPos.y);
end;

procedure TfrmMaterialsHPWarehouse.btnLocationCancelClick(Sender: TObject);
begin
  {hide panel and set focus}
  if(edtGridSearch.Visible) then
    edtGridSearch.Visible:= False;
  panelFindLocation.Visible:= False;
  //set ficus
  dbLocation.SetFocus;
  dbLocation.SelectAll;
  Application.ProcessMessages;
end;

procedure TfrmMaterialsHPWarehouse.btnLocationOkClick(Sender: TObject);
begin
  {use current location}
  useThisLocation;
end;

procedure TfrmMaterialsHPWarehouse.dbgLocationKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  {Ctrl+space to use this result}
  if (ssCtrl in Shift)and (Key = VK_SPACE) then
    btnLocationOk.Click;
  {Advanced search}
  if (ssCtrl in Shift)and (Key = VK_F) then
    begin
      edtGridSearch.Visible:= True;
      edtGridSearch.SetFocus;
      Application.ProcessMessages;
    end;
end;

procedure TfrmMaterialsHPWarehouse.dbgWarehouseTitleClick(Column: TColumn);
var
  recCount, recNo : String;
  recMsg : String = '0 od 0'; {find again recNo}
begin
  {sort}
  doSortDbGrid(TZAbstractDataset(zqWarehouse), Column);
  {refresh after sort}
  dbgWarehouse.Refresh;
  { find recNo}
  recCount:= IntToStr(TZAbstractDataset(zqWarehouse).RecordCount);
  recNo:= IntToStr(TZAbstractDataset(zqWarehouse).RecNo);
  {create recMsg}
  recMsg:= recNo + ' od ' + recCount;
  edtRecNo.Text:= recMsg;
end;

procedure TfrmMaterialsHPWarehouse.dbLocationKeyPress(Sender: TObject;
  var Key: char);
begin
  {on pres Return}
  if(Key = #13) then
    begin
      locationArg:= FW_LOCATION_NAME;
      findLocation(dbLocation.Text);
    end;
end;

procedure TfrmMaterialsHPWarehouse.edtGridSearchKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  {Escape to exit}
  if (Key = VK_ESCAPE) then
    begin
      edtGridSearch.Visible:= False;
      dbgLocation.SetFocus;
      Application.ProcessMessages;
      Exit;
    end;
  {Ctrl+space to use this result}
  if (ssCtrl in Shift)and (Key = VK_SPACE) then
    btnLocationOk.Click;
end;

procedure TfrmMaterialsHPWarehouse.edtGridSearchKeyUp(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  {try to locate}
  if(not TZAbstractRODataset(zroFindLocation).Locate('L_NAME', edtGridSearch.Text, [loCaseInsensitive, loPartialKey])) then
    begin
      Beep;
      edtGridSearch.SelectAll;
    end;
end;

procedure TfrmMaterialsHPWarehouse.edtLocateEnter(Sender: TObject);
begin
  {clear text and set font-color}
  edtLocate.Text:= '';
  edtLocate.Font.Color:= clBlack;
end;

procedure TfrmMaterialsHPWarehouse.edtLocateExit(Sender: TObject);
begin
  {set text and font-color}
  edtLocate.Text:= 'Pronadji ...';
  edtLocate.Font.Color:= clGray;
end;

procedure TfrmMaterialsHPWarehouse.edtLocateKeyUp(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  {try to locate}
  if(not TZAbstractDataset(zqWarehouse).Locate(FW_NAME, edtLocate.Text, [loCaseInsensitive, loPartialKey])) then
    begin
      Beep;
      edtLocate.SelectAll;
    end;
end;

procedure TfrmMaterialsHPWarehouse.FormClose(Sender: TObject;
  var CloseAction: TCloseAction);
begin
  saveBeforeClose;
  inherited;
end;

procedure TfrmMaterialsHPWarehouse.zqWarehouseAfterDelete(DataSet: TDataSet);
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

procedure TfrmMaterialsHPWarehouse.zqWarehouseAfterOpen(DataSet: TDataSet);
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

procedure TfrmMaterialsHPWarehouse.zqWarehouseAfterPost(DataSet: TDataSet);
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

procedure TfrmMaterialsHPWarehouse.zqWarehouseAfterScroll(DataSet: TDataSet);
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

procedure TfrmMaterialsHPWarehouse.saveBeforeClose;
var
  newDlg : TdlgConfirm;
  confirmMsg : String = 'Postoje izmene koje nisu sačuvane!';
  saveAll : Boolean = False;
begin
  {set confirm msg}
  confirmMsg:= confirmMsg + #13#10;
  confirmMsg:= confirmMsg + 'Želite da sačuvamo izmene?';
  if(TZAbstractDataset(zqWarehouse).State in [dsEdit, dsInsert]) then
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
    doSaveRec(TZAbstractDataset(zqWarehouse)); {in this case just one dataSet}
end;

procedure TfrmMaterialsHPWarehouse.findLocation(textArg: String);
var
  argCode, argName : String;
begin
  {find argument}
  if(locationArg = FW_LOCATION_NAME) then
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

procedure TfrmMaterialsHPWarehouse.useThisLocation;
begin
  TZAbstractDataset(zqWarehouse).FieldByName(FW_LOCATION).AsInteger:= zroFindLocation.Fields[0].AsInteger;
  TZAbstractDataset(zqWarehouse).FieldByName(FW_LOCATION_NAME).AsString:= zroFindLocation.Fields[2].AsString;
  //hide panel
  if(edtGridSearch.Visible) then
    edtGridSearch.Visible:= False;
  panelFindLocation.Visible:= False;
  //set focus
  dbAddress.SetFocus;
  Application.ProcessMessages;
end;

procedure TfrmMaterialsHPWarehouse.onActFirst;
begin
  {jump to first rec}
  doFirstRec(TZAbstractDataset(zqWarehouse));
end;

procedure TfrmMaterialsHPWarehouse.onActPrior;
begin
  {jump to prior rec}
  doPriorRec(TZAbstractDataset(zqWarehouse));
end;

procedure TfrmMaterialsHPWarehouse.onActNext;
begin
  {jump to next rec}
  doNextRec(TZAbstractDataset(zqWarehouse));
end;

procedure TfrmMaterialsHPWarehouse.onActLast;
begin
  {jump to last rec}
  doLastRec(TZAbstractDataset(zqWarehouse));
end;

procedure TfrmMaterialsHPWarehouse.onActInsert;
begin
  {set focus and insert new rec}
  dbCode.SetFocus;
  doInsertRec(TZAbstractDataset(zqWarehouse));
end;

procedure TfrmMaterialsHPWarehouse.onActDelete;
begin
  {delete rec}
  doDeleteRec(TZAbstractDataset(zqWarehouse));
end;

procedure TfrmMaterialsHPWarehouse.onActEdit;
begin
  {set focus and edit rec}
  dbCode.SetFocus;
  doEditRec(TZAbstractDataset(zqWarehouse));
end;

procedure TfrmMaterialsHPWarehouse.onActSave;
begin
  {save rec}
  doSaveRec(TZAbstractDataset(zqWarehouse));
end;

procedure TfrmMaterialsHPWarehouse.onActCancel;
begin
  {hide panel}
  if(edtGridSearch.Visible) then
    edtGridSearch.Visible:= False;
  if(panelFindLocation.Visible) then
    panelFindLocation.Visible:= False;
  {cancel rec}
  doCancelRec(TZAbstractDataset(zqWarehouse));
end;

procedure TfrmMaterialsHPWarehouse.openDataSet;
begin
  {department(read only)}
  TZAbstractDataset(TZAbstractRODataset(zroDepartment)).DisableControls;
  TZAbstractDataset(TZAbstractRODataset(zroDepartment)).Close;
  {department}
  TZAbstractDataset(zqWarehouse).DisableControls;
  TZAbstractDataset(zqWarehouse).Close;
  try
    TZAbstractDataset(TZAbstractRODataset(zroDepartment)).Open;
    TZAbstractDataset(TZAbstractRODataset(zroDepartment)).EnableControls;
    TZAbstractDataset(zqWarehouse).Open;
    TZAbstractDataset(zqWarehouse).EnableControls;
  except
    on e : Exception do
    begin
      dModule.zdbh.Rollback;
      TZAbstractDataset(TZAbstractRODataset(zroDepartment)).EnableControls;
      TZAbstractDataset(zqWarehouse).EnableControls;
      ShowMessage(e.Message);
    end;
  end;
end;

end.

