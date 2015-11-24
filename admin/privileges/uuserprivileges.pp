unit uUserPrivileges;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, DBDateTimePicker, ZDataset, ZSequence,
  ZSqlUpdate, Forms, Controls, Graphics, Dialogs, StdCtrls, ActnList, ExtCtrls,
  Buttons, DBGrids, ComCtrls, DbCtrls, uBaseDbForm, db, ZAbstractDataset;

{exception if drug_id is null}
type
  TENoUsers = class(Exception);
type

  { TfrmUserPrivileges }

  TfrmUserPrivileges = class(TbaseDbForm)
    actCharFilter: TAction;
    actClearFilter: TAction;
    actFindUser: TActionList;
    btnCharFilter: TSpeedButton;
    btnShowAll: TSpeedButton;
    btnShowCharacters: TButton;
    cmbCharFilter: TComboBox;
    cmbFieldArg: TComboBox;
    dbcValidPriveleges: TDBCheckBox;
    dbcValid: TDBCheckBox;
    dbCode: TDBEdit;
    dbControlDate: TDBDateTimePicker;
    dbgPrivileges: TDBGrid;
    dblDepartment: TDBLookupComboBox;
    dblModule: TDBLookupComboBox;
    dbgPrivilegesType: TDBRadioGroup;
    dbUserPwd: TDBEdit;
    dbUserName: TDBEdit;
    dbTitle: TDBEdit;
    dbName: TDBEdit;
    dsUserPrivileges: TDataSource;
    dsUsers: TDataSource;
    dsModule: TDataSource;
    dsDepartments: TDataSource;
    dbgUsers: TDBGrid;
    edtLocate: TEdit;
    gbEditUser: TGroupBox;
    gbPrivileges: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    pcUsers: TPageControl;
    panelParams: TPanel;
    tsPrivileges: TTabSheet;
    tsUsers: TTabSheet;
    zqUserPrivileges: TZQuery;
    zqUserPrivilegesMODULE_CODE: TStringField;
    zqUserPrivilegesNAME_OF_MODULE: TStringField;
    zqUserPrivilegesUP_CONTROL_DATE: TDateField;
    zqUserPrivilegesUP_ID: TLongintField;
    zqUserPrivilegesUP_MODULE: TLongintField;
    zqUserPrivilegesUP_PRIVILEGES: TSmallintField;
    zqUserPrivilegesUP_USER: TLongintField;
    zqUserPrivilegesUP_VALID: TSmallintField;
    zqUserPrivilegesUSER_NAME: TStringField;
    zqUserPrivilegesUSER_TITLE: TStringField;
    zqUsers: TZQuery;
    zqUsersAU_CODE: TStringField;
    zqUsersAU_DEPARTMENT: TLongintField;
    zqUsersAU_FULL_NAME: TStringField;
    zqUsersAU_ID: TLongintField;
    zqUsersAU_TITLE: TStringField;
    zqUsersAU_USER_NAME: TStringField;
    zqUsersAU_USER_PWD: TStringField;
    zqUsersAU_VALID: TSmallintField;
    zqUsersDEPARTMENT_CODE: TStringField;
    zqUsersDEPARTMENT_NAME: TStringField;
    zqUsersVALID: TBooleanField;
    zroModule: TZReadOnlyQuery;
    zroDepartments: TZReadOnlyQuery;
    zroDepartmentsD_ID: TLongintField;
    zroDepartmentsD_NAME: TStringField;
    zroModuleM_ID: TLongintField;
    zroModuleM_NAME: TStringField;
    zseqUserPrivileges: TZSequence;
    zseqUsers: TZSequence;
    zupdUserPrivileges: TZUpdateSQL;
    zupdUsers: TZUpdateSQL;
    procedure actCharFilterExecute(Sender: TObject);
    procedure actClearFilterExecute(Sender: TObject);
    procedure btnShowCharactersClick(Sender: TObject);
    procedure cmbFieldArgChange(Sender: TObject);
    procedure dbgPrivilegesMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure dbgPrivilegesTitleClick(Column: TColumn);
    procedure dbgUsersMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure dbgUsersTitleClick(Column: TColumn);
    procedure edtLocateEnter(Sender: TObject);
    procedure edtLocateExit(Sender: TObject);
    procedure edtLocateKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState
      );
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure pcUsersChange(Sender: TObject);
    procedure zqUserPrivilegesAfterDelete(DataSet: TDataSet);
    procedure zqUserPrivilegesAfterOpen(DataSet: TDataSet);
    procedure zqUserPrivilegesAfterPost(DataSet: TDataSet);
    procedure zqUserPrivilegesAfterScroll(DataSet: TDataSet);
    procedure zqUserPrivilegesBeforeOpen(DataSet: TDataSet);
    procedure zqUserPrivilegesBeforePost(DataSet: TDataSet);
    procedure zqUserPrivilegesNewRecord(DataSet: TDataSet);
    procedure zqUsersAfterDelete(DataSet: TDataSet);
    procedure zqUsersAfterOpen(DataSet: TDataSet);
    procedure zqUsersAfterPost(DataSet: TDataSet);
    procedure zqUsersAfterScroll(DataSet: TDataSet);
    procedure zqUsersBeforeScroll(DataSet: TDataSet);
    procedure zqUsersCalcFields(DataSet: TDataSet);
    procedure zqUsersNewRecord(DataSet: TDataSet);
  private
    { private declarations }
    charArg : String; {name-start with this char}
    fieldArg : String; {locate text from field}
    controlDate : TDate;
    procedure saveBeforeClose;
    procedure showPassword;
    function getControlDate() : TDate;
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
    {control-date}
    procedure setControlDate(thisDate : TDate);
  end;

