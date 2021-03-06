unit uSupplyType;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, ZDataset, ZSequence, Forms, Controls, Graphics,
  Dialogs, StdCtrls, ActnList, ExtCtrls, DbCtrls, DBGrids, uBaseDbForm, db,
  ZAbstractDataset;

type

  { TfrmSupplyType }

  TfrmSupplyType = class(TbaseDbForm)
    dbCode: TDBEdit;
    dbgST: TDBGrid;
    dbName: TDBEdit;
    dsSupplyType: TDataSource;
    edtLocate: TEdit;
    groupBoxEdit: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    panelSearch: TPanel;
    zseqSupplyType: TZSequence;
    ztSupplyType: TZTable;
    ztSupplyTypeST_CODE: TStringField;
    ztSupplyTypeST_ID: TLongintField;
    ztSupplyTypeST_NAME: TStringField;
    procedure dbgSTMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer
      );
    procedure dbgSTTitleClick(Column: TColumn);
    procedure edtLocateEnter(Sender: TObject);
    procedure edtLocateExit(Sender: TObject);
    procedure edtLocateKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState
      );
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure ztSupplyTypeAfterDelete(DataSet: TDataSet);
    procedure ztSupplyTypeAfterOpen(DataSet: TDataSet);
    procedure ztSupplyTypeAfterPost(DataSet: TDataSet);
    procedure ztSupplyTypeAfterScroll(DataSet: TDataSet);
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
  frmSupplyType: TfrmSupplyType;
const
  {fields of tbl supplyType (F_ = field)}
  F_ID : String = 'ST_ID';
  F_CODE : String = 'ST_CODE';
  F_NAME : String = 'ST_NAME';
implementation
uses
  uDModule, uConfirm;
{$R *.lfm}

{ TfrmSupplyType }

procedure TfrmSupplyType.dbgSTMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
  {set cursor again}
  dbgST.Cursor:= crHandPoint;
end;

procedure TfrmSupplyType.dbgSTTitleClick(Column: TColumn);
var
  recCount, recNo : String;
  recMsg : String = '0 od 0'; {find again recNo}
begin
  {sort}
  doSortDbGrid(TZAbstractDataset(ztSupplyType), Column);
  {refresh after sort}
  dbgST.Refresh;
  { find recNo}
  recCount:= IntToStr(TZAbstractDataset(ztSupplyType).RecordCount);
  recNo:= IntToStr(TZAbstractDataset(ztSupplyType).RecNo);
  {create recMsg}
  recMsg:= recNo + ' od ' + recCount;
  edtRecNo.Text:= recMsg;
end;

procedure TfrmSupplyType.edtLocateEnter(Sender: TObject);
begin
  {clear text and set font-color}
  edtLocate.Text:= '';
  edtLocate.Font.Color:= clBlack;
end;

procedure TfrmSupplyType.edtLocateExit(Sender: TObject);
begin
  {set text and font-color}
  edtLocate.Text:= 'Pronadji ...';
  edtLocate.Font.Color:= clGray;
end;

procedure TfrmSupplyType.edtLocateKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  {try to locate}
  if(not TZAbstractDataset(ztSupplyType).Locate(F_NAME, edtLocate.Text, [loCaseInsensitive, loPartialKey])) then
    begin
      Beep;
      edtLocate.SelectAll;
    end;
end;

procedure TfrmSupplyType.FormClose(Sender: TObject;
  var CloseAction: TCloseAction);
begin
  {check for unsaved changes}
  saveBeforeClose;
  inherited;
end;

procedure TfrmSupplyType.ztSupplyTypeAfterDelete(DataSet: TDataSet);
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

procedure TfrmSupplyType.ztSupplyTypeAfterOpen(DataSet: TDataSet);
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

procedure TfrmSupplyType.ztSupplyTypeAfterPost(DataSet: TDataSet);
var
  {calc records(recNo and countRec)}
  recCount, recNo : String;
  recMsg : String = '0 od 0';
  currId : Longint = 0; {to find after refresh}
begin
  {upply updates}
  TZAbstractDataset(DataSet).ApplyUpdates;
  {rtefresh current row}
  currId:= TZAbstractDataset(DataSet).FieldByName(F_ID).AsInteger;
  TZAbstractDataset(DataSet).DisableControls;
  TZAbstractDataset(DataSet).Refresh;
  TZAbstractDataset(DataSet).Locate(F_ID, currId, []);
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

procedure TfrmSupplyType.ztSupplyTypeAfterScroll(DataSet: TDataSet);
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

procedure TfrmSupplyType.saveBeforeClose;
var
  newDlg : TdlgConfirm;
  confirmMsg : String = 'Postoje izmene koje nisu sačuvane!';
  saveAll : Boolean = False;
begin
  {set confirm msg}
  confirmMsg:= confirmMsg + #13#10;
  confirmMsg:= confirmMsg + 'Želite da sačuvamo izmene?';
  if(TZAbstractDataset(ztSupplyType).State in [dsEdit, dsInsert]) then
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
    doSaveRec(TZAbstractDataset(ztSupplyType)); {in this case just one dataSet}
end;

procedure TfrmSupplyType.onActFirst;
begin
  {jump to first rec}
  doFirstRec(TZAbstractDataset(ztSupplyType));
end;

procedure TfrmSupplyType.onActPrior;
begin
  {jump to prior rec}
  doPriorRec(TZAbstractDataset(ztSupplyType));
end;

procedure TfrmSupplyType.onActNext;
begin
  {jump to next rec}
  doNextRec(TZAbstractDataset(ztSupplyType));
end;

procedure TfrmSupplyType.onActLast;
begin
  {jump to last rec}
  doLastRec(TZAbstractDataset(ztSupplyType));
end;

procedure TfrmSupplyType.onActInsert;
begin
  {set focus and insert new rec}
  dbCode.SetFocus;
  doInsertRec(TZAbstractDataset(ztSupplyType));
end;

procedure TfrmSupplyType.onActDelete;
begin
  {delete rec}
  doDeleteRec(TZAbstractDataset(ztSupplyType));
end;

procedure TfrmSupplyType.onActEdit;
begin
  {set focus and edit rec}
  dbCode.SetFocus;
  doEditRec(TZAbstractDataset(ztSupplyType));
end;

procedure TfrmSupplyType.onActSave;
begin
  {save rec}
  doSaveRec(TZAbstractDataset(ztSupplyType));
end;

procedure TfrmSupplyType.onActCancel;
begin
  {cancel rec}
  doCancelRec(TZAbstractDataset(ztSupplyType));
end;

procedure TfrmSupplyType.openDataSet;
begin
  TZAbstractDataset(ztSupplyType).DisableControls;
  TZAbstractDataset(ztSupplyType).Close;
  try
    TZAbstractDataset(ztSupplyType).Open;
    TZAbstractDataset(ztSupplyType).EnableControls;
  except
    on e : Exception do
    begin
      dModule.zdbh.Rollback;
      TZAbstractDataset(ztSupplyType).EnableControls;
      ShowMessage(e.Message);
    end;
  end;
end;

end.

