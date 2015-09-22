unit uGenerics;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, ZDataset, ZSequence, Forms, Controls, Graphics,
  Dialogs, StdCtrls, ActnList, ExtCtrls, DbCtrls, DBGrids, uBaseDbForm, db,
  ZAbstractDataset;

type

  { TfrmGenerics }

  TfrmGenerics = class(TbaseDbForm)
    dbgGenerics: TDBGrid;
    dsGenerics: TDataSource;
    dbCode: TDBEdit;
    dbName: TDBEdit;
    edtLocate: TEdit;
    groupBoxEdit: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    panelSearch: TPanel;
    zseqGenerics: TZSequence;
    ztGenerics: TZTable;
    ztGenericsG_CODE: TStringField;
    ztGenericsG_ID: TLongintField;
    ztGenericsG_NAME: TStringField;
    procedure dbgGenericsMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure dbgGenericsTitleClick(Column: TColumn);
    procedure edtLocateEnter(Sender: TObject);
    procedure edtLocateExit(Sender: TObject);
    procedure edtLocateKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState
      );
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure ztGenericsAfterDelete(DataSet: TDataSet);
    procedure ztGenericsAfterOpen(DataSet: TDataSet);
    procedure ztGenericsAfterPost(DataSet: TDataSet);
    procedure ztGenericsAfterScroll(DataSet: TDataSet);
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
  frmGenerics: TfrmGenerics;
const
  {fields of tbl generics}
  FG_ID : String = 'G_ID';
  FG_CODE : String = 'G_CODE';
  FG_NAME : String = 'G_NAME';
implementation
uses
  uDModule, uConfirm;
{$R *.lfm}

{ TfrmGenerics }

procedure TfrmGenerics.dbgGenericsMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
  {set cursor again}
  dbgGenerics.Cursor:= crHandPoint;
end;

procedure TfrmGenerics.dbgGenericsTitleClick(Column: TColumn);
var
  recCount, recNo : String;
  recMsg : String = '0 od 0'; {find again recNo}
begin
  {sort}
  doSortDbGrid(TZAbstractDataset(ztGenerics), Column);
  {refresh after sort}
  dbgGenerics.Refresh;
  { find recNo}
  recCount:= IntToStr(TZAbstractDataset(ztGenerics).RecordCount);
  recNo:= IntToStr(TZAbstractDataset(ztGenerics).RecNo);
  {create recMsg}
  recMsg:= recNo + ' od ' + recCount;
  edtRecNo.Text:= recMsg;
end;

procedure TfrmGenerics.edtLocateEnter(Sender: TObject);
begin
  {clear text and set font-color}
  edtLocate.Text:= '';
  edtLocate.Font.Color:= clBlack;
end;

procedure TfrmGenerics.edtLocateExit(Sender: TObject);
begin
  {set text and font-color}
  edtLocate.Text:= 'Pronadji ...';
  edtLocate.Font.Color:= clGray;
end;

procedure TfrmGenerics.edtLocateKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  {try to locate}
  if(not TZAbstractDataset(ztGenerics).Locate(FG_NAME, edtLocate.Text, [loCaseInsensitive, loPartialKey])) then
    begin
      Beep;
      edtLocate.SelectAll;
    end;
end;

procedure TfrmGenerics.FormClose(Sender: TObject; var CloseAction: TCloseAction
  );
begin
  {check for unsaved changes}
  saveBeforeClose;
  inherited;
end;

procedure TfrmGenerics.ztGenericsAfterDelete(DataSet: TDataSet);
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

procedure TfrmGenerics.ztGenericsAfterOpen(DataSet: TDataSet);
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

procedure TfrmGenerics.ztGenericsAfterPost(DataSet: TDataSet);
var
  {calc records(recNo and countRec)}
  recCount, recNo : String;
  recMsg : String = '0 od 0';
  currId : Longint = 0; {to find after refresh}
begin
  {upply updates}
  TZAbstractDataset(DataSet).ApplyUpdates;
  {rtefresh current row}
  currId:= TZAbstractDataset(DataSet).FieldByName(FG_ID).AsInteger;
  TZAbstractDataset(DataSet).DisableControls;
  TZAbstractDataset(DataSet).Refresh;
  TZAbstractDataset(DataSet).Locate(FG_ID, currId, []);
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

procedure TfrmGenerics.ztGenericsAfterScroll(DataSet: TDataSet);
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

procedure TfrmGenerics.saveBeforeClose;
var
  newDlg : TdlgConfirm;
  confirmMsg : String = 'Postoje izmene koje nisu sačuvane!';
  saveAll : Boolean = False;
begin
  {set confirm msg}
  confirmMsg:= confirmMsg + #13#10;
  confirmMsg:= confirmMsg + 'Želite da sačuvamo izmene?';
  if(TZAbstractDataset(ztGenerics).State in [dsEdit, dsInsert]) then
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
    doSaveRec(TZAbstractDataset(ztGenerics)); {in this case just one dataSet}
end;

procedure TfrmGenerics.onActFirst;
begin
  {jump to first rec}
  doFirstRec(TZAbstractDataset(ztGenerics));
end;

procedure TfrmGenerics.onActPrior;
begin
  {jump to prior rec}
  doPriorRec(TZAbstractDataset(ztGenerics));
end;

procedure TfrmGenerics.onActNext;
begin
  {jump to next rec}
  doNextRec(TZAbstractDataset(ztGenerics));
end;

procedure TfrmGenerics.onActLast;
begin
  {jump to last rec}
  doLastRec(TZAbstractDataset(ztGenerics));
end;

procedure TfrmGenerics.onActInsert;
begin
  {set focus and insert new rec}
  dbCode.SetFocus;
  doInsertRec(TZAbstractDataset(ztGenerics));
end;

procedure TfrmGenerics.onActDelete;
begin
  {delete rec}
  doDeleteRec(TZAbstractDataset(ztGenerics));
end;

procedure TfrmGenerics.onActEdit;
begin
  {set focus and edit rec}
  dbCode.SetFocus;
  doEditRec(TZAbstractDataset(ztGenerics));
end;

procedure TfrmGenerics.onActSave;
begin
  {save rec}
  doSaveRec(TZAbstractDataset(ztGenerics));
end;

procedure TfrmGenerics.onActCancel;
begin
  {cancel rec}
  doCancelRec(TZAbstractDataset(ztGenerics));
end;

procedure TfrmGenerics.openDataSet;
begin
  TZAbstractDataset(ztGenerics).DisableControls;
  TZAbstractDataset(ztGenerics).Close;
  try
    TZAbstractDataset(ztGenerics).Open;
    TZAbstractDataset(ztGenerics).EnableControls;
  except
    on e : Exception do
    begin
      dModule.zdbh.Rollback;
      TZAbstractDataset(ztGenerics).EnableControls;
      ShowMessage(e.Message);
    end;
  end;
end;

end.

