unit uSupplyServices;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, ZDataset, ZSequence, ZSqlUpdate, Forms, Controls,
  Graphics, Dialogs, StdCtrls, ActnList, ExtCtrls, Buttons, DbCtrls, DBGrids,
  uBaseDbForm, db, ZAbstractDataset;

type

  { TfrmSupplyServices }

  TfrmSupplyServices = class(TbaseDbForm)
    actCharFilter: TAction;
    actClearFilter: TAction;
    actFindServices: TActionList;
    btnCharFilter: TSpeedButton;
    btnShowAll: TSpeedButton;
    cmbCharFilter: TComboBox;
    cmbFieldArg: TComboBox;
    dbgServices: TDBGrid;
    dblMeasure: TDBLookupComboBox;
    dblTax: TDBLookupComboBox;
    dsGroups: TDataSource;
    dbCode: TDBEdit;
    dblGroup: TDBLookupComboBox;
    dbName: TDBEdit;
    dsMeasure: TDataSource;
    dsServices: TDataSource;
    dsTaxes: TDataSource;
    edtLocate: TEdit;
    gbEditServices: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    panelParams: TPanel;
    zqServices: TZQuery;
    zqServicesGROUP_CODE: TStringField;
    zqServicesGROUP_NAME: TStringField;
    zqServicesMEASURE_CODE: TStringField;
    zqServicesMEASURE_NAME: TStringField;
    zqServicesSS_CODE: TStringField;
    zqServicesSS_GROUP: TLongintField;
    zqServicesSS_ID: TLongintField;
    zqServicesSS_MEASURE: TLongintField;
    zqServicesSS_NAME: TStringField;
    zqServicesSS_TAX: TLongintField;
    zqServicesTAX_CODE: TStringField;
    zqServicesTAX_VALUE: TFloatField;
    zroGroups: TZReadOnlyQuery;
    zroGroupsSSG_ID: TLongintField;
    zroGroupsSSG_NAME: TStringField;
    zroMeasure: TZReadOnlyQuery;
    zroMeasureM_ID: TLongintField;
    zroMeasureM_NAME: TStringField;
    zroTaxes: TZReadOnlyQuery;
    zroTaxesTX_CODE: TStringField;
    zroTaxesTX_ID: TLongintField;
    zseqSupplyServices: TZSequence;
    zupdServices: TZUpdateSQL;
    procedure actCharFilterExecute(Sender: TObject);
    procedure actClearFilterExecute(Sender: TObject);
    procedure cmbFieldArgChange(Sender: TObject);
    procedure dbgServicesMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure dbgServicesTitleClick(Column: TColumn);
    procedure edtLocateEnter(Sender: TObject);
    procedure edtLocateExit(Sender: TObject);
    procedure edtLocateKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState
      );
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure zqServicesAfterDelete(DataSet: TDataSet);
    procedure zqServicesAfterOpen(DataSet: TDataSet);
    procedure zqServicesAfterPost(DataSet: TDataSet);
    procedure zqServicesAfterScroll(DataSet: TDataSet);
  private
    { private declarations }
    charArg : String; {name-start with this char}
    fieldArg : String; {locate text from field}
    procedure saveBeforeClose;
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
    {open dataSet using charArg}
    procedure openRODataSets;
    procedure applyCharFilter;
  end;

var
  frmSupplyServices: TfrmSupplyServices;
const
  {msg}
  EMPTY_SET : String = 'Prazan skup podataka.';
  {fields of tbl suupply_service}
  FS_ID : String = 'SS_ID';
  FS_CODE : String = 'SS_CODE';
  FS_NAME : String = 'SS_NAME';
  FS_GROUP : String = 'SS_GROUP';
  FS_MEASURE : String = 'SS_MEASURE';
  FS_TAX : String = 'SS_TAX';
  {fields of view supply_services_v --FSV - field-service_view}
  FSV_GROUP_CODE : String = 'GROUP_CODE';
  FSV_GROUP_NAME : String = 'GROUP_NAME';
  FSV_MEASURE_CODE : String = 'MEASURE_CODE';
  FSV_MEASURE_NAME : String = 'MEASURE_NAME';
  FSV_TAX_CODE : String = 'TAX_CODE';
  FSV_TAX_VALUE : String = 'TAX_VALUE';
  {params}
  PARAM_NAME : String = 'SS_NAME'; {:SS_NAME}
