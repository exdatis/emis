unit uDocRequisition;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,
  ActnList, DbCtrls, DBGrids, uBaseDbForm, db, ZDataset, ZSequence,
  ZAbstractDataset;

type

  { TfrmDocRequisition }

  TfrmDocRequisition = class(TbaseDbForm)
    dbCode: TDBEdit;
    dbgDocRequisition: TDBGrid;
    dbName: TDBEdit;
    dsDocRequisition: TDataSource;
    groupBoxEdit: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    zseqDocRequisition: TZSequence;
    ztDocRequisition: TZTable;
    ztDocRequisitionDR_CODE: TStringField;
    ztDocRequisitionDR_ID: TLongintField;
    ztDocRequisitionDR_NAME: TStringField;
    procedure dbgDocRequisitionMouseMove(Sender: TObject; Shift: TShiftState;
      X, Y: Integer);
    procedure dbgDocRequisitionTitleClick(Column: TColumn);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure ztDocRequisitionAfterDelete(DataSet: TDataSet);
    procedure ztDocRequisitionAfterOpen(DataSet: TDataSet);
    procedure ztDocRequisitionAfterPost(DataSet: TDataSet);
    procedure ztDocRequisitionAfterScroll(DataSet: TDataSet);
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
  frmDocRequisition: TfrmDocRequisition;
const
  {fields of tbl DocRequisition}
  FIELD_ID : String = 'DR_ID';
  FIELD_CODE : String = 'DR_CODE';
  FIELD_NAME : String = 'DR_NAME';
implementation
uses
  uDModule, uConfirm;
{$R *.lfm}

{ TfrmDocRequisition }

procedure TfrmDocRequisition.dbgDocRequisitionMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
  {set cursor again}
  dbgDocRequisition.Cursor:= crHandPoint;
end;

procedure TfrmDocRequisition.dbgDocRequisitionTitleClick(Column: TColumn);
var
  recCount, recNo : String;
  recMsg : String = '0 od 0'; {find again recNo}
begin
  {sort}
  doSortDbGrid(TZAbstractDataset(ztDocRequisition), Column);
  {refresh after sort}
  dbgDocRequisition.Refresh;
  { find recNo}
  recCount:= IntToStr(TZAbstractDataset(ztDocRequisition).RecordCount);
  recNo:= IntToStr(TZAbstractDataset(ztDocRequisition).RecNo);
  {create recMsg}
  recMsg:= recNo + ' od ' + recCount;
  edtRecNo.Text:= recMsg;
end;

procedure TfrmDocRequisition.FormClose(Sender: TObject;
  var CloseAction: TCloseAction);
begin
  {check for unsaved changes}
  saveBeforeClose;
  inherited;
end;

procedure TfrmDocRequisition.ztDocRequisitionAfterDelete(DataSet: TDataSet);
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

procedure TfrmDocRequisition.ztDocRequisitionAfterOpen(DataSet: TDataSet);
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

procedure TfrmDocRequisition.ztDocRequisitionAfterPost(DataSet: TDataSet);
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

procedure TfrmDocRequisition.ztDocRequisitionAfterScroll(DataSet: TDataSet);
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

procedure TfrmDocRequisition.saveBeforeClose;
var
  newDlg : TdlgConfirm;
  confirmMsg : String = 'Postoje izmene koje nisu sačuvane!';
  saveAll : Boolean = False;
begin
  {set confirm msg}
  confirmMsg:= confirmMsg + #13#10;
  confirmMsg:= confirmMsg + 'Želite da sačuvamo izmene?';
  if(TZAbstractDataset(ztDocRequisition).State in [dsEdit, dsInsert]) then
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
    doSaveRec(TZAbstractDataset(ztDocRequisition)); {in this case just one dataSet}
end;

procedure TfrmDocRequisition.onActFirst;
begin
  {jump to first rec}
  doFirstRec(TZAbstractDataset(ztDocRequisition));
end;

procedure TfrmDocRequisition.onActPrior;
begin
  {jump to prior rec}
  doPriorRec(TZAbstractDataset(ztDocRequisition));
end;

procedure TfrmDocRequisition.onActNext;
begin
  {jump to next rec}
  doNextRec(TZAbstractDataset(ztDocRequisition));
end;

procedure TfrmDocRequisition.onActLast;
begin
  {jump to last rec}
  doLastRec(TZAbstractDataset(ztDocRequisition));
end;

procedure TfrmDocRequisition.onActInsert;
begin
  {set focus and insert new rec}
  dbCode.SetFocus;
  doInsertRec(TZAbstractDataset(ztDocRequisition));
end;

procedure TfrmDocRequisition.onActDelete;
begin
  {delete rec}
  doDeleteRec(TZAbstractDataset(ztDocRequisition));
end;

procedure TfrmDocRequisition.onActEdit;
begin
  {set focus and edit rec}
  dbCode.SetFocus;
  doEditRec(TZAbstractDataset(ztDocRequisition));
end;

procedure TfrmDocRequisition.onActSave;
begin
  {save rec}
  doSaveRec(TZAbstractDataset(ztDocRequisition));
end;

procedure TfrmDocRequisition.onActCancel;
begin
  {cancel rec}
  doCancelRec(TZAbstractDataset(ztDocRequisition));
end;

procedure TfrmDocRequisition.openDataSet;
begin
  TZAbstractDataset(ztDocRequisition).DisableControls;
  TZAbstractDataset(ztDocRequisition).Close;
  try
    TZAbstractDataset(ztDocRequisition).Open;
    TZAbstractDataset(ztDocRequisition).EnableControls;
  except
    on e : Exception do
    begin
      dModule.zdbh.Rollback;
      TZAbstractDataset(ztDocRequisition).EnableControls;
      ShowMessage(e.Message);
    end;
  end;
end;

end.

