unit uDrugs;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, ZDataset, ZSequence, ZSqlUpdate, Forms, Controls,
  Graphics, Dialogs, StdCtrls, ActnList, ExtCtrls, Buttons, DBGrids, ComCtrls,
  DbCtrls, uBaseDbForm, db, ZAbstractRODataset, ZAbstractDataset;

{exception if drug_id is null}
type
  TENoDrugs = class(Exception);
type

  { TfrmDrugs }

  TfrmDrugs = class(TbaseDbForm)
    actCharFilter: TAction;
    actClearFilter: TAction;
    actFindDrugs: TActionList;
    btnCharFilter: TSpeedButton;
    btnShowAll: TSpeedButton;
    cmbCharFilter: TComboBox;
    cmbFieldArg: TComboBox;
    dbgNomenclatureVar: TDBGrid;
    dbValue: TDBEdit;
    dblNomenclature: TDBLookupComboBox;
    dsNomenclature: TDataSource;
    dsNomenclatureVar: TDataSource;
    dbCode: TDBEdit;
    dbBarCode: TDBEdit;
    dblGenerics: TDBLookupComboBox;
    dblMeasure: TDBLookupComboBox;
    dblGroup: TDBLookupComboBox;
    dblDrugForm: TDBLookupComboBox;
    dblTaxes: TDBLookupComboBox;
    dbPieces: TDBEdit;
    dbName: TDBEdit;
    dsTaxes: TDataSource;
    dsMeasure: TDataSource;
    dsDrugGroups: TDataSource;
    dsDrugForms: TDataSource;
    dsGenerics: TDataSource;
    dbgDrugs: TDBGrid;
    dsDrugs: TDataSource;
    edtLocate: TEdit;
    gbEditDrugs: TGroupBox;
    gbEditNomenclature: TGroupBox;
    Label1: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    pcDrugs: TPageControl;
    panelParams: TPanel;
    tsProperties: TTabSheet;
    tsStrong: TTabSheet;
    tsNomenclatures: TTabSheet;
    tsDrug: TTabSheet;
    zqDrugs: TZQuery;
    zqDrugsDRUG_FORM_CODE: TStringField;
    zqDrugsDRUG_FORM_NAME: TStringField;
    zqDrugsDRUG_GROUP_CODE: TStringField;
    zqDrugsDRUG_GROUP_NAME: TStringField;
    zqDrugsD_BARCODE: TStringField;
    zqDrugsD_CODE: TStringField;
    zqDrugsD_FORM: TLongintField;
    zqDrugsD_GENERICS: TLongintField;
    zqDrugsD_GROUP: TLongintField;
    zqDrugsD_ID: TLongintField;
    zqDrugsD_MEASURE: TLongintField;
    zqDrugsD_NAME: TStringField;
    zqDrugsD_PIECES: TFloatField;
    zqDrugsD_TAX: TLongintField;
    zqDrugsGENERICS_CODE: TStringField;
    zqDrugsGENERICS_NAME: TStringField;
    zqDrugsMEASURE_CODE: TStringField;
    zqDrugsMEASURE_NAME: TStringField;
    zqDrugsTAX_CODE: TStringField;
    zqDrugsTAX_VALUE: TFloatField;
    zqNomenclatureVar: TZQuery;
    zqNomenclatureVarDNV_DRUG: TLongintField;
    zqNomenclatureVarDNV_ID: TLongintField;
    zqNomenclatureVarDNV_NOMENCLATURE: TLongintField;
    zqNomenclatureVarDNV_VALUE: TStringField;
    zqNomenclatureVarDRUG_CODE: TStringField;
    zqNomenclatureVarDRUG_NAME: TStringField;
    zqNomenclatureVarNOMENCLATURE_NAME: TStringField;
    zroNomenclature: TZReadOnlyQuery;
    zroNomenclatureDN_ID: TLongintField;
    zroNomenclatureDN_NAME: TStringField;
    zroTaxes: TZReadOnlyQuery;
    zroMeasure: TZReadOnlyQuery;
    zroDrugGroups: TZReadOnlyQuery;
    zroDrugForms: TZReadOnlyQuery;
    zroDrugFormsDF_ID: TLongintField;
    zroDrugFormsDF_NAME: TStringField;
    zroDrugGroupsDG_ID: TLongintField;
    zroDrugGroupsDG_NAME: TStringField;
    zroGenerics: TZReadOnlyQuery;
    zroGenericsG_ID: TLongintField;
    zroGenericsG_NAME: TStringField;
    zroMeasureM_ID: TLongintField;
    zroMeasureM_NAME: TStringField;
    zroTaxesTX_CODE: TStringField;
    zroTaxesTX_ID: TLongintField;
    zseqProducts: TZSequence;
    zseqNomenlatureVar: TZSequence;
    zupdNomenclatureVar: TZUpdateSQL;
    zupdDrugs: TZUpdateSQL;
    procedure actCharFilterExecute(Sender: TObject);
    procedure actClearFilterExecute(Sender: TObject);
    procedure cmbFieldArgChange(Sender: TObject);
    procedure dbgDrugsMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure dbgDrugsTitleClick(Column: TColumn);
    procedure dbgNomenclatureVarMouseMove(Sender: TObject; Shift: TShiftState;
      X, Y: Integer);
    procedure dbgNomenclatureVarTitleClick(Column: TColumn);
    procedure edtLocateEnter(Sender: TObject);
    procedure edtLocateExit(Sender: TObject);
    procedure edtLocateKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState
      );
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure pcDrugsChange(Sender: TObject);
    procedure zqDrugsAfterDelete(DataSet: TDataSet);
    procedure zqDrugsAfterOpen(DataSet: TDataSet);
    procedure zqDrugsAfterPost(DataSet: TDataSet);
    procedure zqDrugsAfterScroll(DataSet: TDataSet);
    procedure zqDrugsBeforeScroll(DataSet: TDataSet);
    procedure zqDrugsNewRecord(DataSet: TDataSet);
    procedure zqNomenclatureVarAfterDelete(DataSet: TDataSet);
    procedure zqNomenclatureVarAfterOpen(DataSet: TDataSet);
    procedure zqNomenclatureVarAfterPost(DataSet: TDataSet);
    procedure zqNomenclatureVarAfterScroll(DataSet: TDataSet);
    procedure zqNomenclatureVarBeforeOpen(DataSet: TDataSet);
    procedure zqNomenclatureVarBeforePost(DataSet: TDataSet);
  private
    { private declarations }
    charArg : String; {name-start with this char}
    fieldArg : String; {locate text from field}
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
    {open dataSet using charArg}
    procedure openRODataSets;
    procedure applyCharFilter;
  end;

