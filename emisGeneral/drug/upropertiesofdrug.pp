unit uPropertiesOfDrug;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, ZDataset, ZSequence, Forms, Controls, Graphics,
  Dialogs, StdCtrls, ActnList, ExtCtrls, DbCtrls, DBGrids, uBaseDbForm, db,
  ZAbstractDataset;

type

  { TfrmPropertiesOfDrug }

  TfrmPropertiesOfDrug = class(TbaseDbForm)
    dbCode: TDBEdit;
    dbgPropertiesOfDrug: TDBGrid;
    dbName: TDBEdit;
    dsPropertiesOfDrug: TDataSource;
    edtLocate: TEdit;
    groupBoxEdit: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    panelSearch: TPanel;
    zseqPropertiesOfDrug: TZSequence;
    ztPropertiesOfDrug: TZTable;
    ztPropertiesOfDrugPOD_CODE: TStringField;
    ztPropertiesOfDrugPOD_ID: TLongintField;
    ztPropertiesOfDrugPOD_NAME: TStringField;
    procedure dbgPropertiesOfDrugMouseMove(Sender: TObject; Shift: TShiftState;
      X, Y: Integer);
    procedure dbgPropertiesOfDrugTitleClick(Column: TColumn);
    procedure edtLocateEnter(Sender: TObject);
    procedure edtLocateExit(Sender: TObject);
    procedure edtLocateKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState
      );
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure ztPropertiesOfDrugAfterDelete(DataSet: TDataSet);
    procedure ztPropertiesOfDrugAfterOpen(DataSet: TDataSet);
    procedure ztPropertiesOfDrugAfterPost(DataSet: TDataSet);
    procedure ztPropertiesOfDrugAfterScroll(DataSet: TDataSet);
  private
    { private declarations }
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
    {open dataSet}
    procedure openDataSet;
  end;

var
  frmPropertiesOfDrug: TfrmPropertiesOfDrug;
const
  {fields of tbl propertiesOfDrug}
  FPOD_ID : String = 'POD_ID';
  FPOD_CODE : String = 'POD_CODE';
  FPOD_NAME : String = 'POD_NAME';
implementation
uses
  uDModule, uConfirm;
{$R *.lfm}

{ TfrmPropertiesOfDrug }

procedure TfrmPropertiesOfDrug.dbgPropertiesOfDrugMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
  {set cursor again}
  dbgPropertiesOfDrug.Cursor:= crHandPoint;
end;

procedure TfrmPropertiesOfDrug.dbgPropertiesOfDrugTitleClick(Column: TColumn);
var
  recCount, recNo : String;
  recMsg : String = '0 od 0'; {find again recNo}
begin
  {sort}
  doSortDbGrid(TZAbstractDataset(ztPropertiesOfDrug), Column);
  {refresh after sort}
  dbgPropertiesOfDrug.Refresh;
  { find recNo}
  recCount:= IntToStr(TZAbstractDataset(ztPropertiesOfDrug).RecordCount);
  recNo:= IntToStr(TZAbstractDataset(ztPropertiesOfDrug).RecNo);
  {create recMsg}
  recMsg:= recNo + ' od ' + recCount;
  edtRecNo.Text:= recMsg;
end;

procedure TfrmPropertiesOfDrug.edtLocateEnter(Sender: TObject);
begin
  {clear text and set font-color}
  edtLocate.Text:= '';
  edtLocate.Font.Color:= clBlack;
end;

procedure TfrmPropertiesOfDrug.edtLocateExit(Sender: TObject);
begin
  {set text and font-color}
  edtLocate.Text:= 'Pronadji ...';
  edtLocate.Font.Color:= clGray;
end;

procedure TfrmPropertiesOfDrug.edtLocateKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  {try to locate}
  if(not TZAbstractDataset(ztPropertiesOfDrug).Locate(FPOD_NAME, edtLocate.Text, [loCaseInsensitive, loPartialKey])) then
    begin
      Beep;
      edtLocate.SelectAll;
    end;
end;

procedure TfrmPropertiesOfDrug.FormClose(Sender: TObject;
  var CloseAction: TCloseAction);