var
  frmUserPrivileges: TfrmUserPrivileges;
const
  {exception msg}
  ENoUserMsg : String = 'Nije selektovan/izabran korisnik.';
  //**************************** drugs *****************************************
  {fields of tbl app_users}
  F_ID : String = 'AU_ID';
  F_CODE : String = 'AU_CODE';
  F_NAME : String = 'AU_FULL_NAME';
  F_USER : String = 'AU_USER_NAME';
  F_PWD : String = 'AU_USER_PWD';
  F_DEPARTMENT : String = 'AU_DEPARTMENT';
  F_VALID : String = 'AU_VALID';
  //calc fields(boolean) valid
  FC_VALID : String = 'VALID';
  {fields of view app_users_v}
  DEPARTMENT_CODE : String = 'DEPARTMENT_CODE';
  DEPARTMENT_NAME : String = 'DEPARTMENT_NAME';
  {params}
  PARAM_NAME : String = 'AU_FULL_NAME'; {:AU_FULL_NAME}

  //****************************************************************************
  {fields of table USER_PRIVILEGES} //fp- field_privileges
  FP_ID : String = 'UP_ID';
  FP_USER : String = 'UP_USER';
  FP_MODULE : String = 'UP_MODULE';
  FP_PRIVILEGES : String = 'UP_PRIVILEGES';
  FP_CONTROL_DATE : String = 'UP_CONTROL_DATE';
  FP_VALID : String = 'UP_VALID';
  {fields of view hequipment_properties_var_v}
  {existent --||-- + _name}
  MODULE_NAME : String = 'NAME_OF_MODULE';
  MODULE_CODE : String = 'MODULE_CODE';
  {param for privileges}
  PRIVILEGES_PARAM : String = 'UP_USER';
implementation
uses
  uDModule, uConfirm;
{$R *.lfm}

{ TfrmUserPrivileges }

procedure TfrmUserPrivileges.actCharFilterExecute(Sender: TObject);
begin
  {check current page}
  if (not(pcUsers.ActivePageIndex = 0)) then
    begin
      pcUsers.ActivePageIndex:= 0;
      Application.ProcessMessages;
    end;
  {set filter}
  charArg:= cmbCharFilter.Text + '%';
  {apply filter}
  applyCharFilter;
end;

procedure TfrmUserPrivileges.actClearFilterExecute(Sender: TObject);
begin
  {check current page}
  if (not(pcUsers.ActivePageIndex = 0)) then
    begin
      pcUsers.ActivePageIndex:= 0;
      Application.ProcessMessages;
    end;
  {set char-argument}
  charArg:= '%'; {show all}
  applyCharFilter;
  {set cmbCharFilter index}
  cmbCharFilter.Text:= 'Korisnici na slovo ...'; {message like text}
end;

procedure TfrmUserPrivileges.btnShowCharactersClick(Sender: TObject);
begin
  showPassword;
end;

procedure TfrmUserPrivileges.cmbFieldArgChange(Sender: TObject);
begin
  {check current page}
  if (not(pcUsers.ActivePageIndex = 0)) then
    begin
      pcUsers.ActivePageIndex:= 0;
      Application.ProcessMessages;
    end;
  {set field-filter}
  case cmbFieldArg.ItemIndex of
    1: fieldArg:= F_NAME;
    2: fieldArg:= F_USER;
  else
    fieldArg:= F_NAME;
  end;
  {set focus}
  edtLocate.SetFocus;