var
  frmDrugs: TfrmDrugs;
const
  {exception msg}
  ENoDrugsMsg : String = 'Nije selektovan/izabran lek.';
  //**************************** drugs *****************************************
  {fields of tbl drugs}
  FD_ID : String = 'D_ID';
  FD_CODE : String = 'D_CODE';
  FD_NAME : String = 'D_NAME';
  FD_GENERICS : String = 'D_GENERICS';
  FD_FORM : String = 'D_FORM';
  FD_BARCODE : String = 'D_BARCODE';
  FD_GROUP : String = 'D_GROUP';
  FD_MEASURE : String = 'D_MEASURE';
  FD_TAX : String = 'D_TAX';
  FD_PIECES : String = 'D_PIECES';
  {fields of view drugs_v}
  GENERICS_CODE : String = 'GENERICS_CODE';
  GENERICS_NAME : String = 'GENERICS_NAME';
  DRUG_FORM_CODE : String = 'DRUG_FORM_CODE';
  DRUG_FORM_NAME : String = 'DRUG_FORM_NAME';
  DRUG_GROUP_CODE : String = 'DRUG_GROUP_CODE';
  DRUG_GROUP_NAME : String = 'DRUG_GROUP_NAME';
  MEASURE_CODE : String = 'MEASURE_CODE';
  MEASURE_NAME : String = 'MEASURE_NAME';
  TAX_CODE : String = 'TAX_CODE';
  TAX_VALUE : STring = 'TAX_VALUE';
  {params}
  PARAM_NAME : String = 'D_NAME'; {:D_NAME}
  //****************************************************************************
  {fields of table drug_nomenclature_var}
  FDNV_ID : String = 'DNV_ID';
  FDNV_DRUG : String = 'DNV_DRUG';
  FDNV_NOMENCLATURE : String = 'DNV_NOMENCLATURE';
  FDNV_VALUE : String = 'DNV_VALUE';
  {fields of view drug_nomenclature_var_v}
  NOMENCLATURE_NAME : String = 'NOMENCLATURE_NAME';
  DRUG_CODE : String = 'DRUG_CODE';
  DRUG_NAME : String = 'DRUG_NAME';
  //****************************************************************************
implementation
uses
  uDModule, uConfirm;
{$R *.lfm}

{ TfrmDrugs }

