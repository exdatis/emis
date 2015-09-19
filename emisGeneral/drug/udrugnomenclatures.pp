unit uDrugNomenclatures;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, ZDataset, ZSequence, Forms, Controls, Graphics,
  Dialogs, StdCtrls, ActnList, ExtCtrls, DbCtrls, DBGrids, uBaseDbForm, db,
  ZAbstractDataset;

type

  { TfrmDrugNomenclatures }

  TfrmDrugNomenclatures = class(TbaseDbForm)
    dbCode: TDBEdit;
    dbgDrugNomenclatures: TDBGrid;
    dbName: TDBEdit;
    dsDrugNomenclatures: TDataSource;
    edtLocate: TEdit;
    groupBoxEdit: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    panelSearch: TPanel;
    zseqDrugNomenclatures: TZSequence;
    ztDrugNomenclatures: TZTable;
    ztDrugNomenclaturesDN_CODE: TStringField;
    ztDrugNomenclaturesDN_ID: TLongintField;
    ztDrugNomenclaturesDN_NAME: TStringField;
    procedure dbgDrugNomenclaturesMouseMove(Sender: TObject;
      Shift: TShiftState; X, Y: Integer);
    procedure dbgDrugNomenclaturesTitleClick(Column: TColumn);
    procedure edtLocateEnter(Sender: TObject);
    procedure edtLocateExit(Sender: TObject);
    procedure edtLocateKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState
      );
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure ztDrugNomenclaturesAfterDelete(DataSet: TDataSet);
    procedure ztDrugNomenclaturesAfterOpen(DataSet: TDataSet);
    procedure ztDrugNomenclaturesAfterPost(DataSet: TDataSet);
    procedure ztDrugNomenclaturesAfterScroll(DataSet: TDataSet);
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
  frmDrugNomenclatures: TfrmDrugNomenclatures;
  {fields of tbl DocLab}
  FDN_ID : String = 'DN_ID';
  FDN_CODE : String = 'DN_CODE';
  FDN_NAME : String = 'DN_NAME';
implementation
uses
  uDModule, uConfirm;
{$R *.lfm}

{ TfrmDrugNomenclatures }

procedure TfrmDrugNomenclatures.dbgDrugNomenclaturesMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
  {set cursor again}
  dbgDrugNomenclatures.Cursor:= crHandPoint;
end;

procedure TfrmDrugNomenclatures.dbgDrugNomenclaturesTitleClick(Column: TColumn);
var
  recCount, recNo : String;
  recMsg : String = '0 od 0'; {find again recNo}
begin
  {sort}
  doSortDbGrid(TZAbstractDataset(ztDrugNomenclatures), Column);
  {refresh after sort}
  dbgDrugNomenclatures.Refresh;
  { find recNo}
  recCount:= IntToStr(TZAbstractDataset(ztDrugNomenclatures).RecordCount);
  recNo:= IntToStr(TZAbstractDataset(ztDrugNomenclatures).RecNo);
  {create recMsg}
  recMsg:= recNo + ' od ' + recCount;
  edtRecNo.Text:= recMsg;
end;

procedure TfrmDrugNomenclatures.edtLocateEnter(Sender: TObject);
begin
  {clear text and set font-color}
  edtLocate.Text:= '';
  edtLocate.Font.Color:= clBlack;
end;

procedure TfrmDrugNomenclatures.edtLocateExit(Sender: TObject);
begin
  {set text and font-color}
  edtLocate.Text:= 'Pronadji ...';
  edtLocate.Font.Color:= clGray;
end;

procedure TfrmDrugNomenclatures.edtLocateKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  {try to locate}
  if(not TZAbstractDataset(ztDrugNomenclatures).Locate(FDN_NAME, edtLocate.Text, [loCaseInsensitive, loPartialKey])) then
    begin
      Beep;
      edtLocate.SelectAll;
    end;
end;

procedure TfrmDrugNomenclatures.FormClose(Sender: TObject;
  var CloseAction: TCloseAction);
begin
  {check for unsaved changes}
  saveBeforeClose;
  inherited;
