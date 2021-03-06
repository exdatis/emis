unit uDocOutgoings;
// Finansije, isplate dobavljacima
{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,
  ActnList, DbCtrls, DBGrids, uBaseDbForm, db, ZDataset, ZSequence,
  ZAbstractDataset;

type

  { TfrmDocOutgoings }

  TfrmDocOutgoings = class(TbaseDbForm)
    dbCode: TDBEdit;
    dbgDocOutgoings: TDBGrid;
    dbName: TDBEdit;
    dsDocOutgoings: TDataSource;
    groupBoxEdit: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    zseqDocOutgoings: TZSequence;
    ztDocOutgoings: TZTable;
    ztDocOutgoingsDO_CODE: TStringField;
    ztDocOutgoingsDO_ID: TLongintField;
    ztDocOutgoingsDO_NAME: TStringField;
    procedure dbgDocOutgoingsMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure dbgDocOutgoingsTitleClick(Column: TColumn);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure ztDocOutgoingsAfterDelete(DataSet: TDataSet);
    procedure ztDocOutgoingsAfterOpen(DataSet: TDataSet);
    procedure ztDocOutgoingsAfterPost(DataSet: TDataSet);
    procedure ztDocOutgoingsAfterScroll(DataSet: TDataSet);
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
  frmDocOutgoings: TfrmDocOutgoings;
const
  {fields of tbl DocOutgoings}
  FIELD_ID : String = 'DO_ID';
  FIELD_CODE : String = 'DO_CODE';
  FIELD_NAME : String = 'DO_NAME';
implementation
uses
  uDModule, uConfirm;
{$R *.lfm}

{ TfrmDocOutgoings }

procedure TfrmDocOutgoings.dbgDocOutgoingsMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
  {set cursor again}
  dbgDocOutgoings.Cursor:= crHandPoint;
end;

procedure TfrmDocOutgoings.dbgDocOutgoingsTitleClick(Column: TColumn);
var
  recCount, recNo : String;
  recMsg : String = '0 od 0'; {find again recNo}
begin
  {sort}
  doSortDbGrid(TZAbstractDataset(ztDocOutgoings), Column);
  {refresh after sort}
  dbgDocOutgoings.Refresh;
  { find recNo}
  recCount:= IntToStr(TZAbstractDataset(ztDocOutgoings).RecordCount);
  recNo:= IntToStr(TZAbstractDataset(ztDocOutgoings).RecNo);
  {create recMsg}
  recMsg:= recNo + ' od ' + recCount;
  edtRecNo.Text:= recMsg;
end;

procedure TfrmDocOutgoings.FormClose(Sender: TObject;
  var CloseAction: TCloseAction);
begin
  {check for unsaved changes}
  saveBeforeClose;
  inherited;
end;

procedure TfrmDocOutgoings.ztDocOutgoingsAfterDelete(DataSet: TDataSet);
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

procedure TfrmDocOutgoings.ztDocOutgoingsAfterOpen(DataSet: TDataSet);
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

procedure TfrmDocOutgoings.ztDocOutgoingsAfterPost(DataSet: TDataSet);
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

procedure TfrmDocOutgoings.ztDocOutgoingsAfterScroll(DataSet: TDataSet);
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

procedure TfrmDocOutgoings.saveBeforeClose;
var
  newDlg : TdlgConfirm;
  confirmMsg : String = 'Postoje izmene koje nisu sačuvane!';
  saveAll : Boolean = False;
begin
  {set confirm msg}
  confirmMsg:= confirmMsg + #13#10;
  confirmMsg:= confirmMsg + 'Želite da sačuvamo izmene?';
  if(TZAbstractDataset(ztDocOutgoings).State in [dsEdit, dsInsert]) then
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
    doSaveRec(TZAbstractDataset(ztDocOutgoings)); {in this case just one dataSet}
end;

procedure TfrmDocOutgoings.onActFirst;
begin
  {jump to first rec}
  doFirstRec(TZAbstractDataset(ztDocOutgoings));
end;

procedure TfrmDocOutgoings.onActPrior;
begin
  {jump to prior rec}
  doPriorRec(TZAbstractDataset(ztDocOutgoings));
end;

procedure TfrmDocOutgoings.onActNext;
begin
  {jump to next rec}
  doNextRec(TZAbstractDataset(ztDocOutgoings));
end;

procedure TfrmDocOutgoings.onActLast;
begin
  {jump to last rec}
  doLastRec(TZAbstractDataset(ztDocOutgoings));
end;

procedure TfrmDocOutgoings.onActInsert;
begin
  {set focus and insert new rec}
  dbCode.SetFocus;
  doInsertRec(TZAbstractDataset(ztDocOutgoings));
end;

procedure TfrmDocOutgoings.onActDelete;
begin
  {delete rec}
  doDeleteRec(TZAbstractDataset(ztDocOutgoings));
end;

procedure TfrmDocOutgoings.onActEdit;
begin
  {set focus and edit rec}
  dbCode.SetFocus;
  doEditRec(TZAbstractDataset(ztDocOutgoings));
end;

procedure TfrmDocOutgoings.onActSave;
begin
  {save rec}
  doSaveRec(TZAbstractDataset(ztDocOutgoings));
end;

procedure TfrmDocOutgoings.onActCancel;
begin
  {cancel rec}
  doCancelRec(TZAbstractDataset(ztDocOutgoings));
end;

procedure TfrmDocOutgoings.openDataSet;
begin
  TZAbstractDataset(ztDocOutgoings).DisableControls;
  TZAbstractDataset(ztDocOutgoings).Close;
  try
    TZAbstractDataset(ztDocOutgoings).Open;
    TZAbstractDataset(ztDocOutgoings).EnableControls;
  except
    on e : Exception do
    begin
      dModule.zdbh.Rollback;
      TZAbstractDataset(ztDocOutgoings).EnableControls;
      ShowMessage(e.Message);
    end;
  end;
end;

end.