procedure TfrmDrugs.FormCreate(Sender: TObject);
begin
  {default args}
  charArg:= 'AB%';
  fieldArg:= PARAM_NAME; {locate using field_name}
end;

procedure TfrmDrugs.pcDrugsChange(Sender: TObject);
begin
  //exception if not drugs
  if(TZAbstractDataset(zqDrugs).IsEmpty) then
    if(pcDrugs.ActivePageIndex > 0) then
      begin
        pcDrugs.ActivePageIndex:= 0;
        Application.ProcessMessages;
        raise TENoDrugs.Create(ENoDrugsMsg);
        Application.ProcessMessages;
        Exit;
      end;
  {else open dataSet}
  case pcDrugs.ActivePageIndex of
    1:
       begin
         TZAbstractDataset(zqNomenclatureVar).DisableControls;
         TZAbstractDataset(zqNomenclatureVar).Close;
         TZAbstractDataset(zqNomenclatureVar).Open;
         TZAbstractDataset(zqNomenclatureVar).EnableControls;
         dbgNomenclatureVar.Refresh;
         Application.ProcessMessages;
       end;
    2:
        begin
          //TZAbstractDataset(zqNomenclatureVar).DisableControls;
          //TZAbstractDataset(zqNomenclatureVar).Close;
          //TZAbstractDataset(zqNomenclatureVar).Open;
          //TZAbstractDataset(zqNomenclatureVar).EnableControls;
          //dbgNomenclatureVar.Refresh;
          Application.ProcessMessages;
        end;
  end;
end;

procedure TfrmDrugs.zqDrugsAfterDelete(DataSet: TDataSet);
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

procedure TfrmDrugs.zqDrugsAfterOpen(DataSet: TDataSet);
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

procedure TfrmDrugs.zqDrugsAfterPost(DataSet: TDataSet);
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
  currText:= TZAbstractDataset(DataSet).FieldByName(FD_NAME).AsString;
  {first char to firstChar-var}
  firstChar:= LeftStr(currText, 2); //two chars
  firstChar:= firstChar + '%';
  {compare current charFilter}
  if(charArg <> firstChar) then
    begin
      {save position}
      currId:= TZAbstractDataset(DataSet).FieldByName(FD_ID).AsInteger;
      charArg:= firstChar;
      applyCharFilter;
      {locate}
      TZAbstractDataset(DataSet).Locate(FD_ID, currId, []);
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

procedure TfrmDrugs.zqDrugsAfterScroll(DataSet: TDataSet);
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

procedure TfrmDrugs.zqDrugsBeforeScroll(DataSet: TDataSet);
begin
  {check current page}
  if (not(pcDrugs.ActivePageIndex = 0)) then
    begin
      pcDrugs.ActivePageIndex:= 0;
      Application.ProcessMessages;
    end;
end;

procedure TfrmDrugs.zqDrugsNewRecord(DataSet: TDataSet);
begin
  {set default values}
  TZAbstractDataset(DataSet).FieldByName(FD_PIECES).AsFloat:= 1;
end;

procedure TfrmDrugs.zqNomenclatureVarAfterDelete(DataSet: TDataSet);
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

procedure TfrmDrugs.zqNomenclatureVarAfterOpen(DataSet: TDataSet);
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

procedure TfrmDrugs.zqNomenclatureVarAfterPost(DataSet: TDataSet);
var
  {calc records(recNo and countRec)}
  recCount, recNo : String;
  recMsg : String = '0 od 0';
begin
  {upply updates}
  TZAbstractDataset(DataSet).ApplyUpdates;
  {rtefresh current row}
  TZAbstractDataset(DataSet).RefreshCurrentRow(True);
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

procedure TfrmDrugs.zqNomenclatureVarAfterScroll(DataSet: TDataSet);
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

procedure TfrmDrugs.zqNomenclatureVarBeforeOpen(DataSet: TDataSet);
var
  current_drug : Integer;
begin
  //find current
  current_drug:= TZAbstractDataset(zqDrugs).FieldByName(FD_ID).AsInteger;
  TZAbstractDataset(zqNomenclatureVar).ParamByName(FDNV_DRUG).AsInteger:= current_drug;
end;

procedure TfrmDrugs.zqNomenclatureVarBeforePost(DataSet: TDataSet);
var
  current_drug : Integer;
begin
  //find current
  current_drug:= TZAbstractDataset(zqDrugs).FieldByName(FD_ID).AsInteger;
  TZAbstractDataset(zqNomenclatureVar).FieldByName(FDNV_DRUG).AsInteger:= current_drug;
