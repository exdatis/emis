unit uDocLab;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,
  ActnList, DbCtrls, DBGrids, uBaseDbForm, db, ZDataset, ZSequence,
  ZAbstractDataset;

type

  { TfrmDocLab }

  TfrmDocLab = class(TbaseDbForm)
    dbCode: TDBEdit;
    dbgDocLab: TDBGrid;
    dbName: TDBEdit;
    dsDocLab: TDataSource;
    groupBoxEdit: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    zseqDocLab: TZSequence;
    ztDocLab: TZTable;
    ztDocLabDL_CODE: TStringField;
    ztDocLabDL_ID: TLongintField;
    ztDocLabDL_NAME: TStringField;
    procedure dbgDocLabMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure dbgDocLabTitleClick(Column: TColumn);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure ztDocLabAfterDelete(DataSet: TDataSet);
    procedure ztDocLabAfterOpen(DataSet: TDataSet);
    procedure ztDocLabAfterPost(DataSet: TDataSet);
    procedure ztDocLabAfterScroll(DataSet: TDataSet);
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
  frmDocLab: TfrmDocLab;
const
  {fields of tbl DocLab}
  FIELD_ID : String = 'DL_ID';
  FIELD_CODE : String = 'DL_CODE';
  FIELD_NAME : String = 'DL_NAME';
implementation
uses
  uDModule, uConfirm;
{$R *.lfm}

{ TfrmDocLab }

procedure TfrmDocLab.dbgDocLabMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
  {set cursor again}
  dbgDocLab.Cursor:= crHandPoint;
end;

procedure TfrmDocLab.dbgDocLabTitleClick(Column: TColumn);
var
  recCount, recNo : String;
  recMsg : String = '0 od 0'; {find again recNo}
begin
  {sort}
  doSortDbGrid(TZAbstractDataset(ztDocLab), Column);
  {refresh after sort}
  dbgDocLab.Refresh;
  { find recNo}
  recCount:= IntToStr(TZAbstractDataset(ztDocLab).RecordCount);
  recNo:= IntToStr(TZAbstractDataset(ztDocLab).RecNo);
  {create recMsg}
  recMsg:= recNo + ' od ' + recCount;
  edtRecNo.Text:= recMsg;
end;

procedure TfrmDocLab.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  {check for unsaved changes}
  saveBeforeClose;
  inherited;
end;

procedure TfrmDocLab.ztDocLabAfterDelete(DataSet: TDataSet);
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

procedure TfrmDocLab.ztDocLabAfterOpen(DataSet: TDataSet);
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

procedure TfrmDocLab.ztDocLabAfterPost(DataSet: TDataSet);
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

procedure TfrmDocLab.ztDocLabAfterScroll(DataSet: TDataSet);
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

procedure TfrmDocLab.saveBeforeClose;
var
  newDlg : TdlgConfirm;
  confirmMsg : String = 'Postoje izmene koje nisu sačuvane!';
  saveAll : Boolean = False;
begin
  {set confirm msg}
  confirmMsg:= confirmMsg + #13#10;
  confirmMsg:= confirmMsg + 'Želite da sačuvamo izmene?';
  if(TZAbstractDataset(ztDocLab).State in [dsEdit, dsInsert]) then
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
    doSaveRec(TZAbstractDataset(ztDocLab)); {in this case just one dataSet}
end;

procedure TfrmDocLab.onActFirst;
begin
  {jump to first rec}
  doFirstRec(TZAbstractDataset(ztDocLab));
end;

procedure TfrmDocLab.onActPrior;
begin
  {jump to prior rec}
  doPriorRec(TZAbstractDataset(ztDocLab));
end;

procedure TfrmDocLab.onActNext;
begin
  {jump to next rec}
  doNextRec(TZAbstractDataset(ztDocLab));
end;

procedure TfrmDocLab.onActLast;
begin
  {jump to last rec}
  doLastRec(TZAbstractDataset(ztDocLab));
end;

procedure TfrmDocLab.onActInsert;
begin
  {set focus and insert new rec}
  dbCode.SetFocus;
  doInsertRec(TZAbstractDataset(ztDocLab));
end;

procedure TfrmDocLab.onActDelete;
begin
  {delete rec}
  doDeleteRec(TZAbstractDataset(ztDocLab));
end;

procedure TfrmDocLab.onActEdit;
begin
  {set focus and edit rec}
  dbCode.SetFocus;
  doEditRec(TZAbstractDataset(ztDocLab));
end;

procedure TfrmDocLab.onActSave;
begin
  {save rec}
  doSaveRec(TZAbstractDataset(ztDocLab));
end;

procedure TfrmDocLab.onActCancel;
begin
  {cancel rec}
  doCancelRec(TZAbstractDataset(ztDocLab));
end;

procedure TfrmDocLab.openDataSet;
begin
  TZAbstractDataset(ztDocLab).DisableControls;
  TZAbstractDataset(ztDocLab).Close;
  try
    TZAbstractDataset(ztDocLab).Open;
    TZAbstractDataset(ztDocLab).EnableControls;
  except
    on e : Exception do
    begin
      dModule.zdbh.Rollback;
      TZAbstractDataset(ztDocLab).EnableControls;
      ShowMessage(e.Message);
    end;
  end;
end;

end.

