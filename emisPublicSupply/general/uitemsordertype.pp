unit uItemsOrderType;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, ZDataset, ZSequence, Forms, Controls, Graphics,
  Dialogs, StdCtrls, ActnList, ExtCtrls, DbCtrls, DBGrids, uBaseDbForm, db,
  ZAbstractDataset;

type

  { TfrmItemsOrderType }

  TfrmItemsOrderType = class(TbaseDbForm)
    dbCode: TDBEdit;
    dbgIOT: TDBGrid;
    dbName: TDBEdit;
    dsType: TDataSource;
    edtLocate: TEdit;
    groupBoxEdit: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    panelSearch: TPanel;
    zseqType: TZSequence;
    ztType: TZTable;
    ztTypeIOT_CODE: TStringField;
    ztTypeIOT_ID: TLongintField;
    ztTypeIOT_NAME: TStringField;
    procedure dbgIOTMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer
      );
    procedure dbgIOTTitleClick(Column: TColumn);
    procedure edtLocateEnter(Sender: TObject);
    procedure edtLocateExit(Sender: TObject);
    procedure edtLocateKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState
      );
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure ztTypeAfterDelete(DataSet: TDataSet);
    procedure ztTypeAfterOpen(DataSet: TDataSet);
    procedure ztTypeAfterPost(DataSet: TDataSet);
    procedure ztTypeAfterScroll(DataSet: TDataSet);
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
  frmItemsOrderType: TfrmItemsOrderType;
const
  {fields of tbl itemsOrderType (F_ = field)}
  F_ID : String = 'IOT_ID';
  F_CODE : String = 'IOT_CODE';
  F_NAME : String = 'IOT_NAME';
implementation
uses
  uDModule, uConfirm;
{$R *.lfm}

{ TfrmItemsOrderType }

procedure TfrmItemsOrderType.dbgIOTMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
  {set cursor again}
  dbgIOT.Cursor:= crHandPoint;
end;

procedure TfrmItemsOrderType.dbgIOTTitleClick(Column: TColumn);
var
  recCount, recNo : String;
  recMsg : String = '0 od 0'; {find again recNo}
begin
  {sort}
  doSortDbGrid(TZAbstractDataset(ztType), Column);
  {refresh after sort}
  dbgIOT.Refresh;
  { find recNo}
  recCount:= IntToStr(TZAbstractDataset(ztType).RecordCount);
  recNo:= IntToStr(TZAbstractDataset(ztType).RecNo);
  {create recMsg}
  recMsg:= recNo + ' od ' + recCount;
  edtRecNo.Text:= recMsg;
end;

procedure TfrmItemsOrderType.edtLocateEnter(Sender: TObject);
begin
  {clear text and set font-color}
  edtLocate.Text:= '';
  edtLocate.Font.Color:= clBlack;
end;

procedure TfrmItemsOrderType.edtLocateExit(Sender: TObject);
begin
  {set text and font-color}
  edtLocate.Text:= 'Pronadji ...';
  edtLocate.Font.Color:= clGray;
end;

procedure TfrmItemsOrderType.edtLocateKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  {try to locate}
  if(not TZAbstractDataset(ztType).Locate(F_NAME, edtLocate.Text, [loCaseInsensitive, loPartialKey])) then
    begin
      Beep;
      edtLocate.SelectAll;
    end;
end;

procedure TfrmItemsOrderType.FormClose(Sender: TObject;
  var CloseAction: TCloseAction);
begin
  {check for unsaved changes}
  saveBeforeClose;
  inherited;
end;

procedure TfrmItemsOrderType.ztTypeAfterDelete(DataSet: TDataSet);
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

procedure TfrmItemsOrderType.ztTypeAfterOpen(DataSet: TDataSet);
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

procedure TfrmItemsOrderType.ztTypeAfterPost(DataSet: TDataSet);
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

procedure TfrmItemsOrderType.ztTypeAfterScroll(DataSet: TDataSet);
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

procedure TfrmItemsOrderType.saveBeforeClose;
var
  newDlg : TdlgConfirm;
  confirmMsg : String = 'Postoje izmene koje nisu sačuvane!';
  saveAll : Boolean = False;
begin
  {set confirm msg}
  confirmMsg:= confirmMsg + #13#10;
  confirmMsg:= confirmMsg + 'Želite da sačuvamo izmene?';
  if(TZAbstractDataset(ztType).State in [dsEdit, dsInsert]) then
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
    doSaveRec(TZAbstractDataset(ztType)); {in this case just one dataSet}
end;

procedure TfrmItemsOrderType.onActFirst;
begin
  {jump to first rec}
  doFirstRec(TZAbstractDataset(ztType));
end;

procedure TfrmItemsOrderType.onActPrior;
begin
  {jump to prior rec}
  doPriorRec(TZAbstractDataset(ztType));
end;

procedure TfrmItemsOrderType.onActNext;
begin
  {jump to next rec}
  doNextRec(TZAbstractDataset(ztType));
end;

procedure TfrmItemsOrderType.onActLast;
begin
  {jump to last rec}
  doLastRec(TZAbstractDataset(ztType));
end;

procedure TfrmItemsOrderType.onActInsert;
begin
  {set focus and insert new rec}
  dbCode.SetFocus;
  doInsertRec(TZAbstractDataset(ztType));
end;

procedure TfrmItemsOrderType.onActDelete;
begin
  {delete rec}
  doDeleteRec(TZAbstractDataset(ztType));
end;

procedure TfrmItemsOrderType.onActEdit;
begin
  {set focus and edit rec}
  dbCode.SetFocus;
  doEditRec(TZAbstractDataset(ztType));
end;

procedure TfrmItemsOrderType.onActSave;
begin
  {save rec}
  doSaveRec(TZAbstractDataset(ztType));
end;

procedure TfrmItemsOrderType.onActCancel;
begin
  {cancel rec}
  doCancelRec(TZAbstractDataset(ztType));
end;

procedure TfrmItemsOrderType.openDataSet;
begin
  TZAbstractDataset(ztType).DisableControls;
  TZAbstractDataset(ztType).Close;
  try
    TZAbstractDataset(ztType).Open;
    TZAbstractDataset(ztType).EnableControls;
  except
    on e : Exception do
    begin
      dModule.zdbh.Rollback;
      TZAbstractDataset(ztType).EnableControls;
      ShowMessage(e.Message);
    end;
  end;
end;

end.