end;

procedure TfrmUserPrivileges.dbgPrivilegesMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
  {set cursor}
  dbgPrivileges.Cursor:= crHandPoint;
end;

procedure TfrmUserPrivileges.dbgPrivilegesTitleClick(Column: TColumn);
begin
  {sort}
  doSortDbGrid(TZAbstractDataset(zqUserPrivileges), Column);
end;

procedure TfrmUserPrivileges.dbgUsersMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
  {set cursor again}
  dbgUsers.Cursor:= crHandPoint;
end;

procedure TfrmUserPrivileges.dbgUsersTitleClick(Column: TColumn);
var
  recCount, recNo : String;
  recMsg : String = '0 od 0'; {find again recNo}
begin
  {set current page}
  if (not(pcUsers.ActivePageIndex = 0)) then
    begin
      pcUsers.ActivePageIndex:= 0;
      Application.ProcessMessages;
    end;
  {sort}
  doSortDbGrid(TZAbstractDataset(zqUsers), Column);
  {refresh after sort}
  dbgUsers.Refresh;
  { find recNo}
  recCount:= IntToStr(TZAbstractDataset(zqUsers).RecordCount);
  recNo:= IntToStr(TZAbstractDataset(zqUsers).RecNo);
  {create recMsg}
  recMsg:= recNo + ' od ' + recCount;
  edtRecNo.Text:= recMsg;
end;

procedure TfrmUserPrivileges.edtLocateEnter(Sender: TObject);
begin
  {check current page}
  if (not(pcUsers.ActivePageIndex = 0)) then
    begin
      pcUsers.ActivePageIndex:= 0;
      Application.ProcessMessages;
    end;
  {clear text and set font-color}
  edtLocate.Text:= '';
  edtLocate.Font.Color:= clBlack;
end;

procedure TfrmUserPrivileges.edtLocateExit(Sender: TObject);
begin
  {set text and font-color}
  edtLocate.Text:= 'Pronadji ...';
  edtLocate.Font.Color:= clGray;
end;

procedure TfrmUserPrivileges.edtLocateKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  {try to locate}
  if(not TZAbstractDataset(zqUsers).Locate(fieldArg, edtLocate.Text, [loCaseInsensitive, loPartialKey])) then
    begin
      Beep;
      edtLocate.SelectAll;
    end;
end;

procedure TfrmUserPrivileges.FormClose(Sender: TObject;
  var CloseAction: TCloseAction);
begin
  {check for unsaved changes}
  saveBeforeClose;
  inherited;
end;

procedure TfrmUserPrivileges.FormCreate(Sender: TObject);
begin
  {default args}
  charArg:= 'A%';
  fieldArg:= PARAM_NAME; {locate using field_name}
end;

procedure TfrmUserPrivileges.pcUsersChange(Sender: TObject);
var
  recCount, recNo : String;
  recMsg : String = '0 od 0';
begin
  //exception if not drugs
  if(TZAbstractDataset(zqUsers).IsEmpty) then
    if(pcUsers.ActivePageIndex > 0) then
      begin
        pcUsers.ActivePageIndex:= 0;
        Application.ProcessMessages;
        raise TENoUsers.Create(ENoUserMsg);
        Application.ProcessMessages;
        Exit;
      end;
  {else open dataSet}
  case pcUsers.ActivePageIndex of
    0:
       begin
         {enable-disable scrollBtns}
         doAfterOpenDataSet(TZAbstractDataset(zqUsers));
         {show recNo and countRec}
         if(TZAbstractDataset(zqUsers).IsEmpty) then
           begin
             edtRecNo.Text:= recMsg;
             Exit;
           end;
         {find vars}
         recCount:= IntToStr(TZAbstractDataset(zqUsers).RecordCount);
         recNo:= IntToStr(TZAbstractDataset(zqUsers).RecNo);
         {create recMsg}
         recMsg:= recNo + ' od ' + recCount;
         edtRecNo.Text:= recMsg;
       end;
    1:
       begin
         TZAbstractDataset(zqUserPrivileges).DisableControls;
         TZAbstractDataset(zqUserPrivileges).Close;
         TZAbstractDataset(zqUserPrivileges).Open;
         TZAbstractDataset(zqUserPrivileges).EnableControls;
         dbgPrivileges.Refresh;
         Application.ProcessMessages;
       end;
  end;
end;

procedure TfrmUserPrivileges.zqUserPrivilegesAfterDelete(DataSet: TDataSet);
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

