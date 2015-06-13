unit uDocSOOutput;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,
  ActnList, DbCtrls, DBGrids, uBaseDbForm, db, ZAbstractDataset,
  ZAbstractRODataset, ZDataset, ZSequence;

type

  { TfrmDocSOOutput }

  TfrmDocSOOutput = class(TbaseDbForm)
    dbCode: TDBEdit;
    dbgDocSOOutput: TDBGrid;
    dbName: TDBEdit;
    dsDocSOOutput: TDataSource;
    groupBoxEdit: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    zseqDocSOOutput: TZSequence;
    ztDocSOOutput: TZTable;
    ztDocSOOutputDSO_CODE: TStringField;
    ztDocSOOutputDSO_ID: TLongintField;
    ztDocSOOutputDSO_NAME: TStringField;
    procedure dbgDocSOOutputMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure dbgDocSOOutputTitleClick(Column: TColumn);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure ztDocSOOutputAfterDelete(DataSet: TDataSet);
    procedure ztDocSOOutputAfterOpen(DataSet: TDataSet);
    procedure ztDocSOOutputAfterPost(DataSet: TDataSet);
    procedure ztDocSOOutputAfterScroll(DataSet: TDataSet);
  private
    { private declarations }
    procedure saveBeforeClose;
    procedure sortDbGrid(var dataSet : TZAbstractDataset; Column : TColumn);
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
  frmDocSOOutput: TfrmDocSOOutput;
const
  {fields of tbl DocStorageOrderOutput}
  FIELD_ID : String = 'DSO_ID';
  FIELD_CODE : String = 'DSO_CODE';
  FIELD_NAME : String = 'DSO_NAME';
implementation
uses
  uDModule, uConfirm;
{$R *.lfm}

{ TfrmDocSOOutput }

procedure TfrmDocSOOutput.dbgDocSOOutputMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
  {set cursor again}
  dbgDocSOOutput.Cursor:= crHandPoint;
end;

procedure TfrmDocSOOutput.dbgDocSOOutputTitleClick(Column: TColumn);
var
  recCount, recNo : String;
  recMsg : String = '0 od 0'; {find again recNo}
begin
  {sort}
  sortDbGrid(TZAbstractDataset(ztDocSOOutput), Column);
  {refresh after sort}
  dbgDocSOOutput.Refresh;
  { find recNo}
  recCount:= IntToStr(TZAbstractDataset(ztDocSOOutput).RecordCount);
  recNo:= IntToStr(TZAbstractDataset(ztDocSOOutput).RecNo);
  {create recMsg}
  recMsg:= recNo + ' od ' + recCount;
  edtRecNo.Text:= recMsg;
end;

procedure TfrmDocSOOutput.FormClose(Sender: TObject;
  var CloseAction: TCloseAction);
begin
  {check for unsaved changes}
  saveBeforeClose;
  inherited;
end;

procedure TfrmDocSOOutput.ztDocSOOutputAfterDelete(DataSet: TDataSet);
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

procedure TfrmDocSOOutput.ztDocSOOutputAfterOpen(DataSet: TDataSet);
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

procedure TfrmDocSOOutput.ztDocSOOutputAfterPost(DataSet: TDataSet);
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

procedure TfrmDocSOOutput.ztDocSOOutputAfterScroll(DataSet: TDataSet);
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

procedure TfrmDocSOOutput.saveBeforeClose;
var
  newDlg : TdlgConfirm;
  confirmMsg : String = 'Postoje izmene koje nisu sačuvane!';
  saveAll : Boolean = False;
begin
  {set confirm msg}
  confirmMsg:= confirmMsg + #13#10;
  confirmMsg:= confirmMsg + 'Želite da sačuvamo izmene?';
  if(TZAbstractDataset(ztDocSOOutput).State in [dsEdit, dsInsert]) then
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
    doSaveRec(TZAbstractDataset(ztDocSOOutput)); {in this case just one dataSet}
end;

procedure TfrmDocSOOutput.sortDbGrid(var dataSet: TZAbstractDataset;
  Column: TColumn);
var
  currField : String;
  currSortType : TSortType;
begin
  {check current sortField and type}
  if( not dataSet.IsEmpty) then
    begin
      currField:= dataSet.SortedFields;
      currSortType:= dataSet.SortType;
      if(currField = Column.FieldName) then
        begin
          if currSortType = stAscending then
            dataSet.SortType:= stDescending
          else
            dataSet.SortType:= stAscending;
        end
      else
        begin
          dataSet.SortedFields:= Column.FieldName;
          dataSet.SortType:= stAscending;
        end;
    end;
    {just refresh}
end;

procedure TfrmDocSOOutput.onActFirst;
begin
  {jump to first rec}
  doFirstRec(TZAbstractDataset(ztDocSOOutput));
end;

procedure TfrmDocSOOutput.onActPrior;
begin
  {jump to prior rec}
  doPriorRec(TZAbstractDataset(ztDocSOOutput));
end;

procedure TfrmDocSOOutput.onActNext;
begin
  {jump to next rec}
  doNextRec(TZAbstractDataset(ztDocSOOutput));
end;

procedure TfrmDocSOOutput.onActLast;
begin
  {jump to last rec}
  doLastRec(TZAbstractDataset(ztDocSOOutput));
end;

procedure TfrmDocSOOutput.onActInsert;
begin
  {set focus and insert new rec}
  dbCode.SetFocus;
  doInsertRec(TZAbstractDataset(ztDocSOOutput));
end;

procedure TfrmDocSOOutput.onActDelete;
begin
  {delete rec}
  doDeleteRec(TZAbstractDataset(ztDocSOOutput));
end;

procedure TfrmDocSOOutput.onActEdit;
begin
  {set focus and edit rec}
  dbCode.SetFocus;
  doEditRec(TZAbstractDataset(ztDocSOOutput));
end;

procedure TfrmDocSOOutput.onActSave;
begin
  {save rec}
  doSaveRec(TZAbstractDataset(ztDocSOOutput));
end;

procedure TfrmDocSOOutput.onActCancel;
begin
  {cancel rec}
  doCancelRec(TZAbstractDataset(ztDocSOOutput));
end;

procedure TfrmDocSOOutput.openDataSet;
begin
  TZAbstractDataset(ztDocSOOutput).DisableControls;
  TZAbstractDataset(ztDocSOOutput).Close;
  try
    TZAbstractDataset(ztDocSOOutput).Open;
    TZAbstractDataset(ztDocSOOutput).EnableControls;
  except
    on e : Exception do
    begin
      dModule.zdbh.Rollback;
      TZAbstractDataset(ztDocSOOutput).EnableControls;
      ShowMessage(e.Message);
    end;
  end;
end;

end.

