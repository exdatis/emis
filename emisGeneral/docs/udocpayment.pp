unit uDocPayment;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,
  ActnList, DbCtrls, DBGrids, uBaseDbForm, db, ZDataset, ZSequence,
  ZAbstractDataset;

type

  { TfrmDocPayment }

  TfrmDocPayment = class(TbaseDbForm)
    dbCode: TDBEdit;
    dbgDocPayment: TDBGrid;
    dbName: TDBEdit;
    dsDocPayment: TDataSource;
    groupBoxEdit: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    zseqDocPayment: TZSequence;
    ztDocPayment: TZTable;
    ztDocPaymentDP_CODE: TStringField;
    ztDocPaymentDP_ID: TLongintField;
    ztDocPaymentDP_NAME: TStringField;
    procedure dbgDocPaymentMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure dbgDocPaymentTitleClick(Column: TColumn);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure ztDocPaymentAfterDelete(DataSet: TDataSet);
    procedure ztDocPaymentAfterOpen(DataSet: TDataSet);
    procedure ztDocPaymentAfterPost(DataSet: TDataSet);
    procedure ztDocPaymentAfterScroll(DataSet: TDataSet);
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
  frmDocPayment: TfrmDocPayment;
const
  {fields of tbl DocPayment}
  FIELD_ID : String = 'DP_ID';
  FIELD_CODE : String = 'DP_CODE';
  FIELD_NAME : String = 'DP_NAME';
implementation
uses
  uDModule, uConfirm;
{$R *.lfm}

{ TfrmDocPayment }

procedure TfrmDocPayment.dbgDocPaymentMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
  {set cursor again}
  dbgDocPayment.Cursor:= crHandPoint;
end;

procedure TfrmDocPayment.dbgDocPaymentTitleClick(Column: TColumn);
var
  recCount, recNo : String;
  recMsg : String = '0 od 0'; {find again recNo}
begin
  {sort}
  doSortDbGrid(TZAbstractDataset(ztDocPayment), Column);
  {refresh after sort}
  dbgDocPayment.Refresh;
  { find recNo}
  recCount:= IntToStr(TZAbstractDataset(ztDocPayment).RecordCount);
  recNo:= IntToStr(TZAbstractDataset(ztDocPayment).RecNo);
  {create recMsg}
  recMsg:= recNo + ' od ' + recCount;
  edtRecNo.Text:= recMsg;
end;

procedure TfrmDocPayment.FormClose(Sender: TObject;
  var CloseAction: TCloseAction);
begin
  {check for unsaved changes}
  saveBeforeClose;
  inherited;
end;

procedure TfrmDocPayment.ztDocPaymentAfterDelete(DataSet: TDataSet);
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

procedure TfrmDocPayment.ztDocPaymentAfterOpen(DataSet: TDataSet);
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

procedure TfrmDocPayment.ztDocPaymentAfterPost(DataSet: TDataSet);
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

procedure TfrmDocPayment.ztDocPaymentAfterScroll(DataSet: TDataSet);
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

procedure TfrmDocPayment.saveBeforeClose;
var
  newDlg : TdlgConfirm;
  confirmMsg : String = 'Postoje izmene koje nisu sačuvane!';
  saveAll : Boolean = False;
begin
  {set confirm msg}
  confirmMsg:= confirmMsg + #13#10;
  confirmMsg:= confirmMsg + 'Želite da sačuvamo izmene?';
  if(TZAbstractDataset(ztDocPayment).State in [dsEdit, dsInsert]) then
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
    doSaveRec(TZAbstractDataset(ztDocPayment)); {in this case just one dataSet}
end;

procedure TfrmDocPayment.onActFirst;
begin
  {jump to first rec}
  doFirstRec(TZAbstractDataset(ztDocPayment));
end;

procedure TfrmDocPayment.onActPrior;
begin
  {jump to prior rec}
  doPriorRec(TZAbstractDataset(ztDocPayment));
end;

procedure TfrmDocPayment.onActNext;
begin
  {jump to next rec}
  doNextRec(TZAbstractDataset(ztDocPayment));
end;

procedure TfrmDocPayment.onActLast;
begin
  {jump to last rec}
  doLastRec(TZAbstractDataset(ztDocPayment));
end;

procedure TfrmDocPayment.onActInsert;
begin
  {set focus and insert new rec}
  dbCode.SetFocus;
  doInsertRec(TZAbstractDataset(ztDocPayment));
end;

procedure TfrmDocPayment.onActDelete;
begin
  {delete rec}
  doDeleteRec(TZAbstractDataset(ztDocPayment));
end;

procedure TfrmDocPayment.onActEdit;
begin
  {set focus and edit rec}
  dbCode.SetFocus;
  doEditRec(TZAbstractDataset(ztDocPayment));
end;

procedure TfrmDocPayment.onActSave;
begin
  {save rec}
  doSaveRec(TZAbstractDataset(ztDocPayment));
end;

procedure TfrmDocPayment.onActCancel;
begin
  {cancel rec}
  doCancelRec(TZAbstractDataset(ztDocPayment));
end;

procedure TfrmDocPayment.openDataSet;
begin
  TZAbstractDataset(ztDocPayment).DisableControls;
  TZAbstractDataset(ztDocPayment).Close;
  try
    TZAbstractDataset(ztDocPayment).Open;
    TZAbstractDataset(ztDocPayment).EnableControls;
  except
    on e : Exception do
    begin
      dModule.zdbh.Rollback;
      TZAbstractDataset(ztDocPayment).EnableControls;
      ShowMessage(e.Message);
    end;
  end;
end;

end.

