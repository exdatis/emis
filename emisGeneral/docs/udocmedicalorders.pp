unit uDocMedicalOrders;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,
  ActnList, DbCtrls, DBGrids, uBaseDbForm, db, ZDataset, ZSequence,
  ZAbstractDataset, ZAbstractRODataset;

type

  { TfrmDocMedicalOrders }

  TfrmDocMedicalOrders = class(TbaseDbForm)
    dbCode: TDBEdit;
    dbgDocMedicalOrders: TDBGrid;
    dbName: TDBEdit;
    dsDocMedicalOrders: TDataSource;
    groupBoxEdit: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    zseqDocMedicalOrders: TZSequence;
    ztDocMedicalOrders: TZTable;
    ztDocMedicalOrdersDMO_CODE: TStringField;
    ztDocMedicalOrdersDMO_ID: TLongintField;
    ztDocMedicalOrdersDMO_NAME: TStringField;
    procedure dbgDocMedicalOrdersMouseMove(Sender: TObject; Shift: TShiftState;
      X, Y: Integer);
    procedure dbgDocMedicalOrdersTitleClick(Column: TColumn);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure ztDocMedicalOrdersAfterDelete(DataSet: TDataSet);
    procedure ztDocMedicalOrdersAfterOpen(DataSet: TDataSet);
    procedure ztDocMedicalOrdersAfterPost(DataSet: TDataSet);
    procedure ztDocMedicalOrdersAfterScroll(DataSet: TDataSet);
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
  frmDocMedicalOrders: TfrmDocMedicalOrders;
const
  {fields of tbl DocMedicalOrders}
  FIELD_ID : String = 'DMO_ID';
  FIELD_CODE : String = 'DMO_CODE';
  FIELD_NAME : String = 'DMO_NAME';
implementation
uses
  uDModule, uConfirm;
{$R *.lfm}

{ TfrmDocMedicalOrders }

procedure TfrmDocMedicalOrders.dbgDocMedicalOrdersMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
  {set cursor again}
  dbgDocMedicalOrders.Cursor:= crHandPoint;
end;

procedure TfrmDocMedicalOrders.dbgDocMedicalOrdersTitleClick(Column: TColumn);
var
  recCount, recNo : String;
  recMsg : String = '0 od 0'; {find again recNo}
begin
  {sort}
  sortDbGrid(TZAbstractDataset(ztDocMedicalOrders), Column);
  {refresh after sort}
  dbgDocMedicalOrders.Refresh;
  { find recNo}
  recCount:= IntToStr(TZAbstractDataset(ztDocMedicalOrders).RecordCount);
  recNo:= IntToStr(TZAbstractDataset(ztDocMedicalOrders).RecNo);
  {create recMsg}
  recMsg:= recNo + ' od ' + recCount;
  edtRecNo.Text:= recMsg;
end;

procedure TfrmDocMedicalOrders.FormClose(Sender: TObject;
  var CloseAction: TCloseAction);
begin
  {check for unsaved changes}
  saveBeforeClose;
  inherited;
end;

procedure TfrmDocMedicalOrders.ztDocMedicalOrdersAfterDelete(DataSet: TDataSet);
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

procedure TfrmDocMedicalOrders.ztDocMedicalOrdersAfterOpen(DataSet: TDataSet);
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

procedure TfrmDocMedicalOrders.ztDocMedicalOrdersAfterPost(DataSet: TDataSet);
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

procedure TfrmDocMedicalOrders.ztDocMedicalOrdersAfterScroll(DataSet: TDataSet);
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

procedure TfrmDocMedicalOrders.saveBeforeClose;
var
  newDlg : TdlgConfirm;
  confirmMsg : String = 'Postoje izmene koje nisu sačuvane!';
  saveAll : Boolean = False;
begin
  {set confirm msg}
  confirmMsg:= confirmMsg + #13#10;
  confirmMsg:= confirmMsg + 'Želite da sačuvamo izmene?';
  if(TZAbstractDataset(ztDocMedicalOrders).State in [dsEdit, dsInsert]) then
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
    doSaveRec(TZAbstractDataset(ztDocMedicalOrders)); {in this case just one dataSet}
end;

procedure TfrmDocMedicalOrders.sortDbGrid(var dataSet: TZAbstractDataset;
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

procedure TfrmDocMedicalOrders.onActFirst;
begin
  {jump to first rec}
  doFirstRec(TZAbstractDataset(ztDocMedicalOrders));
end;

procedure TfrmDocMedicalOrders.onActPrior;
begin
  {jump to prior rec}
  doPriorRec(TZAbstractDataset(ztDocMedicalOrders));
end;

procedure TfrmDocMedicalOrders.onActNext;
begin
  {jump to next rec}
  doNextRec(TZAbstractDataset(ztDocMedicalOrders));
end;

procedure TfrmDocMedicalOrders.onActLast;
begin
  {jump to last rec}
  doLastRec(TZAbstractDataset(ztDocMedicalOrders));
end;

procedure TfrmDocMedicalOrders.onActInsert;
begin
  {set focus and insert new rec}
  dbCode.SetFocus;
  doInsertRec(TZAbstractDataset(ztDocMedicalOrders));
end;

procedure TfrmDocMedicalOrders.onActDelete;
begin
  {delete rec}
  doDeleteRec(TZAbstractDataset(ztDocMedicalOrders));
end;

procedure TfrmDocMedicalOrders.onActEdit;
begin
  {set focus and edit rec}
  dbCode.SetFocus;
  doEditRec(TZAbstractDataset(ztDocMedicalOrders));
end;

procedure TfrmDocMedicalOrders.onActSave;
begin
  {save rec}
  doSaveRec(TZAbstractDataset(ztDocMedicalOrders));
end;

procedure TfrmDocMedicalOrders.onActCancel;
begin
  {cancel rec}
  doCancelRec(TZAbstractDataset(ztDocMedicalOrders));
end;

procedure TfrmDocMedicalOrders.openDataSet;
begin
  TZAbstractDataset(ztDocMedicalOrders).DisableControls;
  TZAbstractDataset(ztDocMedicalOrders).Close;
  try
    TZAbstractDataset(ztDocMedicalOrders).Open;
    TZAbstractDataset(ztDocMedicalOrders).EnableControls;
  except
    on e : Exception do
    begin
      dModule.zdbh.Rollback;
      TZAbstractDataset(ztDocMedicalOrders).EnableControls;
      ShowMessage(e.Message);
    end;
  end;
end;

end.