procedure TfrmUserPrivileges.zqUserPrivilegesAfterOpen(DataSet: TDataSet);
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

procedure TfrmUserPrivileges.zqUserPrivilegesAfterPost(DataSet: TDataSet);
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

procedure TfrmUserPrivileges.zqUserPrivilegesAfterScroll(DataSet: TDataSet);
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

procedure TfrmUserPrivileges.zqUserPrivilegesBeforeOpen(DataSet: TDataSet);
var
  current_user : Integer;
begin
  //find current
  current_user:= TZAbstractDataset(zqUsers).FieldByName(F_ID).AsInteger;
  TZAbstractDataset(zqUserPrivileges).ParamByName(FP_USER).AsInteger:= current_user;
end;

procedure TfrmUserPrivileges.zqUserPrivilegesBeforePost(DataSet: TDataSet);
var
  current_user : Integer;
begin
  //find current
  current_user:= TZAbstractDataset(zqUsers).FieldByName(F_ID).AsInteger;
  TZAbstractDataset(zqUserPrivileges).FieldByName(FP_USER).AsInteger:= current_user;
end;

procedure TfrmUserPrivileges.zqUserPrivilegesNewRecord(DataSet: TDataSet);
begin
  {set default values}
  TZAbstractDataset(DataSet).FieldByName(FP_CONTROL_DATE).AsDateTime:= getControlDate();
  TZAbstractDataset(DataSet).FieldByName(FP_PRIVILEGES).AsInteger:= 2;
  TZAbstractDataset(DataSet).FieldByName(FP_VALID).AsInteger:= 1;
end;

procedure TfrmUserPrivileges.zqUsersAfterDelete(DataSet: TDataSet);
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

procedure TfrmUserPrivileges.zqUsersAfterOpen(DataSet: TDataSet);
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

procedure TfrmUserPrivileges.zqUsersAfterPost(DataSet: TDataSet);
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
  currText:= TZAbstractDataset(DataSet).FieldByName(F_NAME).AsString;
  {first char to firstChar-var}
  firstChar:= LeftStr(currText, 2); //two chars
  firstChar:= firstChar + '%';
  {compare current charFilter}
  if(charArg <> firstChar) then
    begin
      {save position}
      currId:= TZAbstractDataset(DataSet).FieldByName(F_ID).AsInteger;
      charArg:= firstChar;
      applyCharFilter;
      {locate}
      TZAbstractDataset(DataSet).Locate(F_ID, currId, []);
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

procedure TfrmUserPrivileges.zqUsersAfterScroll(DataSet: TDataSet);
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

procedure TfrmUserPrivileges.zqUsersBeforeScroll(DataSet: TDataSet);
begin
  {check current page}
  if (not(pcUsers.ActivePageIndex = 0)) then
    begin
      pcUsers.ActivePageIndex:= 0;
      Application.ProcessMessages;
    end;
end;

procedure TfrmUserPrivileges.zqUsersCalcFields(DataSet: TDataSet);
begin
  if(DataSet.FieldByName(F_VALID).AsInteger > 0) then
    DataSet.FieldByName(FC_VALID).AsBoolean:= True
  else
    DataSet.FieldByName(FC_VALID).AsBoolean:= False;
end;

procedure TfrmUserPrivileges.zqUsersNewRecord(DataSet: TDataSet);
begin
  {set default values}
  TZAbstractDataset(DataSet).FieldByName(F_VALID).AsFloat:= 1;
end;

procedure TfrmUserPrivileges.saveBeforeClose;
var
  newDlg : TdlgConfirm;
  confirmMsg : String = 'Postoje izmene koje nisu sačuvane!';
  saveAll : Boolean = False;
begin
  {set confirm msg}
  confirmMsg:= confirmMsg + #13#10;
  confirmMsg:= confirmMsg + 'Želite da sačuvamo izmene?';
  if((TZAbstractDataset(zqUsers).State in [dsEdit, dsInsert])
      or
      (TZAbstractDataset(zqUserPrivileges).State in [dsEdit, dsInsert])
     )
  then
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
    begin
      if (TZAbstractDataset(zqUsers).State in [dsEdit, dsInsert]) then
        doSaveRec(TZAbstractDataset(zqUsers)); {app_users dataSet}

      if (TZAbstractDataset(zqUserPrivileges).State in [dsEdit, dsInsert]) then
        doSaveRec(TZAbstractDataset(zqUserPrivileges)); {user_privileges dataSet}
    end;
end;