end;

procedure TfrmDrugNomenclatures.ztDrugNomenclaturesAfterDelete(DataSet: TDataSet
  );
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

procedure TfrmDrugNomenclatures.ztDrugNomenclaturesAfterOpen(DataSet: TDataSet);
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

procedure TfrmDrugNomenclatures.ztDrugNomenclaturesAfterPost(DataSet: TDataSet);
var
  {calc records(recNo and countRec)}
  recCount, recNo : String;
  recMsg : String = '0 od 0';
  currId : Longint = 0; {to find after refresh}
begin
  {upply updates}
  TZAbstractDataset(DataSet).ApplyUpdates;
  {rtefresh current row}
  currId:= TZAbstractDataset(DataSet).FieldByName(FDN_ID).AsInteger;
  TZAbstractDataset(DataSet).DisableControls;
  TZAbstractDataset(DataSet).Refresh;
  TZAbstractDataset(DataSet).Locate(FDN_ID, currId, []);
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

procedure TfrmDrugNomenclatures.ztDrugNomenclaturesAfterScroll(DataSet: TDataSet
  );
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

procedure TfrmDrugNomenclatures.saveBeforeClose;
var
  newDlg : TdlgConfirm;
  confirmMsg : String = 'Postoje izmene koje nisu sačuvane!';
  saveAll : Boolean = False;
begin
  {set confirm msg}
  confirmMsg:= confirmMsg + #13#10;
  confirmMsg:= confirmMsg + 'Želite da sačuvamo izmene?';
  if(TZAbstractDataset(ztDrugNomenclatures).State in [dsEdit, dsInsert]) then
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
    doSaveRec(TZAbstractDataset(ztDrugNomenclatures)); {in this case just one dataSet}
end;

procedure TfrmDrugNomenclatures.onActFirst;
begin
  {jump to first rec}
  doFirstRec(TZAbstractDataset(ztDrugNomenclatures));
end;

procedure TfrmDrugNomenclatures.onActPrior;
begin
  {jump to prior rec}
  doPriorRec(TZAbstractDataset(ztDrugNomenclatures));
end;

procedure TfrmDrugNomenclatures.onActNext;
begin
  {jump to next rec}
  doNextRec(TZAbstractDataset(ztDrugNomenclatures));
end;

procedure TfrmDrugNomenclatures.onActLast;
begin
  {jump to last rec}
  doLastRec(TZAbstractDataset(ztDrugNomenclatures));
end;

procedure TfrmDrugNomenclatures.onActInsert;
begin
  {set focus and insert new rec}
  dbCode.SetFocus;
  doInsertRec(TZAbstractDataset(ztDrugNomenclatures));
end;

procedure TfrmDrugNomenclatures.onActDelete;
begin
  {delete rec}
  doDeleteRec(TZAbstractDataset(ztDrugNomenclatures));
end;

procedure TfrmDrugNomenclatures.onActEdit;
begin
  {set focus and edit rec}
  dbCode.SetFocus;
  doEditRec(TZAbstractDataset(ztDrugNomenclatures));
end;

procedure TfrmDrugNomenclatures.onActSave;
begin
  {save rec}
  doSaveRec(TZAbstractDataset(ztDrugNomenclatures));
end;

procedure TfrmDrugNomenclatures.onActCancel;
begin
  {cancel rec}
  doCancelRec(TZAbstractDataset(ztDrugNomenclatures));
end;

procedure TfrmDrugNomenclatures.openDataSet;
begin
  TZAbstractDataset(ztDrugNomenclatures).DisableControls;
  TZAbstractDataset(ztDrugNomenclatures).Close;
  try
    TZAbstractDataset(ztDrugNomenclatures).Open;
    TZAbstractDataset(ztDrugNomenclatures).EnableControls;
  except
    on e : Exception do
    begin
      dModule.zdbh.Rollback;
      TZAbstractDataset(ztDrugNomenclatures).EnableControls;
      ShowMessage(e.Message);
    end;
  end;
end;

end.