end;

procedure TfrmDrugs.actCharFilterExecute(Sender: TObject);
begin
  {check current page}
  if (not(pcDrugs.ActivePageIndex = 0)) then
    begin
      pcDrugs.ActivePageIndex:= 0;
      Application.ProcessMessages;
    end;
  {set filter}
  charArg:= cmbCharFilter.Text + '%';
  {apply filter}
  applyCharFilter;
end;

procedure TfrmDrugs.actClearFilterExecute(Sender: TObject);
begin
  {check current page}
  if (not(pcDrugs.ActivePageIndex = 0)) then
    begin
      pcDrugs.ActivePageIndex:= 0;
      Application.ProcessMessages;
    end;
  {set char-argument}
  charArg:= '%'; {show all}
  applyCharFilter;
  {set cmbCharFilter index}
  cmbCharFilter.Text:= 'Lekovi na slovo ...'; {message like text}
end;

procedure TfrmDrugs.cmbFieldArgChange(Sender: TObject);
begin
  {check current page}
  if (not(pcDrugs.ActivePageIndex = 0)) then
    begin
      pcDrugs.ActivePageIndex:= 0;
      Application.ProcessMessages;
    end;
  {set field-filter}
  case cmbFieldArg.ItemIndex of
    1: fieldArg:= FD_NAME;
    2: fieldArg:= FD_CODE;
    3: fieldArg:= FD_BARCODE;
  else
    fieldArg:= FD_NAME;
  end;
  {set focus}
  edtLocate.SetFocus;
end;

procedure TfrmDrugs.dbgDrugsMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
  {set cursor again}
  dbgDrugs.Cursor:= crHandPoint;
end;

procedure TfrmDrugs.dbgDrugsTitleClick(Column: TColumn);
var
  recCount, recNo : String;
  recMsg : String = '0 od 0'; {find again recNo}
begin
  {set current page}
  if (not(pcDrugs.ActivePageIndex = 0)) then
    begin
      pcDrugs.ActivePageIndex:= 0;
      Application.ProcessMessages;
    end;
  {sort}
  doSortDbGrid(TZAbstractDataset(zqDrugs), Column);
  {refresh after sort}
  dbgDrugs.Refresh;
  { find recNo}
  recCount:= IntToStr(TZAbstractDataset(zqDrugs).RecordCount);
  recNo:= IntToStr(TZAbstractDataset(zqDrugs).RecNo);
  {create recMsg}
  recMsg:= recNo + ' od ' + recCount;
  edtRecNo.Text:= recMsg;
end;

procedure TfrmDrugs.dbgNomenclatureVarMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
  {set cursor}
  dbgNomenclatureVar.Cursor:= crHandPoint;
end;

procedure TfrmDrugs.dbgNomenclatureVarTitleClick(Column: TColumn);
begin
  {sort}
  doSortDbGrid(TZAbstractDataset(zqNomenclatureVar), Column);
end;

procedure TfrmDrugs.edtLocateEnter(Sender: TObject);
begin
  {check current page}
  if (not(pcDrugs.ActivePageIndex = 0)) then
    begin
      pcDrugs.ActivePageIndex:= 0;
      Application.ProcessMessages;
    end;
  {clear text and set font-color}
  edtLocate.Text:= '';
  edtLocate.Font.Color:= clBlack;
end;

procedure TfrmDrugs.edtLocateExit(Sender: TObject);
begin
  {set text and font-color}
  edtLocate.Text:= 'Pronadji ...';
  edtLocate.Font.Color:= clGray;
end;

procedure TfrmDrugs.edtLocateKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  {try to locate}
  if(not TZAbstractDataset(zqDrugs).Locate(fieldArg, edtLocate.Text, [loCaseInsensitive, loPartialKey])) then
    begin
      Beep;
      edtLocate.SelectAll;
    end;
end;

procedure TfrmDrugs.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  {check for unsaved changes}
  saveBeforeClose;
  inherited;
end;

procedure TfrmDrugs.saveBeforeClose;
begin
  ShowMessage('Do not forget!');
end;

