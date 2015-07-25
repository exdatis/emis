unit uDocBuying;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,
  ActnList, DbCtrls, DBGrids, uBaseDbForm, db, ZAbstractDataset,
  ZAbstractRODataset, ZDataset, ZSequence;

type

  { TfrmDocBuying }

  TfrmDocBuying = class(TbaseDbForm)
    dbCode: TDBEdit;
    dbgDocBuying: TDBGrid;
    dbName: TDBEdit;
    dsDocBuying: TDataSource;
    groupBoxEdit: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    zseqDocBuying: TZSequence;
    ztDocBuying: TZTable;
    ztDocBuyingDB_CODE: TStringField;
    ztDocBuyingDB_ID: TLongintField;
    ztDocBuyingDB_NAME: TStringField;
    procedure dbgDocBuyingMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure dbgDocBuyingTitleClick(Column: TColumn);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure ztDocBuyingAfterDelete(DataSet: TDataSet);
    procedure ztDocBuyingAfterOpen(DataSet: TDataSet);
    procedure ztDocBuyingAfterPost(DataSet: TDataSet);
    procedure ztDocBuyingAfterScroll(DataSet: TDataSet);
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
  frmDocBuying: TfrmDocBuying;
const
  {fields of tbl DocBuying}
  FIELD_ID : String = 'DB_ID';
  FIELD_CODE : String = 'DB_CODE';
  FIELD_NAME : String = 'DB_NAME';
implementation
uses
  uDModule, uConfirm;
{$R *.lfm}

{ TfrmDocBuying }

procedure TfrmDocBuying.dbgDocBuyingMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
  {set cursor again}
  dbgDocBuying.Cursor:= crHandPoint;
end;

procedure TfrmDocBuying.dbgDocBuyingTitleClick(Column: TColumn);
var
  recCount, recNo : String;
  recMsg : String = '0 od 0'; {find again recNo}
begin
  {sort}
  sortDbGrid(TZAbstractDataset(ztDocBuying), Column);
  {refresh after sort}
  dbgDocBuying.Refresh;
  { find recNo}
  recCount:= IntToStr(TZAbstractDataset(ztDocBuying).RecordCount);
  recNo:= IntToStr(TZAbstractDataset(ztDocBuying).RecNo);
  {create recMsg}
  recMsg:= recNo + ' od ' + recCount;
  edtRecNo.Text:= recMsg;
end;

procedure TfrmDocBuying.FormClose(Sender: TObject; var CloseAction: TCloseAction
  );
begin
  {check for unsaved changes}
  saveBeforeClose;
  inherited;
end;

procedure TfrmDocBuying.ztDocBuyingAfterDelete(DataSet: TDataSet);
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

procedure TfrmDocBuying.ztDocBuyingAfterOpen(DataSet: TDataSet);
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

procedure TfrmDocBuying.ztDocBuyingAfterPost(DataSet: TDataSet);
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

procedure TfrmDocBuying.ztDocBuyingAfterScroll(DataSet: TDataSet);
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

procedure TfrmDocBuying.saveBeforeClose;
var
  newDlg : TdlgConfirm;
  confirmMsg : String = 'Postoje izmene koje nisu sačuvane!';
  saveAll : Boolean = False;
begin
  {set confirm msg}
  confirmMsg:= confirmMsg + #13#10;
  confirmMsg:= confirmMsg + 'Želite da sačuvamo izmene?';
  if(TZAbstractDataset(ztDocBuying).State in [dsEdit, dsInsert]) then
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
    doSaveRec(TZAbstractDataset(ztDocBuying)); {in this case just one dataSet}
end;

procedure TfrmDocBuying.sortDbGrid(var dataSet: TZAbstractDataset;
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

procedure TfrmDocBuying.onActFirst;
begin
  {jump to first rec}
  doFirstRec(TZAbstractDataset(ztDocBuying));
end;

procedure TfrmDocBuying.onActPrior;
begin
  {jump to prior rec}
  doPriorRec(TZAbstractDataset(ztDocBuying));
end;

procedure TfrmDocBuying.onActNext;
begin
  {jump to next rec}
  doNextRec(TZAbstractDataset(ztDocBuying));
end;

procedure TfrmDocBuying.onActLast;
begin
  {jump to last rec}
  doLastRec(TZAbstractDataset(ztDocBuying));
end;

procedure TfrmDocBuying.onActInsert;
begin
  {set focus and insert new rec}
  dbCode.SetFocus;
  doInsertRec(TZAbstractDataset(ztDocBuying));
end;

procedure TfrmDocBuying.onActDelete;
begin
  {delete rec}
  doDeleteRec(TZAbstractDataset(ztDocBuying));
end;

procedure TfrmDocBuying.onActEdit;
begin
  {set focus and edit rec}
  dbCode.SetFocus;
  doEditRec(TZAbstractDataset(ztDocBuying));
end;

procedure TfrmDocBuying.onActSave;
begin
  {save rec}
  doSaveRec(TZAbstractDataset(ztDocBuying));
end;

procedure TfrmDocBuying.onActCancel;
begin
  {cancel rec}
  doCancelRec(TZAbstractDataset(ztDocBuying));
end;

procedure TfrmDocBuying.openDataSet;
begin
  TZAbstractDataset(ztDocBuying).DisableControls;
  TZAbstractDataset(ztDocBuying).Close;
  try
    TZAbstractDataset(ztDocBuying).Open;
    TZAbstractDataset(ztDocBuying).EnableControls;
  except
    on e : Exception do
    begin
      dModule.zdbh.Rollback;
      TZAbstractDataset(ztDocBuying).EnableControls;
      ShowMessage(e.Message);
    end;
  end;
end;

end.

