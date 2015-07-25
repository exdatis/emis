unit uDocMedicalOutput;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,
  ActnList, DbCtrls, DBGrids, uBaseDbForm, db, ZDataset, ZSequence,
  ZAbstractDataset, ZAbstractRODataset;

type

  { TfrmDocMedicalOutput }

  TfrmDocMedicalOutput = class(TbaseDbForm)
    dbCode: TDBEdit;
    dbgDocMedicalOutput: TDBGrid;
    dbName: TDBEdit;
    dsDocMedicaloutput: TDataSource;
    groupBoxEdit: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    zseqDocMedicalOutput: TZSequence;
    ztDocMedicalOutput: TZTable;
    ztDocMedicalOutputDMO_CODE: TStringField;
    ztDocMedicalOutputDMO_ID: TLongintField;
    ztDocMedicalOutputDMO_NAME: TStringField;
    procedure dbgDocMedicalOutputMouseMove(Sender: TObject; Shift: TShiftState;
      X, Y: Integer);
    procedure dbgDocMedicalOutputTitleClick(Column: TColumn);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure ztDocMedicalOutputAfterDelete(DataSet: TDataSet);
    procedure ztDocMedicalOutputAfterOpen(DataSet: TDataSet);
    procedure ztDocMedicalOutputAfterPost(DataSet: TDataSet);
    procedure ztDocMedicalOutputAfterScroll(DataSet: TDataSet);
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
  frmDocMedicalOutput: TfrmDocMedicalOutput;
const
  {fields of tbl DocMedicalOutput}
  FIELD_ID : String = 'DMO_ID';
  FIELD_CODE : String = 'DMO_CODE';
  FIELD_NAME : String = 'DMO_NAME';
implementation
uses
  uDModule, uConfirm;
{$R *.lfm}

{ TfrmDocMedicalOutput }

procedure TfrmDocMedicalOutput.dbgDocMedicalOutputMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
  {set cursor again}
  dbgDocMedicalOutput.Cursor:= crHandPoint;
end;

procedure TfrmDocMedicalOutput.dbgDocMedicalOutputTitleClick(Column: TColumn);
var
  recCount, recNo : String;
  recMsg : String = '0 od 0'; {find again recNo}
begin
  {sort}
  sortDbGrid(TZAbstractDataset(ztDocMedicalOutput), Column);
  {refresh after sort}
  dbgDocMedicalOutput.Refresh;
  { find recNo}
  recCount:= IntToStr(TZAbstractDataset(ztDocMedicalOutput).RecordCount);
  recNo:= IntToStr(TZAbstractDataset(ztDocMedicalOutput).RecNo);
  {create recMsg}
  recMsg:= recNo + ' od ' + recCount;
  edtRecNo.Text:= recMsg;
end;

procedure TfrmDocMedicalOutput.FormClose(Sender: TObject;
  var CloseAction: TCloseAction);
begin
  {check for unsaved changes}
  saveBeforeClose;
  inherited;
end;

procedure TfrmDocMedicalOutput.ztDocMedicalOutputAfterDelete(DataSet: TDataSet);
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

procedure TfrmDocMedicalOutput.ztDocMedicalOutputAfterOpen(DataSet: TDataSet);
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

procedure TfrmDocMedicalOutput.ztDocMedicalOutputAfterPost(DataSet: TDataSet);
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

procedure TfrmDocMedicalOutput.ztDocMedicalOutputAfterScroll(DataSet: TDataSet);
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

procedure TfrmDocMedicalOutput.saveBeforeClose;
var
  newDlg : TdlgConfirm;
  confirmMsg : String = 'Postoje izmene koje nisu sačuvane!';
  saveAll : Boolean = False;
begin
  {set confirm msg}
  confirmMsg:= confirmMsg + #13#10;
  confirmMsg:= confirmMsg + 'Želite da sačuvamo izmene?';
  if(TZAbstractDataset(ztDocMedicalOutput).State in [dsEdit, dsInsert]) then
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
    doSaveRec(TZAbstractDataset(ztDocMedicalOutput)); {in this case just one dataSet}
end;

procedure TfrmDocMedicalOutput.sortDbGrid(var dataSet: TZAbstractDataset;
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

procedure TfrmDocMedicalOutput.onActFirst;
begin
  {jump to first rec}
  doFirstRec(TZAbstractDataset(ztDocMedicalOutput));
end;

procedure TfrmDocMedicalOutput.onActPrior;
begin
  {jump to prior rec}
  doPriorRec(TZAbstractDataset(ztDocMedicalOutput));
end;

procedure TfrmDocMedicalOutput.onActNext;
begin
  {jump to next rec}
  doNextRec(TZAbstractDataset(ztDocMedicalOutput));
end;

procedure TfrmDocMedicalOutput.onActLast;
begin
  {jump to last rec}
  doLastRec(TZAbstractDataset(ztDocMedicalOutput));
end;

procedure TfrmDocMedicalOutput.onActInsert;
begin
  {set focus and insert new rec}
  dbCode.SetFocus;
  doInsertRec(TZAbstractDataset(ztDocMedicalOutput));
end;

procedure TfrmDocMedicalOutput.onActDelete;
begin
  {delete rec}
  doDeleteRec(TZAbstractDataset(ztDocMedicalOutput));
end;

procedure TfrmDocMedicalOutput.onActEdit;
begin
  {set focus and edit rec}
  dbCode.SetFocus;
  doEditRec(TZAbstractDataset(ztDocMedicalOutput));
end;

procedure TfrmDocMedicalOutput.onActSave;
begin
  {save rec}
  doSaveRec(TZAbstractDataset(ztDocMedicalOutput));
end;

procedure TfrmDocMedicalOutput.onActCancel;
begin
  {cancel rec}
  doCancelRec(TZAbstractDataset(ztDocMedicalOutput));
end;

procedure TfrmDocMedicalOutput.openDataSet;
begin
  TZAbstractDataset(ztDocMedicalOutput).DisableControls;
  TZAbstractDataset(ztDocMedicalOutput).Close;
  try
    TZAbstractDataset(ztDocMedicalOutput).Open;
    TZAbstractDataset(ztDocMedicalOutput).EnableControls;
  except
    on e : Exception do
    begin
      dModule.zdbh.Rollback;
      TZAbstractDataset(ztDocMedicalOutput).EnableControls;
      ShowMessage(e.Message);
    end;
  end;
end;

end.

