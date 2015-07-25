unit uDocWarehouseIn;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,
  ActnList, DbCtrls, DBGrids, uBaseDbForm, db, ZDataset, ZSequence,
  ZAbstractRODataset, ZAbstractDataset;

type

  { TfrmDocWarehouseIn }

  TfrmDocWarehouseIn = class(TbaseDbForm)
    dbCode: TDBEdit;
    dbgDocWIn: TDBGrid;
    dbName: TDBEdit;
    dsDocWIn: TDataSource;
    groupBoxEdit: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    zseqDocWIn: TZSequence;
    ztDocWIn: TZTable;
    ztDocWInDWI_CODE: TStringField;
    ztDocWInDWI_ID: TLongintField;
    ztDocWInDWI_NAME: TStringField;
    procedure dbgDocWInMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure dbgDocWInTitleClick(Column: TColumn);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure ztDocWInAfterDelete(DataSet: TDataSet);
    procedure ztDocWInAfterOpen(DataSet: TDataSet);
    procedure ztDocWInAfterPost(DataSet: TDataSet);
    procedure ztDocWInAfterScroll(DataSet: TDataSet);
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
  frmDocWarehouseIn: TfrmDocWarehouseIn;
const
  {fields of tbl DocWareHouseIn}
  FIELD_ID : String = 'DWI_ID';
  FIELD_CODE : String = 'DWI_CODE';
  FIELD_NAME : String = 'DWI_NAME';
implementation
uses
  uDModule, uConfirm;
{$R *.lfm}

{ TfrmDocWarehouseIn }

procedure TfrmDocWarehouseIn.dbgDocWInMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
  {set cursor again}
  dbgDocWIn.Cursor:= crHandPoint;
end;

procedure TfrmDocWarehouseIn.dbgDocWInTitleClick(Column: TColumn);
var
  recCount, recNo : String;
  recMsg : String = '0 od 0'; {find again recNo}
begin
  {sort}
  sortDbGrid(TZAbstractDataset(ztDocWIn), Column);
  {refresh after sort}
  dbgDocWIn.Refresh;
  { find recNo}
  recCount:= IntToStr(TZAbstractDataset(ztDocWIn).RecordCount);
  recNo:= IntToStr(TZAbstractDataset(ztDocWIn).RecNo);
  {create recMsg}
  recMsg:= recNo + ' od ' + recCount;
  edtRecNo.Text:= recMsg;
end;

procedure TfrmDocWarehouseIn.FormClose(Sender: TObject;
  var CloseAction: TCloseAction);
begin
  {check for unsaved changes}
  saveBeforeClose;
  inherited;
end;

procedure TfrmDocWarehouseIn.ztDocWInAfterDelete(DataSet: TDataSet);
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

procedure TfrmDocWarehouseIn.ztDocWInAfterOpen(DataSet: TDataSet);
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

procedure TfrmDocWarehouseIn.ztDocWInAfterPost(DataSet: TDataSet);
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

procedure TfrmDocWarehouseIn.ztDocWInAfterScroll(DataSet: TDataSet);
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

procedure TfrmDocWarehouseIn.saveBeforeClose;
var
  newDlg : TdlgConfirm;
  confirmMsg : String = 'Postoje izmene koje nisu sačuvane!';
  saveAll : Boolean = False;
begin
  {set confirm msg}
  confirmMsg:= confirmMsg + #13#10;
  confirmMsg:= confirmMsg + 'Želite da sačuvamo izmene?';
  if(TZAbstractDataset(ztDocWIn).State in [dsEdit, dsInsert]) then
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
    doSaveRec(TZAbstractDataset(ztDocWIn)); {in this case just one dataSet}
end;

procedure TfrmDocWarehouseIn.sortDbGrid(var dataSet: TZAbstractDataset;
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

procedure TfrmDocWarehouseIn.onActFirst;
begin
  {jump to first rec}
  doFirstRec(TZAbstractDataset(ztDocWIn));
end;

procedure TfrmDocWarehouseIn.onActPrior;
begin
  {jump to prior rec}
  doPriorRec(TZAbstractDataset(ztDocWIn));
end;

procedure TfrmDocWarehouseIn.onActNext;
begin
  {jump to next rec}
  doNextRec(TZAbstractDataset(ztDocWIn));
end;

procedure TfrmDocWarehouseIn.onActLast;
begin
  {jump to last rec}
  doLastRec(TZAbstractDataset(ztDocWIn));
end;

procedure TfrmDocWarehouseIn.onActInsert;
begin
  {set focus and insert new rec}
  dbCode.SetFocus;
  doInsertRec(TZAbstractDataset(ztDocWIn));
end;

procedure TfrmDocWarehouseIn.onActDelete;
begin
  {delete rec}
  doDeleteRec(TZAbstractDataset(ztDocWIn));
end;

procedure TfrmDocWarehouseIn.onActEdit;
begin
  {set focus and edit rec}
  dbCode.SetFocus;
  doEditRec(TZAbstractDataset(ztDocWIn));
end;

procedure TfrmDocWarehouseIn.onActSave;
begin
  {save rec}
  doSaveRec(TZAbstractDataset(ztDocWIn));
end;

procedure TfrmDocWarehouseIn.onActCancel;
begin
  {cancel rec}
  doCancelRec(TZAbstractDataset(ztDocWIn));
end;

procedure TfrmDocWarehouseIn.openDataSet;
begin
  TZAbstractDataset(ztDocWIn).DisableControls;
  TZAbstractDataset(ztDocWIn).Close;
  try
    TZAbstractDataset(ztDocWIn).Open;
    TZAbstractDataset(ztDocWIn).EnableControls;
  except
    on e : Exception do
    begin
      dModule.zdbh.Rollback;
      TZAbstractDataset(ztDocWIn).EnableControls;
      ShowMessage(e.Message);
    end;
  end;
end;

end.