implementation
uses
  uDModule, uConfirm;
{$R *.lfm}

{ TfrmSupplyServices }

procedure TfrmSupplyServices.FormCreate(Sender: TObject);
begin
  {default args for query}
  charArg:= 'A%';
  fieldArg:= PARAM_NAME; {locate using field_name}
end;

procedure TfrmSupplyServices.actCharFilterExecute(Sender: TObject);
begin
  {set filter}
  charArg:= cmbCharFilter.Text + '%';
  {apply filter}
  applyCharFilter;
end;

procedure TfrmSupplyServices.actClearFilterExecute(Sender: TObject);
begin
  {set char-argument}
  charArg:= '%'; {show all}
  applyCharFilter;
  {set cmbCharFilter index}
  cmbCharFilter.Text:= 'Usluge na slovo ...'; {message like text}
end;

procedure TfrmSupplyServices.cmbFieldArgChange(Sender: TObject);
begin
  case cmbFieldArg.ItemIndex of
    1: fieldArg:= FS_NAME;
    2: fieldArg:= FS_CODE;
  else
    fieldArg:= FS_NAME;
  end;
  {set focus}
  edtLocate.SetFocus;
end;

procedure TfrmSupplyServices.dbgServicesMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
  {set cursor again}
  dbgServices.Cursor:= crHandPoint;
end;

procedure TfrmSupplyServices.dbgServicesTitleClick(Column: TColumn);
var
  recCount, recNo : String;
  recMsg : String = '0 od 0'; {find again recNo}
begin
  {sort}
  doSortDbGrid(TZAbstractDataset(zqServices), Column);
  {refresh after sort}
  dbgServices.Refresh;
  { find recNo}
  recCount:= IntToStr(TZAbstractDataset(zqServices).RecordCount);
  recNo:= IntToStr(TZAbstractDataset(zqServices).RecNo);
  {create recMsg}
  recMsg:= recNo + ' od ' + recCount;
  edtRecNo.Text:= recMsg;
end;

procedure TfrmSupplyServices.edtLocateEnter(Sender: TObject);
begin
  {clear text and set font-color}
  edtLocate.Text:= '';
  edtLocate.Font.Color:= clBlack;
end;

procedure TfrmSupplyServices.edtLocateExit(Sender: TObject);
begin
  {set text and font-color}
  edtLocate.Text:= 'Pronadji ...';
  edtLocate.Font.Color:= clGray;
end;

procedure TfrmSupplyServices.edtLocateKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  {try to locate}
  if(not TZAbstractDataset(zqServices).Locate(fieldArg, edtLocate.Text, [loCaseInsensitive, loPartialKey])) then
    begin
      Beep;
      edtLocate.SelectAll;
    end;
end;

procedure TfrmSupplyServices.FormClose(Sender: TObject;
  var CloseAction: TCloseAction);
begin
  {check for unsaved changes}
  saveBeforeClose;
  inherited;
end;

procedure TfrmSupplyServices.zqServicesAfterDelete(DataSet: TDataSet);
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

procedure TfrmSupplyServices.zqServicesAfterOpen(DataSet: TDataSet);
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

procedure TfrmSupplyServices.zqServicesAfterPost(DataSet: TDataSet);
var
  currId : Longint;
  firstChar : String = '';
  currText : String;
  {calc records(recNo and countRec)}
  recCount, recNo : String;
  recMsg : String = '0 od 0';