begin
  {check for unsaved changes}
  saveBeforeClose;
  inherited;
end;

procedure TfrmPropertiesOfDrug.ztPropertiesOfDrugAfterDelete(DataSet: TDataSet);
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

procedure TfrmPropertiesOfDrug.ztPropertiesOfDrugAfterOpen(DataSet: TDataSet);
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

procedure TfrmPropertiesOfDrug.ztPropertiesOfDrugAfterPost(DataSet: TDataSet);
var
  {calc records(recNo and countRec)}
  recCount, recNo : String;
  recMsg : String = '0 od 0';
  currId : Longint = 0; {to find after refresh}
begin
  {upply updates}
  TZAbstractDataset(DataSet).ApplyUpdates;
  {rtefresh current row}
  currId:= TZAbstractDataset(DataSet).FieldByName(FPOD_ID).AsInteger;
  TZAbstractDataset(DataSet).DisableControls;
  TZAbstractDataset(DataSet).Refresh;
  TZAbstractDataset(DataSet).Locate(FPOD_ID, currId, []);
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

procedure TfrmPropertiesOfDrug.ztPropertiesOfDrugAfterScroll(DataSet: TDataSet);
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

procedure TfrmPropertiesOfDrug.onActFirst;
begin
  {jump to first rec}
  doFirstRec(TZAbstractDataset(ztPropertiesOfDrug));
end;

procedure TfrmPropertiesOfDrug.onActPrior;
begin
  {jump to prior rec}
  doPriorRec(TZAbstractDataset(ztPropertiesOfDrug));
end;

procedure TfrmPropertiesOfDrug.onActNext;
begin
  {jump to next rec}
  doNextRec(TZAbstractDataset(ztPropertiesOfDrug));
end;

procedure TfrmPropertiesOfDrug.onActLast;
begin
  {jump to last rec}
  doLastRec(TZAbstractDataset(ztPropertiesOfDrug));
end;

procedure TfrmPropertiesOfDrug.onActInsert;
begin
  {set focus and insert new rec}
  dbCode.SetFocus;
  doInsertRec(TZAbstractDataset(ztPropertiesOfDrug));
end;

procedure TfrmPropertiesOfDrug.onActDelete;
begin
  {delete rec}
  doDeleteRec(TZAbstractDataset(ztPropertiesOfDrug));
end;

procedure TfrmPropertiesOfDrug.onActEdit;
begin
  {set focus and edit rec}
  dbCode.SetFocus;
  doEditRec(TZAbstractDataset(ztPropertiesOfDrug));
end;

procedure TfrmPropertiesOfDrug.onActSave;
begin
  {save rec}
  doSaveRec(TZAbstractDataset(ztPropertiesOfDrug));
end;

procedure TfrmPropertiesOfDrug.onActCancel;
begin
  {cancel rec}
  doCancelRec(TZAbstractDataset(ztPropertiesOfDrug));
end;

procedure TfrmPropertiesOfDrug.openDataSet;
begin
  TZAbstractDataset(ztPropertiesOfDrug).DisableControls;
  TZAbstractDataset(ztPropertiesOfDrug).Close;
  try
    TZAbstractDataset(ztPropertiesOfDrug).Open;
    TZAbstractDataset(ztPropertiesOfDrug).EnableControls;
  except
    on e : Exception do
    begin
      dModule.zdbh.Rollback;
      TZAbstractDataset(ztPropertiesOfDrug).EnableControls;
      ShowMessage(e.Message);
    end;
  end;
end;

procedure TfrmPropertiesOfDrug.saveBeforeClose;
var
  newDlg : TdlgConfirm;
  confirmMsg : String = 'Postoje izmene koje nisu sačuvane!';
  saveAll : Boolean = False;
begin
  {set confirm msg}
  confirmMsg:= confirmMsg + #13#10;
  confirmMsg:= confirmMsg + 'Želite da sačuvamo izmene?';
  if(TZAbstractDataset(ztPropertiesOfDrug).State in [dsEdit, dsInsert]) then
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
    doSaveRec(TZAbstractDataset(ztPropertiesOfDrug)); {in this case just one dataSet}
end;


end.