procedure TfrmDrugs.openRODataSets;
begin
  //drug forms
  zroDrugForms.DisableControls;
  zroDrugForms.Open;
  zroDrugForms.EnableControls;
  //drug groups
  zroDrugGroups.DisableControls;
  zroDrugGroups.Open;
  zroDrugGroups.EnableControls;
  //generics
  zroGenerics.DisableControls;
  zroGenerics.Open;
  zroGenerics.EnableControls;
  //measure
  zroMeasure.DisableControls;
  zroMeasure.Open;
  zroMeasure.EnableControls;
  //taxes
  zroTaxes.DisableControls;
  zroTaxes.Open;
  zroTaxes.EnableControls;
  //nomenclatures
  zroNomenclature.DisableControls;
  zroNomenclature.Open;
  zroNomenclature.EnableControls;
end;

procedure TfrmDrugs.onActFirst;
begin
  {jump to first rec}
  case pcDrugs.ActivePageIndex of
    0: doFirstRec(TZAbstractDataset(zqDrugs));
    1: doFirstRec(TZAbstractDataset(zqNomenclatureVar));
    2: ShowMessage('Not jet');
  end;
end;

procedure TfrmDrugs.onActPrior;
begin
  {jump to prior rec}
  case pcDrugs.ActivePageIndex of
    0: doPriorRec(TZAbstractDataset(zqDrugs));
    1: doPriorRec(TZAbstractDataset(zqNomenclatureVar));
    2: ShowMessage('Not jet');
  end;
end;

procedure TfrmDrugs.onActNext;
begin
  {jump to next rec}
  case pcDrugs.ActivePageIndex of
    0: doNextRec(TZAbstractDataset(zqDrugs));
    1: doNextRec(TZAbstractDataset(zqNomenclatureVar));
    2: ShowMessage('Not jet');
  end;
end;

procedure TfrmDrugs.onActLast;
begin
  {jump to last rec}
  case pcDrugs.ActivePageIndex of
    0: doLastRec(TZAbstractDataset(zqDrugs));
    1: doLastRec(TZAbstractDataset(zqNomenclatureVar));
    2: ShowMessage('Not jet');
  end;
end;

procedure TfrmDrugs.onActInsert;
begin
  {set focus and insert new rec}
  case pcDrugs.ActivePageIndex of
    0:
       begin
         dbCode.SetFocus;
         doInsertRec(TZAbstractDataset(zqDrugs));
       end;
    1:
       begin
         dblNomenclature.SetFocus;
         doInsertRec(TZAbstractDataset(zqNomenclatureVar));
       end;
    2: ShowMessage('Not jet');
  end;
end;

procedure TfrmDrugs.onActDelete;
begin
  {delete rec}
  case pcDrugs.ActivePageIndex of
    0: doDeleteRec(TZAbstractDataset(zqDrugs));
    1: doDeleteRec(TZAbstractDataset(zqNomenclatureVar));
    2: ShowMessage('Not jet');
  end;
end;

procedure TfrmDrugs.onActEdit;
begin
  {set focus and edit rec}
  case pcDrugs.ActivePageIndex of
    0:
       begin
         dbCode.SetFocus;
         doEditRec(TZAbstractDataset(zqDrugs));
       end;
    1:
       begin
          dblNomenclature.SetFocus;
          doEditRec(TZAbstractDataset(zqNomenclatureVar));
        end;
    2: ShowMessage('Not jet');
  end;
end;

procedure TfrmDrugs.onActSave;
begin
  {save rec}
  case pcDrugs.ActivePageIndex of
    0: doSaveRec(TZAbstractDataset(zqDrugs));
    1: doSaveRec(TZAbstractDataset(zqNomenclatureVar));
    2: ShowMessage('Not jet');
  end;
end;

procedure TfrmDrugs.onActCancel;
begin
  {cancel rec}
  case pcDrugs.ActivePageIndex of
    0: doCancelRec(TZAbstractDataset(zqDrugs));
    1: doCancelRec(TZAbstractDataset(zqNomenclatureVar));
    2: ShowMessage('Not jet');
  end;
end;

procedure TfrmDrugs.applyCharFilter;
begin
  TZAbstractDataset(zqDrugs).DisableControls;
  TZAbstractDataset(zqDrugs).Close;
  try
    TZAbstractDataset(zqDrugs).ParamByName(PARAM_NAME).AsString:= charArg;
    TZAbstractDataset(zqDrugs).Open;
    TZAbstractDataset(zqDrugs).EnableControls;
    {show arg in cmbChar}
    //cmbCharFilter.ItemIndex:= cmbCharFilter.Items.IndexOf(LeftStr(charArg, 1)); {without '%'}
  except
    on e : Exception do
    begin
      dModule.zdbh.Rollback;
      TZAbstractDataset(zqDrugs).EnableControls;
      ShowMessage(e.Message);
    end;
  end;
end;

end.

