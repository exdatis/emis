unit uDocSell;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,
  ActnList, DbCtrls, DBGrids, uBaseDbForm, db, ZDataset, ZSequence,
  ZAbstractDataset, ZAbstractRODataset;

type

  { TfrmDocSell }

  TfrmDocSell = class(TbaseDbForm)
    dbCode: TDBEdit;
    dbgDocSell: TDBGrid;
    dbName: TDBEdit;
    dsDocSell: TDataSource;
    groupBoxEdit: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    zseqDocSell: TZSequence;
    ztDocSell: TZTable;
    ztDocSellDS_CODE: TStringField;
    ztDocSellDS_ID: TLongintField;
    ztDocSellDS_NAME: TStringField;
    procedure dbgDocSellMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure dbgDocSellTitleClick(Column: TColumn);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure ztDocSellAfterDelete(DataSet: TDataSet);
    procedure ztDocSellAfterOpen(DataSet: TDataSet);
    procedure ztDocSellAfterPost(DataSet: TDataSet);
    procedure ztDocSellAfterScroll(DataSet: TDataSet);
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
  frmDocSell: TfrmDocSell;
const
  {fields of tbl DocSell}
  FIELD_ID : String = 'DS_ID';
  FIELD_CODE : String = 'DS_CODE';
  FIELD_NAME : String = 'DS_NAME';
implementation
uses
  uDModule, uConfirm;
{$R *.lfm}

{ TfrmDocSell }

procedure TfrmDocSell.dbgDocSellMouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
begin
  {set cursor again}
  dbgDocSell.Cursor:= crHandPoint;
end;

procedure TfrmDocSell.dbgDocSellTitleClick(Column: TColumn);
var
  recCount, recNo : String;
  recMsg : String = '0 od 0'; {find again recNo}
begin
  {sort}
  sortDbGrid(TZAbstractDataset(ztDocSell), Column);
  {refresh after sort}
  dbgDocSell.Refresh;
  { find recNo}
  recCount:= IntToStr(TZAbstractDataset(ztDocSell).RecordCount);
  recNo:= IntToStr(TZAbstractDataset(ztDocSell).RecNo);
  {create recMsg}
  recMsg:= recNo + ' od ' + recCount;
  edtRecNo.Text:= recMsg;
end;

procedure TfrmDocSell.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  {check for unsaved changes}
  saveBeforeClose;
  inherited;
end;

procedure TfrmDocSell.ztDocSellAfterDelete(DataSet: TDataSet);
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

procedure TfrmDocSell.ztDocSellAfterOpen(DataSet: TDataSet);
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

procedure TfrmDocSell.ztDocSellAfterPost(DataSet: TDataSet);
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

procedure TfrmDocSell.ztDocSellAfterScroll(DataSet: TDataSet);
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

procedure TfrmDocSell.saveBeforeClose;
var
  newDlg : TdlgConfirm;
  confirmMsg : String = 'Postoje izmene koje nisu sačuvane!';
  saveAll : Boolean = False;
begin
  {set confirm msg}
  confirmMsg:= confirmMsg + #13#10;
  confirmMsg:= confirmMsg + 'Želite da sačuvamo izmene?';
  if(TZAbstractDataset(ztDocSell).State in [dsEdit, dsInsert]) then
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
    doSaveRec(TZAbstractDataset(ztDocSell)); {in this case just one dataSet}
end;

procedure TfrmDocSell.sortDbGrid(var dataSet: TZAbstractDataset; Column: TColumn
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

procedure TfrmDocSell.onActFirst;
begin
  {jump to first rec}
  doFirstRec(TZAbstractDataset(ztDocSell));
end;

procedure TfrmDocSell.onActPrior;
begin
  {jump to prior rec}
  doPriorRec(TZAbstractDataset(ztDocSell));
end;

procedure TfrmDocSell.onActNext;
begin
  {jump to next rec}
  doNextRec(TZAbstractDataset(ztDocSell));
end;

procedure TfrmDocSell.onActLast;
begin
  {jump to last rec}
  doLastRec(TZAbstractDataset(ztDocSell));
end;

procedure TfrmDocSell.onActInsert;
begin
  {set focus and insert new rec}
  dbCode.SetFocus;
  doInsertRec(TZAbstractDataset(ztDocSell));
end;

procedure TfrmDocSell.onActDelete;
begin
  {delete rec}
  doDeleteRec(TZAbstractDataset(ztDocSell));
end;

procedure TfrmDocSell.onActEdit;
begin
  {set focus and edit rec}
  dbCode.SetFocus;
  doEditRec(TZAbstractDataset(ztDocSell));
end;

procedure TfrmDocSell.onActSave;
begin
  {save rec}
  doSaveRec(TZAbstractDataset(ztDocSell));
end;

procedure TfrmDocSell.onActCancel;
begin
  {cancel rec}
  doCancelRec(TZAbstractDataset(ztDocSell));
end;

procedure TfrmDocSell.openDataSet;
begin
  TZAbstractDataset(ztDocSell).DisableControls;
  TZAbstractDataset(ztDocSell).Close;
  try
    TZAbstractDataset(ztDocSell).Open;
    TZAbstractDataset(ztDocSell).EnableControls;
  except
    on e : Exception do
    begin
      dModule.zdbh.Rollback;
      TZAbstractDataset(ztDocSell).EnableControls;
      ShowMessage(e.Message);
    end;
  end;
end;

end.

