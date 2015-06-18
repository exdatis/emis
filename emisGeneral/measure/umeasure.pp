unit uMeasure;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,
  ActnList, DbCtrls, DBGrids, uBaseDbForm, db, ZDataset, ZSequence,
  ZAbstractDataset, ZAbstractRODataset;

type

  { TfrmMeasure }

  TfrmMeasure = class(TbaseDbForm)
    dbCode: TDBEdit;
    dbgMeasure: TDBGrid;
    dbName: TDBEdit;
    dsMeasure: TDataSource;
    groupBoxEdit: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    zseqMeasure: TZSequence;
    ztMeasure: TZTable;
    ztMeasureM_CODE: TStringField;
    ztMeasureM_ID: TLongintField;
    ztMeasureM_NAME: TStringField;
    procedure dbgMeasureMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure dbgMeasureTitleClick(Column: TColumn);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure ztMeasureAfterDelete(DataSet: TDataSet);
    procedure ztMeasureAfterOpen(DataSet: TDataSet);
    procedure ztMeasureAfterPost(DataSet: TDataSet);
    procedure ztMeasureAfterScroll(DataSet: TDataSet);
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
  frmMeasure: TfrmMeasure;
const
  {fields of tbl Measure}
  FIELD_ID : String = 'M_ID';
  FIELD_CODE : String = 'M_CODE';
  FIELD_NAME : String = 'M_NAME';
implementation
uses
  uDModule, uConfirm;
{$R *.lfm}

{ TfrmMeasure }

procedure TfrmMeasure.dbgMeasureMouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
begin
  {set cursor again}
  dbgMeasure.Cursor:= crHandPoint;
end;

procedure TfrmMeasure.dbgMeasureTitleClick(Column: TColumn);
var
  recCount, recNo : String;
  recMsg : String = '0 od 0'; {find again recNo}
begin
  {sort}
  sortDbGrid(TZAbstractDataset(ztMeasure), Column);
  {refresh after sort}
  dbgMeasure.Refresh;
  { find recNo}
  recCount:= IntToStr(TZAbstractDataset(ztMeasure).RecordCount);
  recNo:= IntToStr(TZAbstractDataset(ztMeasure).RecNo);
  {create recMsg}
  recMsg:= recNo + ' od ' + recCount;
  edtRecNo.Text:= recMsg;
end;

procedure TfrmMeasure.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  {check for unsaved changes}
  saveBeforeClose;
  inherited;
end;

procedure TfrmMeasure.ztMeasureAfterDelete(DataSet: TDataSet);
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

procedure TfrmMeasure.ztMeasureAfterOpen(DataSet: TDataSet);
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

procedure TfrmMeasure.ztMeasureAfterPost(DataSet: TDataSet);
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

procedure TfrmMeasure.ztMeasureAfterScroll(DataSet: TDataSet);
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

procedure TfrmMeasure.saveBeforeClose;
var
  newDlg : TdlgConfirm;
  confirmMsg : String = 'Postoje izmene koje nisu sačuvane!';
  saveAll : Boolean = False;
begin
  {set confirm msg}
  confirmMsg:= confirmMsg + #13#10;
  confirmMsg:= confirmMsg + 'Želite da sačuvamo izmene?';
  if(TZAbstractDataset(ztMeasure).State in [dsEdit, dsInsert]) then
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
    doSaveRec(TZAbstractDataset(ztMeasure)); {in this case just one dataSet}
end;

procedure TfrmMeasure.sortDbGrid(var dataSet: TZAbstractDataset; Column: TColumn
  );
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

procedure TfrmMeasure.onActFirst;
begin
  {jump to first rec}
  doFirstRec(TZAbstractDataset(ztMeasure));
end;

procedure TfrmMeasure.onActPrior;
begin
  {jump to prior rec}
  doPriorRec(TZAbstractDataset(ztMeasure));
end;

procedure TfrmMeasure.onActNext;
begin
  {jump to next rec}
  doNextRec(TZAbstractDataset(ztMeasure));
end;

procedure TfrmMeasure.onActLast;
begin
  {jump to last rec}
  doLastRec(TZAbstractDataset(ztMeasure));
end;

procedure TfrmMeasure.onActInsert;
begin
  {set focus and insert new rec}
  dbCode.SetFocus;
  doInsertRec(TZAbstractDataset(ztMeasure));
end;

procedure TfrmMeasure.onActDelete;
begin
  {delete rec}
  doDeleteRec(TZAbstractDataset(ztMeasure));
end;

procedure TfrmMeasure.onActEdit;
begin
  {set focus and edit rec}
  dbCode.SetFocus;
  doEditRec(TZAbstractDataset(ztMeasure));
end;

procedure TfrmMeasure.onActSave;
begin
  {save rec}
  doSaveRec(TZAbstractDataset(ztMeasure));
end;

procedure TfrmMeasure.onActCancel;
begin
  {cancel rec}
  doCancelRec(TZAbstractDataset(ztMeasure));
end;

procedure TfrmMeasure.openDataSet;
begin
  TZAbstractDataset(ztMeasure).DisableControls;
  TZAbstractDataset(ztMeasure).Close;
  try
    TZAbstractDataset(ztMeasure).Open;
    TZAbstractDataset(ztMeasure).EnableControls;
  except
    on e : Exception do
    begin
      dModule.zdbh.Rollback;
      TZAbstractDataset(ztMeasure).EnableControls;
      ShowMessage(e.Message);
    end;
  end;
end;

end.

