unit uDocMedicalInput;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,
  ActnList, DbCtrls, DBGrids, uBaseDbForm, db, ZDataset, ZSequence,
  ZAbstractDataset, ZAbstractRODataset;

type

  { TfrmDocMedicalInput }

  TfrmDocMedicalInput = class(TbaseDbForm)
    dbCode: TDBEdit;
    dbgDocMedicalInput: TDBGrid;
    dbName: TDBEdit;
    dsDocMedicalInput: TDataSource;
    groupBoxEdit: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    zseqDocMedicalInput: TZSequence;
    ztDocMedicalInput: TZTable;
    ztDocMedicalInputDMI_CODE: TStringField;
    ztDocMedicalInputDMI_ID: TLongintField;
    ztDocMedicalInputDMI_NAME: TStringField;
    procedure dbgDocMedicalInputMouseMove(Sender: TObject; Shift: TShiftState;
      X, Y: Integer);
    procedure dbgDocMedicalInputTitleClick(Column: TColumn);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure ztDocMedicalInputAfterDelete(DataSet: TDataSet);
    procedure ztDocMedicalInputAfterOpen(DataSet: TDataSet);
    procedure ztDocMedicalInputAfterPost(DataSet: TDataSet);
    procedure ztDocMedicalInputAfterScroll(DataSet: TDataSet);
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
  frmDocMedicalInput: TfrmDocMedicalInput;
const
  {fields of tbl DocMedicalInput}
  FIELD_ID : String = 'DMI_ID';
  FIELD_CODE : String = 'DMI_CODE';
  FIELD_NAME : String = 'DMI_NAME';
implementation
uses
  uDModule, uConfirm;
{$R *.lfm}

{ TfrmDocMedicalInput }

procedure TfrmDocMedicalInput.dbgDocMedicalInputMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
  {set cursor again}
  dbgDocMedicalInput.Cursor:= crHandPoint;
end;

procedure TfrmDocMedicalInput.dbgDocMedicalInputTitleClick(Column: TColumn);
var
  recCount, recNo : String;
  recMsg : String = '0 od 0'; {find again recNo}
begin
  {sort}
  sortDbGrid(TZAbstractDataset(ztDocMedicalInput), Column);
  {refresh after sort}
  dbgDocMedicalInput.Refresh;
  { find recNo}
  recCount:= IntToStr(TZAbstractDataset(ztDocMedicalInput).RecordCount);
  recNo:= IntToStr(TZAbstractDataset(ztDocMedicalInput).RecNo);
  {create recMsg}
  recMsg:= recNo + ' od ' + recCount;
  edtRecNo.Text:= recMsg;
end;

procedure TfrmDocMedicalInput.FormClose(Sender: TObject;
  var CloseAction: TCloseAction);
begin
  {check for unsaved changes}
  saveBeforeClose;
  inherited;
end;

procedure TfrmDocMedicalInput.ztDocMedicalInputAfterDelete(DataSet: TDataSet);
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

procedure TfrmDocMedicalInput.ztDocMedicalInputAfterOpen(DataSet: TDataSet);
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

procedure TfrmDocMedicalInput.ztDocMedicalInputAfterPost(DataSet: TDataSet);
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

procedure TfrmDocMedicalInput.ztDocMedicalInputAfterScroll(DataSet: TDataSet);
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

procedure TfrmDocMedicalInput.saveBeforeClose;
var
  newDlg : TdlgConfirm;
  confirmMsg : String = 'Postoje izmene koje nisu sačuvane!';
  saveAll : Boolean = False;
begin
  {set confirm msg}
  confirmMsg:= confirmMsg + #13#10;
  confirmMsg:= confirmMsg + 'Želite da sačuvamo izmene?';
  if(TZAbstractDataset(ztDocMedicalInput).State in [dsEdit, dsInsert]) then
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
    doSaveRec(TZAbstractDataset(ztDocMedicalInput)); {in this case just one dataSet}
end;

procedure TfrmDocMedicalInput.sortDbGrid(var dataSet: TZAbstractDataset;
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

procedure TfrmDocMedicalInput.onActFirst;
begin
  {jump to first rec}
  doFirstRec(TZAbstractDataset(ztDocMedicalInput));
end;

procedure TfrmDocMedicalInput.onActPrior;
begin
  {jump to prior rec}
  doPriorRec(TZAbstractDataset(ztDocMedicalInput));
end;

procedure TfrmDocMedicalInput.onActNext;
begin
  {jump to next rec}
  doNextRec(TZAbstractDataset(ztDocMedicalInput));
end;

procedure TfrmDocMedicalInput.onActLast;
begin
  {jump to last rec}
  doLastRec(TZAbstractDataset(ztDocMedicalInput));
end;

procedure TfrmDocMedicalInput.onActInsert;
begin
  {set focus and insert new rec}
  dbCode.SetFocus;
  doInsertRec(TZAbstractDataset(ztDocMedicalInput));
end;

procedure TfrmDocMedicalInput.onActDelete;
begin
  {delete rec}
  doDeleteRec(TZAbstractDataset(ztDocMedicalInput));
end;

procedure TfrmDocMedicalInput.onActEdit;
begin
  {set focus and edit rec}
  dbCode.SetFocus;
  doEditRec(TZAbstractDataset(ztDocMedicalInput));
end;

procedure TfrmDocMedicalInput.onActSave;
begin
  {save rec}
  doSaveRec(TZAbstractDataset(ztDocMedicalInput));
end;

procedure TfrmDocMedicalInput.onActCancel;
begin
  {cancel rec}
  doCancelRec(TZAbstractDataset(ztDocMedicalInput));
end;

procedure TfrmDocMedicalInput.openDataSet;
begin
  TZAbstractDataset(ztDocMedicalInput).DisableControls;
  TZAbstractDataset(ztDocMedicalInput).Close;
  try
    TZAbstractDataset(ztDocMedicalInput).Open;
    TZAbstractDataset(ztDocMedicalInput).EnableControls;
  except
    on e : Exception do
    begin
      dModule.zdbh.Rollback;
      TZAbstractDataset(ztDocMedicalInput).EnableControls;
      ShowMessage(e.Message);
    end;
  end;
end;

end.