begin
  {upply updates}
  TZAbstractDataset(DataSet).ApplyUpdates;
  {rtefresh current row}
  TZAbstractDataset(DataSet).RefreshCurrentRow(True);
  {find currText}
  currText:= TZAbstractDataset(DataSet).FieldByName(FS_NAME).AsString;
  {first char to firstChar-var}
  firstChar:= LeftStr(currText, 1);
  firstChar:= firstChar + '%';
  {compare current charFilter}
  if(charArg <> firstChar) then
    begin
      {save position}
      currId:= TZAbstractDataset(DataSet).FieldByName(FS_ID).AsInteger;
      charArg:= firstChar;
      applyCharFilter;
      {locate}
      TZAbstractDataset(DataSet).Locate(FS_ID, currId, []);
    end;
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

procedure TfrmSupplyServices.zqServicesAfterScroll(DataSet: TDataSet);
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

procedure TfrmSupplyServices.saveBeforeClose;
var
  newDlg : TdlgConfirm;
  confirmMsg : String = 'Postoje izmene koje nisu sačuvane!';
  saveAll : Boolean = False;
begin
  {set confirm msg}
  confirmMsg:= confirmMsg + #13#10;
  confirmMsg:= confirmMsg + 'Želite da sačuvamo izmene?';
  if(TZAbstractDataset(zqServices).State in [dsEdit, dsInsert]) then
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
    doSaveRec(TZAbstractDataset(zqServices)); {in this case just one dataSet}
end;

procedure TfrmSupplyServices.onActFirst;
begin
  {jump to first rec}
  doFirstRec(TZAbstractDataset(zqServices));
end;

procedure TfrmSupplyServices.onActPrior;
begin
  {jump to prior rec}
  doPriorRec(TZAbstractDataset(zqSErvices));
end;

procedure TfrmSupplyServices.onActNext;
begin
  {jump to next rec}
  doNextRec(TZAbstractDataset(zqSErvices));
end;

procedure TfrmSupplyServices.onActLast;
begin
  {jump to last rec}
  doLastRec(TZAbstractDataset(zqSErvices));
end;

procedure TfrmSupplyServices.onActInsert;
begin
  {set focus and insert new rec}
  dbCode.SetFocus;
  doInsertRec(TZAbstractDataset(zqSErvices));
end;

procedure TfrmSupplyServices.onActDelete;
begin
  {delete rec}
  doDeleteRec(TZAbstractDataset(zqSErvices));
end;

procedure TfrmSupplyServices.onActEdit;
begin
  {set focus and edit rec}
  dbCode.SetFocus;
  doEditRec(TZAbstractDataset(zqSErvices));
end;

procedure TfrmSupplyServices.onActSave;
begin
  {save rec}
  doSaveRec(TZAbstractDataset(zqSErvices));
end;

procedure TfrmSupplyServices.onActCancel;
begin
  {cancel rec}
  doCancelRec(TZAbstractDataset(zqSErvices));
end;

procedure TfrmSupplyServices.openRODataSets;
begin
  //product groups
  zroGroups.DisableControls;
  zroGroups.Open;
  zroGroups.EnableControls;
  //measure
  zroMeasure.DisableControls;
  zroMeasure.Open;
  zroMeasure.EnableControls;
  //taxes
  zroTaxes.DisableControls;
  zroTaxes.Open;
  zroTaxes.EnableControls;
end;

procedure TfrmSupplyServices.applyCharFilter;
begin
  TZAbstractDataset(zqSErvices).DisableControls;
  TZAbstractDataset(zqSErvices).Close;
  try
    TZAbstractDataset(zqSErvices).ParamByName(PARAM_NAME).AsString:= charArg;
    TZAbstractDataset(zqSErvices).Open;
    TZAbstractDataset(zqSErvices).EnableControls;
    {show arg in cmbChar}
    //cmbCharFilter.ItemIndex:= cmbCharFilter.Items.IndexOf(LeftStr(charArg, 1)); {without '%'}
  except
    on e : Exception do
    begin
      dModule.zdbh.Rollback;
      TZAbstractDataset(zqSErvices).EnableControls;
      ShowMessage(e.Message);
    end;
  end;
end;

end.

