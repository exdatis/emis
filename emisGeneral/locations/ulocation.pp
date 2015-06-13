unit uLocation;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,
  ActnList, ExtCtrls, Buttons, DbCtrls, DBGrids, PopupNotifier, uBaseDbForm, db,
  ZAbstractDataset, ZDataset, ZSequence, ZSqlUpdate, ZAbstractRODataset;

type

  { TfrmLocation }

  TfrmLocation = class(TbaseDbForm)
    actCharFilter: TAction;
    actClearFilter: TAction;
    actLocation: TActionList;
    btnCharFilter: TSpeedButton;
    btnShowAll: TSpeedButton;
    cmbCharFilter: TComboBox;
    cmbFieldArg: TComboBox;
    dbCode: TDBEdit;
    dbgLocation: TDBGrid;
    dbName: TDBEdit;
    dsLocation: TDataSource;
    edtLocate: TEdit;
    groupBoxEdit: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    panelParams: TPanel;
    pupNotiferLocation: TPopupNotifier;
    zqLocation: TZQuery;
    zqLocationL_CODE: TStringField;
    zqLocationL_ID: TLongintField;
    zqLocationL_NAME: TStringField;
    zseqLocation: TZSequence;
    zupdLocation: TZUpdateSQL;
    procedure actCharFilterExecute(Sender: TObject);
    procedure actClearFilterExecute(Sender: TObject);
    procedure cmbFieldArgChange(Sender: TObject);
    procedure dbgLocationMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure dbgLocationTitleClick(Column: TColumn);
    procedure edtLocateEnter(Sender: TObject);
    procedure edtLocateExit(Sender: TObject);
    procedure edtLocateKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState
      );
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure zqLocationAfterDelete(DataSet: TDataSet);
    procedure zqLocationAfterOpen(DataSet: TDataSet);
    procedure zqLocationAfterPost(DataSet: TDataSet);
    procedure zqLocationAfterScroll(DataSet: TDataSet);
  private
    { private declarations }
    charArg : String; {name-start with this char}
    fieldArg : String; {locate text from field}
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
    {open dataSet using charArg}
    procedure applyCharFilter;
  end;

var
  frmLocation: TfrmLocation;
const
  {fields of tbl location}
  FIELD_ID : String = 'L_ID';
  FIELD_CODE : String = 'L_CODE';
  FIELD_NAME : String = 'L_NAME';
  {params}
  PARAM_NAME : String = 'L_NAME'; {:L_NAME}

implementation
uses
  uDModule, uConfirm;
{$R *.lfm}

{ TfrmLocation }

procedure TfrmLocation.FormCreate(Sender: TObject);
begin
  {default args}
  charArg:= 'A%';
  fieldArg:= FIELD_NAME; {locate using field_name}
end;

procedure TfrmLocation.FormShow(Sender: TObject);
var
  helpMsg : String = 'Izaberite početna slova';
  x, y : Longint;
begin
  {gubi poziciju nije ispravno}
  {********************************************************
  {show help for search loctions}
  helpMsg:= helpMsg + #13#10;
  helpMsg:= helpMsg + 'grada kao filter.';
  helpMsg:= helpMsg + #13#10;
  helpMsg:= helpMsg + 'Prikazana su mesta na slovo: A';
  pupNotiferLocation.Text:= helpMsg;
  {* cmbCharFilter position *}
  x:= Screen.ActiveControl.Left + 247;
  y:= Screen.ActiveControl.Top + 120;
  { show at position }
  pupNotiferLocation.ShowAtPos(x, y);
  {this is not ok}
  {* Sleep(2500);
  pupNotiferLocation.Hide; *}
  **********************************************************}
end;

procedure TfrmLocation.actCharFilterExecute(Sender: TObject);
begin
  {set filter}
  charArg:= cmbCharFilter.Text + '%';
  {apply filter}
  applyCharFilter;
end;

procedure TfrmLocation.actClearFilterExecute(Sender: TObject);
begin
  {set char-argument}
  charArg:= '%'; {show all}
  applyCharFilter;
  {set cmbCharFilter index}
  cmbCharFilter.Text:= 'Mesta na slovo ...'; {message like text}
end;

procedure TfrmLocation.cmbFieldArgChange(Sender: TObject);
begin
  {set field-filter}
  case cmbFieldArg.ItemIndex of
    1: fieldArg:= FIELD_NAME;
    2: fieldArg:= FIELD_CODE;
  else
    fieldArg:= FIELD_NAME;
  end;
  {set focus}
  edtLocate.SetFocus;
end;

procedure TfrmLocation.dbgLocationMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
  {set cursor again}
  dbgLocation.Cursor:= crHandPoint;
end;

procedure TfrmLocation.dbgLocationTitleClick(Column: TColumn);
var
  recCount, recNo : String;
  recMsg : String = '0 od 0'; {find again recNo}
begin
  {sort}
  sortDbGrid(TZAbstractDataset(zqLocation), Column);
  {refresh after sort}
  dbgLocation.Refresh;
  { find recNo}
  recCount:= IntToStr(TZAbstractDataset(zqLocation).RecordCount);
  recNo:= IntToStr(TZAbstractDataset(zqLocation).RecNo);
  {create recMsg}
  recMsg:= recNo + ' od ' + recCount;
  edtRecNo.Text:= recMsg;