procedure TfrmUserPrivileges.showPassword;
var
  user_pwd : String = '';
begin
  if(not TZAbstractDataset(zqUsers).FieldByName(F_PWD).IsNull) then
    begin
      user_pwd:= TZAbstractDataset(zqUsers).FieldByName(F_PWD).AsString;
      ShowMessage(user_pwd);
    end;
end;

function TfrmUserPrivileges.getControlDate: TDate;
begin
  result:= controlDate;
end;

procedure TfrmUserPrivileges.onActFirst;
begin
  {jump to first rec}
  case pcUsers.ActivePageIndex of
    0: doFirstRec(TZAbstractDataset(zqUsers));
    1: doFirstRec(TZAbstractDataset(zqUserPrivileges));
  end;
end;

procedure TfrmUserPrivileges.onActPrior;
begin
  {jump to prior rec}
  case pcUsers.ActivePageIndex of
    0: doPriorRec(TZAbstractDataset(zqUsers));
    1: doPriorRec(TZAbstractDataset(zqUserPrivileges));
  end;
end;

procedure TfrmUserPrivileges.onActNext;
begin
  {jump to next rec}
  case pcUsers.ActivePageIndex of
    0: doNextRec(TZAbstractDataset(zqUsers));
    1: doNextRec(TZAbstractDataset(zqUserPrivileges));
  end;
end;

procedure TfrmUserPrivileges.onActLast;
begin
  {jump to last rec}
  case pcUsers.ActivePageIndex of
    0: doLastRec(TZAbstractDataset(zqUsers));
    1: doLastRec(TZAbstractDataset(zqUserPrivileges));
  end;
end;

procedure TfrmUserPrivileges.onActInsert;
begin
  {set focus and insert new rec}
  case pcUsers.ActivePageIndex of
    0:
       begin
         dbName.SetFocus;
         doInsertRec(TZAbstractDataset(zqUsers));
       end;

    1:
       begin
         dblModule.SetFocus;
         doInsertRec(TZAbstractDataset(zqUserPrivileges));
       end;
  end;
end;

procedure TfrmUserPrivileges.onActDelete;
begin
  {delete rec}
  case pcUsers.ActivePageIndex of
    0: doDeleteRec(TZAbstractDataset(zqUsers));
    1: doDeleteRec(TZAbstractDataset(zqUserPrivileges));
  end;
end;

procedure TfrmUserPrivileges.onActEdit;
begin
  {set focus and edit rec}
  case pcUsers.ActivePageIndex of
    0:
       begin
         dbName.SetFocus;
         doEditRec(TZAbstractDataset(zqUsers));
       end;

    1:
       begin
          dblModule.SetFocus;
          doEditRec(TZAbstractDataset(zqUserPrivileges));
        end;
  end;
end;

procedure TfrmUserPrivileges.onActSave;
begin
  {save rec}
  case pcUsers.ActivePageIndex of
    0: doSaveRec(TZAbstractDataset(zqUsers));
    1: doSaveRec(TZAbstractDataset(zqUserPrivileges));
  end;
end;

procedure TfrmUserPrivileges.onActCancel;
begin
  {cancel rec}
  case pcUsers.ActivePageIndex of
    0: doCancelRec(TZAbstractDataset(zqUsers));
    1: doCancelRec(TZAbstractDataset(zqUserPrivileges));
  end;
end;

procedure TfrmUserPrivileges.openRODataSets;
begin
  //module
  zroModule.DisableControls;
  zroModule.Open;
  zroModule.EnableControls;
  //departments
  zroDepartments.DisableControls;
  zroDepartments.Open;
  zroDepartments.EnableControls;
end;

procedure TfrmUserPrivileges.applyCharFilter;
begin
  TZAbstractDataset(zqUsers).DisableControls;
  TZAbstractDataset(zqUsers).Close;
  try
    TZAbstractDataset(zqUsers).ParamByName(PARAM_NAME).AsString:= charArg;
    TZAbstractDataset(zqUsers).Open;
    TZAbstractDataset(zqUsers).EnableControls;
    {show arg in cmbChar}
    //cmbCharFilter.ItemIndex:= cmbCharFilter.Items.IndexOf(LeftStr(charArg, 1)); {without '%'}
  except
    on e : Exception do
    begin
      dModule.zdbh.Rollback;
      TZAbstractDataset(zqUsers).EnableControls;
      ShowMessage(e.Message);
    end;
  end;
end;

procedure TfrmUserPrivileges.setControlDate(thisDate: TDate);
begin
  controlDate:= thisDate;
end;

end.

