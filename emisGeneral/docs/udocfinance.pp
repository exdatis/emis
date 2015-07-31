unit uDocFinance;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,
  ActnList, DbCtrls, DBGrids, uBaseDbForm, db, ZDataset, ZSequence,
  ZAbstractDataset;

type

  { TfrmDocFinance }

  TfrmDocFinance = class(TbaseDbForm)
    dbCode: TDBEdit;
    dbgDocFinance: TDBGrid;
    dbName: TDBEdit;
    dsDocFinance: TDataSource;
    groupBoxEdit: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    zseqDocFinance: TZSequence;
    ztDocFinance: TZTable;
    ztDocFinanceDF_CODE: TStringField;
    ztDocFinanceDF_ID: TLongintField;
    ztDocFinanceDF_NAME: TStringField;
    procedure dbgDocFinanceMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure dbgDocFinanceTitleClick(Column: TColumn);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure ztDocFinanceAfterDelete(DataSet: TDataSet);
    procedure ztDocFinanceAfterOpen(DataSet: TDataSet);
    procedure ztDocFinanceAfterPost(DataSet: TDataSet);
    procedure ztDocFinanceAfterScroll(DataSet: TDataSet);
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
  frmDocFinance: TfrmDocFinance;
const
  {fields of tbl DocFinance}
  FIELD_ID : String = 'DF_ID';
  FIELD_CODE : String = 'DF_CODE';
  FIELD_NAME : String = 'DF_NAME';
implementation
uses
  uDModule, uConfirm;
{$R *.lfm}

{ TfrmDocFinance }

procedure TfrmDocFinance.dbgDocFinanceMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
  {set cursor again}
  dbgDocFinance.Cursor:= crHandPoint;
end;

procedure TfrmDocFinance.dbgDocFinanceTitleClick(Column: TColumn);
var
  recCount, recNo : String;
  recMsg : String = '0 od 0'; {find again recNo}
begin
  {sort}
  doSortDbGrid(TZAbstractDataset(ztDocFinance), Column);
  {refresh after sort}
  dbgDocFinance.Refresh;
  { find recNo}
  recCount:= IntToStr(TZAbstractDataset(ztDocFinance).RecordCount);
  recNo:= IntToStr(TZAbstractDataset(ztDocFinance).RecNo);
  {create recMsg}
  recMsg:= recNo + ' od ' + recCount;
  edtRecNo.Text:= recMsg;
end;

procedure TfrmDocFinance.FormClose(Sender: TObject;
  var CloseAction: TCloseAction);
begin
  {check for unsaved changes}
  saveBeforeClose;
  inherited;
end;

procedure TfrmDocFinance.ztDocFinanceAfterDelete(DataSet: TDataSet);
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

procedure TfrmDocFinance.ztDocFinanceAfterOpen(DataSet: TDataSet);
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

procedure TfrmDocFinance.ztDocFinanceAfterPost(DataSet: TDataSet);
var
  {calc records(recNo and countRec)}
  recCount, recNo : String;
  recMsg : String = '0 od 0';
  currId : Longint = 0; {to find after refresh}
begin
  {upply updates}
  TZAbstractDataset(DataSet).ApplyUpdates;
  {rtefresh current row}
  currId:= TZAbstractDataset(DataSet).FieldByName(FIELD_ID).AsInteger;
  TZAbstractDataset(DataSet).DisableControls;
  TZAbstractDataset(DataSet).Refresh;
  TZAbstractDataset(DataSet).Locate(FIELD_ID, currId, []);
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

procedure TfrmDocFinance.ztDocFinanceAfterScroll(DataSet: TDataSet);
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

procedure TfrmDocFinance.saveBeforeClose;
var
  newDlg : TdlgConfirm;
  confirmMsg : String = 'Postoje izmene koje nisu sačuvane!';
  saveAll : Boolean = False;
begin
  {set confirm msg}
  confirmMsg:= confirmMsg + #13#10;
  confirmMsg:= confirmMsg + 'Želite da sačuvamo izmene?';
  if(TZAbstractDataset(ztDocFinance).State in [dsEdit, dsInsert]) then
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
    doSaveRec(TZAbstractDataset(ztDocFinance)); {in this case just one dataSet}
end;

procedure TfrmDocFinance.onActFirst;
begin
  {jump to first rec}
  doFirstRec(TZAbstractDataset(ztDocFinance));
end;

procedure TfrmDocFinance.onActPrior;
begin
  {jump to prior rec}
  doPriorRec(TZAbstractDataset(ztDocFinance));
end;

procedure TfrmDocFinance.onActNext;
begin
  {jump to next rec}
  doNextRec(TZAbstractDataset(ztDocFinance));
end;

procedure TfrmDocFinance.onActLast;
begin
  {jump to last rec}
  doLastRec(TZAbstractDataset(ztDocFinance));
end;

procedure TfrmDocFinance.onActInsert;
begin
  {set focus and insert new rec}
  dbCode.SetFocus;
  doInsertRec(TZAbstractDataset(ztDocFinance));
end;

procedure TfrmDocFinance.onActDelete;
begin
  {delete rec}
  doDeleteRec(TZAbstractDataset(ztDocFinance));
end;

procedure TfrmDocFinance.onActEdit;
begin
  {set focus and edit rec}
  dbCode.SetFocus;
  doEditRec(TZAbstractDataset(ztDocFinance));
end;

procedure TfrmDocFinance.onActSave;
begin
  {save rec}
  doSaveRec(TZAbstractDataset(ztDocFinance));
end;

procedure TfrmDocFinance.onActCancel;
begin
  {cancel rec}
  doCancelRec(TZAbstractDataset(ztDocFinance));
end;

procedure TfrmDocFinance.openDataSet;
begin
  TZAbstractDataset(ztDocFinance).DisableControls;
  TZAbstractDataset(ztDocFinance).Close;
  try
    TZAbstractDataset(ztDocFinance).Open;
    TZAbstractDataset(ztDocFinance).EnableControls;
  except
    on e : Exception do
    begin
      dModule.zdbh.Rollback;
      TZAbstractDataset(ztDocFinance).EnableControls;
      ShowMessage(e.Message);
    end;
  end;
end;

end.

