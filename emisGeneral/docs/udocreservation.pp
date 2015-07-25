unit uDocReservation;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,
  ActnList, DbCtrls, DBGrids, uBaseDbForm, db, ZDataset, ZSequence,
  ZAbstractDataset;

type

  { TfrmDocReservation }

  TfrmDocReservation = class(TbaseDbForm)
    dbCode: TDBEdit;
    dbgDocReservation: TDBGrid;
    dbName: TDBEdit;
    dsDocReservation: TDataSource;
    groupBoxEdit: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    zseqDocReservation: TZSequence;
    ztDocReservation: TZTable;
    ztDocReservationDR_CODE: TStringField;
    ztDocReservationDR_ID: TLongintField;
    ztDocReservationDR_NAME: TStringField;
    procedure dbgDocReservationMouseMove(Sender: TObject; Shift: TShiftState;
      X, Y: Integer);
    procedure dbgDocReservationTitleClick(Column: TColumn);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure ztDocReservationAfterDelete(DataSet: TDataSet);
    procedure ztDocReservationAfterOpen(DataSet: TDataSet);
    procedure ztDocReservationAfterPost(DataSet: TDataSet);
    procedure ztDocReservationAfterScroll(DataSet: TDataSet);
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
  frmDocReservation: TfrmDocReservation;
const
  {fields of tbl DocReservation}
  FIELD_ID : String = 'DR_ID';
  FIELD_CODE : String = 'DR_CODE';
  FIELD_NAME : String = 'DR_NAME';
implementation
uses
  uDModule, uConfirm;
{$R *.lfm}

{ TfrmDocReservation }

procedure TfrmDocReservation.dbgDocReservationMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
  {set cursor again}
  dbgDocReservation.Cursor:= crHandPoint;
end;

procedure TfrmDocReservation.dbgDocReservationTitleClick(Column: TColumn);
var
  recCount, recNo : String;
  recMsg : String = '0 od 0'; {find again recNo}
begin
  {sort}
  doSortDbGrid(TZAbstractDataset(ztDocReservation), Column);
  {refresh after sort}
  dbgDocReservation.Refresh;
  { find recNo}
  recCount:= IntToStr(TZAbstractDataset(ztDocReservation).RecordCount);
  recNo:= IntToStr(TZAbstractDataset(ztDocReservation).RecNo);
  {create recMsg}
  recMsg:= recNo + ' od ' + recCount;
  edtRecNo.Text:= recMsg;
end;

procedure TfrmDocReservation.FormClose(Sender: TObject;
  var CloseAction: TCloseAction);
begin
  {check for unsaved changes}
  saveBeforeClose;
  inherited;
end;

procedure TfrmDocReservation.ztDocReservationAfterDelete(DataSet: TDataSet);
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

procedure TfrmDocReservation.ztDocReservationAfterOpen(DataSet: TDataSet);
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

procedure TfrmDocReservation.ztDocReservationAfterPost(DataSet: TDataSet);
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

procedure TfrmDocReservation.ztDocReservationAfterScroll(DataSet: TDataSet);
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

procedure TfrmDocReservation.saveBeforeClose;
var
  newDlg : TdlgConfirm;
  confirmMsg : String = 'Postoje izmene koje nisu sačuvane!';
  saveAll : Boolean = False;
begin
  {set confirm msg}
  confirmMsg:= confirmMsg + #13#10;
  confirmMsg:= confirmMsg + 'Želite da sačuvamo izmene?';
  if(TZAbstractDataset(ztDocReservation).State in [dsEdit, dsInsert]) then
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
    doSaveRec(TZAbstractDataset(ztDocReservation)); {in this case just one dataSet}
end;

procedure TfrmDocReservation.onActFirst;
begin
  {jump to first rec}
  doFirstRec(TZAbstractDataset(ztDocReservation));
end;

procedure TfrmDocReservation.onActPrior;
begin
  {jump to prior rec}
  doPriorRec(TZAbstractDataset(ztDocReservation));
end;

procedure TfrmDocReservation.onActNext;
begin
  {jump to next rec}
  doNextRec(TZAbstractDataset(ztDocReservation));
end;

procedure TfrmDocReservation.onActLast;
begin
  {jump to last rec}
  doLastRec(TZAbstractDataset(ztDocReservation));
end;

procedure TfrmDocReservation.onActInsert;
begin
  {set focus and insert new rec}
  dbCode.SetFocus;
  doInsertRec(TZAbstractDataset(ztDocReservation));
end;

procedure TfrmDocReservation.onActDelete;
begin
  {delete rec}
  doDeleteRec(TZAbstractDataset(ztDocReservation));
end;

procedure TfrmDocReservation.onActEdit;
begin
  {set focus and edit rec}
  dbCode.SetFocus;
  doEditRec(TZAbstractDataset(ztDocReservation));
end;

procedure TfrmDocReservation.onActSave;
begin
  {save rec}
  doSaveRec(TZAbstractDataset(ztDocReservation));
end;

procedure TfrmDocReservation.onActCancel;
begin
  {cancel rec}
  doCancelRec(TZAbstractDataset(ztDocReservation));
end;

procedure TfrmDocReservation.openDataSet;
begin
  TZAbstractDataset(ztDocReservation).DisableControls;
  TZAbstractDataset(ztDocReservation).Close;
  try
    TZAbstractDataset(ztDocReservation).Open;
    TZAbstractDataset(ztDocReservation).EnableControls;
  except
    on e : Exception do
    begin
      dModule.zdbh.Rollback;
      TZAbstractDataset(ztDocReservation).EnableControls;
      ShowMessage(e.Message);
    end;
  end;
end;

end.