end;

procedure TfrmLocation.edtLocateEnter(Sender: TObject);
begin
  {clear text and set font-color}
  edtLocate.Text:= '';
  edtLocate.Font.Color:= clBlack;
end;

procedure TfrmLocation.edtLocateExit(Sender: TObject);
begin
  {set text and font-color}
  edtLocate.Text:= 'Pronadji ...';
  edtLocate.Font.Color:= clGray;
end;

procedure TfrmLocation.edtLocateKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  {try to locate}
  if(not TZAbstractDataset(zqLocation).Locate(fieldArg, edtLocate.Text, [loCaseInsensitive, loPartialKey])) then
    begin
      Beep;
      edtLocate.SelectAll;
    end;
end;

procedure TfrmLocation.FormClose(Sender: TObject; var CloseAction: TCloseAction
  );
begin
  {check for unsaved changes}
  saveBeforeClose;
  inherited;
end;

procedure TfrmLocation.zqLocationAfterDelete(DataSet: TDataSet);
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

procedure TfrmLocation.zqLocationAfterOpen(DataSet: TDataSet);
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

procedure TfrmLocation.zqLocationAfterPost(DataSet: TDataSet);
var
  currId : Longint;
  firstChar : String = '';
  currText : String;
  {calc records(recNo and countRec)}
  recCount, recNo : String;
  recMsg : String = '0 od 0';
begin
  {upply updates}
  TZAbstractDataset(DataSet).ApplyUpdates;
  {rtefresh current row}
  TZAbstractDataset(DataSet).RefreshCurrentRow(True);
  {find currText}
  currText:= TZAbstractDataset(DataSet).FieldByName(FIELD_NAME).AsString;
  {first char to firstChar-var}
  firstChar:= LeftStr(currText, 1);
  firstChar:= firstChar + '%';
  {compare current charFilter}
  if(charArg <> firstChar) then
    begin
      {save position}
      currId:= TZAbstractDataset(DataSet).FieldByName(FIELD_ID).AsInteger;
      charArg:= firstChar;
      applyCharFilter;
      {locate}
      TZAbstractDataset(DataSet).Locate(FIELD_ID, currId, []);
    end;
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

procedure TfrmLocation.zqLocationAfterScroll(DataSet: TDataSet);
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

procedure TfrmLocation.saveBeforeClose;
var
  newDlg : TdlgConfirm;
  confirmMsg : String = 'Postoje izmene koje nisu sačuvane!';
  saveAll : Boolean = False;
begin
  {set confirm msg}
  confirmMsg:= confirmMsg + #13#10;
  confirmMsg:= confirmMsg + 'Želite da sačuvamo izmene?';
  if(TZAbstractDataset(zqLocation).State in [dsEdit, dsInsert]) then
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
    doSaveRec(TZAbstractDataset(zqLocation)); {in this case just one dataSet}
end;

procedure TfrmLocation.sortDbGrid(var dataSet : TZAbstractDataset; Column : TColumn);
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

procedure TfrmLocation.onActFirst;
begin
  {jump to first rec}
  doFirstRec(TZAbstractDataset(zqLocation));
end;

procedure TfrmLocation.onActPrior;
begin
  {jump to prior rec}
  doPriorRec(TZAbstractDataset(zqLocation));
end;

procedure TfrmLocation.onActNext;
begin
  {jump to next rec}
  doNextRec(TZAbstractDataset(zqLocation));
end;

procedure TfrmLocation.onActLast;
begin
  {jump to last rec}
  doLastRec(TZAbstractDataset(zqLocation));
end;

procedure TfrmLocation.onActInsert;
begin
  {set focus and insert new rec}
  dbCode.SetFocus;
  doInsertRec(TZAbstractDataset(zqLocation));
end;

procedure TfrmLocation.onActDelete;
begin
  {delete rec}
  doDeleteRec(TZAbstractDataset(zqLocation));
end;

procedure TfrmLocation.onActEdit;
begin
  {set focus and edit rec}
  dbCode.SetFocus;
  doEditRec(TZAbstractDataset(zqLocation));
end;

procedure TfrmLocation.onActSave;
begin
  {save rec}
  doSaveRec(TZAbstractDataset(zqLocation));
end;

procedure TfrmLocation.onActCancel;
begin
  {cancel rec}
  doCancelRec(TZAbstractDataset(zqLocation));
end;

procedure TfrmLocation.applyCharFilter;
begin
  TZAbstractDataset(zqLocation).DisableControls;
  TZAbstractDataset(zqLocation).Close;
  try
    TZAbstractDataset(zqLocation).ParamByName(PARAM_NAME).AsString:= charArg;
    TZAbstractDataset(zqLocation).Open;
    TZAbstractDataset(zqLocation).EnableControls;
    {show arg in cmbChar}
    //cmbCharFilter.ItemIndex:= cmbCharFilter.Items.IndexOf(LeftStr(charArg, 1)); {without '%'}
  except
    on e : Exception do
    begin
      dModule.zdbh.Rollback;
      TZAbstractDataset(zqLocation).EnableControls;
      ShowMessage(e.Message);
    end;
  end;
end;

end.

