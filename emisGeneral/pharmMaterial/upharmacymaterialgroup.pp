unit uPharmacyMaterialGroup;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, ZDataset, ZSequence, Forms, Controls, Graphics,
  Dialogs, StdCtrls, ActnList, ExtCtrls, DbCtrls, DBGrids, uBaseDbForm, db,
  ZAbstractDataset;

type

  { TfrmPharmacyMaterialGroup }

  TfrmPharmacyMaterialGroup = class(TbaseDbForm)
    dbCode: TDBEdit;
    dbgGroups: TDBGrid;
    dbName: TDBEdit;
    dsPMaterialGroup: TDataSource;
    edtLocate: TEdit;
    groupBoxEdit: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    panelSearch: TPanel;
    zseqGroup: TZSequence;
    ztPMaterialGroup: TZTable;
    ztPMaterialGroupPMG_CODE: TStringField;
    ztPMaterialGroupPMG_ID: TLongintField;
    ztPMaterialGroupPMG_NAME: TStringField;
    procedure dbgGroupsMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure dbgGroupsTitleClick(Column: TColumn);
    procedure edtLocateEnter(Sender: TObject);
    procedure edtLocateExit(Sender: TObject);
    procedure edtLocateKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState
      );
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure ztPMaterialGroupAfterDelete(DataSet: TDataSet);
    procedure ztPMaterialGroupAfterOpen(DataSet: TDataSet);
    procedure ztPMaterialGroupAfterPost(DataSet: TDataSet);
    procedure ztPMaterialGroupAfterScroll(DataSet: TDataSet);
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
  frmPharmacyMaterialGroup: TfrmPharmacyMaterialGroup;
const
  {fields of tbl pharmacy_material_groups}
  FG_ID : String = 'PMG_ID';
  FG_CODE : String = 'PMG_CODE';
  FG_NAME : String = 'PMG_NAME';
implementation
uses
  uDModule, uConfirm;
{$R *.lfm}

{ TfrmPharmacyMaterialGroup }

procedure TfrmPharmacyMaterialGroup.dbgGroupsMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
  {set cursor again}
  dbgGroups.Cursor:= crHandPoint;
end;

procedure TfrmPharmacyMaterialGroup.dbgGroupsTitleClick(Column: TColumn);
var
  recCount, recNo : String;
  recMsg : String = '0 od 0'; {find again recNo}
begin
  {sort}
  doSortDbGrid(TZAbstractDataset(ztPMaterialGroup), Column);
  {refresh after sort}
  dbgGroups.Refresh;
  { find recNo}
  recCount:= IntToStr(TZAbstractDataset(ztPMaterialGroup).RecordCount);
  recNo:= IntToStr(TZAbstractDataset(ztPMaterialGroup).RecNo);
  {create recMsg}
  recMsg:= recNo + ' od ' + recCount;
  edtRecNo.Text:= recMsg;
end;

procedure TfrmPharmacyMaterialGroup.edtLocateEnter(Sender: TObject);
begin
  {clear text and set font-color}
  edtLocate.Text:= '';
  edtLocate.Font.Color:= clBlack;
end;

procedure TfrmPharmacyMaterialGroup.edtLocateExit(Sender: TObject);
begin
  {set text and font-color}
  edtLocate.Text:= 'Pronadji ...';
  edtLocate.Font.Color:= clGray;
end;

procedure TfrmPharmacyMaterialGroup.edtLocateKeyUp(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  {try to locate}
  if(not TZAbstractDataset(ztPMaterialGroup).Locate(FG_NAME, edtLocate.Text, [loCaseInsensitive, loPartialKey])) then
    begin
      Beep;
      edtLocate.SelectAll;
    end;
end;

procedure TfrmPharmacyMaterialGroup.FormClose(Sender: TObject;
  var CloseAction: TCloseAction);
begin
  {check for unsaved changes}
  saveBeforeClose;
  inherited;
end;

procedure TfrmPharmacyMaterialGroup.ztPMaterialGroupAfterDelete(
  DataSet: TDataSet);
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

procedure TfrmPharmacyMaterialGroup.ztPMaterialGroupAfterOpen(DataSet: TDataSet
  );
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

procedure TfrmPharmacyMaterialGroup.ztPMaterialGroupAfterPost(DataSet: TDataSet
  );
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

procedure TfrmPharmacyMaterialGroup.ztPMaterialGroupAfterScroll(
  DataSet: TDataSet);
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

procedure TfrmPharmacyMaterialGroup.saveBeforeClose;
var
  newDlg : TdlgConfirm;
  confirmMsg : String = 'Postoje izmene koje nisu sačuvane!';
  saveAll : Boolean = False;
begin
  {set confirm msg}
  confirmMsg:= confirmMsg + #13#10;
  confirmMsg:= confirmMsg + 'Želite da sačuvamo izmene?';
  if(TZAbstractDataset(ztPMaterialGroup).State in [dsEdit, dsInsert]) then
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
    doSaveRec(TZAbstractDataset(ztPMaterialGroup)); {in this case just one dataSet}
end;

procedure TfrmPharmacyMaterialGroup.onActFirst;
begin
  {jump to first rec}
  doFirstRec(TZAbstractDataset(ztPMaterialGroup));
end;

procedure TfrmPharmacyMaterialGroup.onActPrior;
begin
  {jump to prior rec}
  doPriorRec(TZAbstractDataset(ztPMaterialGroup));
end;

procedure TfrmPharmacyMaterialGroup.onActNext;
begin
  {jump to next rec}
  doNextRec(TZAbstractDataset(ztPMaterialGroup));
end;

procedure TfrmPharmacyMaterialGroup.onActLast;
begin
  {jump to last rec}
  doLastRec(TZAbstractDataset(ztPMaterialGroup));
end;

procedure TfrmPharmacyMaterialGroup.onActInsert;
begin
  {set focus and insert new rec}
  dbCode.SetFocus;
  doInsertRec(TZAbstractDataset(ztPMaterialGroup));
end;

procedure TfrmPharmacyMaterialGroup.onActDelete;
begin
  {delete rec}
  doDeleteRec(TZAbstractDataset(ztPMaterialGroup));
end;

procedure TfrmPharmacyMaterialGroup.onActEdit;
begin
  {set focus and edit rec}
  dbCode.SetFocus;
  doEditRec(TZAbstractDataset(ztPMaterialGroup));
end;

procedure TfrmPharmacyMaterialGroup.onActSave;
begin
  {save rec}
  doSaveRec(TZAbstractDataset(ztPMaterialGroup));
end;

procedure TfrmPharmacyMaterialGroup.onActCancel;
begin
  {cancel rec}
  doCancelRec(TZAbstractDataset(ztPMaterialGroup));
end;

procedure TfrmPharmacyMaterialGroup.openDataSet;
begin
  TZAbstractDataset(ztPMaterialGroup).DisableControls;
  TZAbstractDataset(ztPMaterialGroup).Close;
  try
    TZAbstractDataset(ztPMaterialGroup).Open;
    TZAbstractDataset(ztPMaterialGroup).EnableControls;
  except
    on e : Exception do
    begin
      dModule.zdbh.Rollback;
      TZAbstractDataset(ztPMaterialGroup).EnableControls;
      ShowMessage(e.Message);
    end;
  end;
end;

end.

