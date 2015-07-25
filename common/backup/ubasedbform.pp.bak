unit uBaseDbForm;
{*
 *******************************************************************************
  Morar: base form for all forms which can edit some dataSet
  Ver. 3. 2015-06(y-m)
 *******************************************************************************
*}
{*
 *******************************************************************************
 Morar: Revision(1) added procedure doSortDbGrid(var TzAbstractDataSet and TColumn)
 not used in module GeneralData
 date: 2015-06-20
 *******************************************************************************
*}

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics,
  Dialogs, StdCtrls, ActnList, Buttons, ExtCtrls, ZAbstractDataset, db, DBGrids,
  ZAbstractRODataset;

type

  { TbaseDbForm }

  TbaseDbForm = class(TForm)
    actDb: TActionList;
    actFirst: TAction;
    actInsert: TAction;
    actDelete: TAction;
    actEdit: TAction;
    actCancel: TAction;
    actCloseForm: TAction;
    actSave: TAction;
    actLast: TAction;
    actNext: TAction;
    actPrior: TAction;
    btnDelete: TButton;
    btnEdit: TButton;
    btnCancel: TButton;
    btnCloseForm: TButton;
    btnLast: TButton;
    btnNext: TButton;
    btnPrior: TButton;
    btnSave: TButton;
    btnInsert: TButton;
    btnFirst: TButton;
    edtRecNo: TEdit;
    groupBoxBtns: TGroupBox;
    lblBaseDbTitle: TLabel;
    procedure actCancelExecute(Sender: TObject);
    procedure actCloseFormExecute(Sender: TObject);
    procedure actDeleteExecute(Sender: TObject);
    procedure actEditExecute(Sender: TObject);
    procedure actFirstExecute(Sender: TObject);
    procedure actInsertExecute(Sender: TObject);
    procedure actLastExecute(Sender: TObject);
    procedure actNextExecute(Sender: TObject);
    procedure actPriorExecute(Sender: TObject);
    procedure actSaveExecute(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
  private
    { private declarations }

  public
    { public declarations }
    {dataSet actions}
    procedure doFirstRec(var dataSet : TZAbstractDataset);
    procedure doPriorRec(var dataSet : TZAbstractDataset);
    procedure doNextRec(var dataSet : TZAbstractDataset);
    procedure doLastRec(var dataSet : TZAbstractDataset);
    procedure doInsertRec(var dataSet : TZAbstractDataset);
    procedure doDeleteRec(var dataSet : TZAbstractDataset);
    procedure doEditRec(var dataSet : TZAbstractDataset);
    procedure doSaveRec(var dataSet : TZAbstractDataset);
    procedure doCancelRec(var dataSet : TZAbstractDataset);
    {actions after open(dataSet)}
    procedure doAfterOpenDataSet(var dataSet : TZAbstractDataset);
    {sort grid}
    procedure doSortDbGrid(var dataSet : TZAbstractDataset; Column : TColumn);
    {enable-disable btns}
    procedure disableScrollBtns;
    procedure enableScrollBtns;
    {abstract procedure onDbEvent}
    procedure onActFirst; virtual; abstract;
    procedure onActPrior; virtual; abstract;
    procedure onActNext; virtual; abstract;
    procedure onActLast; virtual; abstract;
    procedure onActInsert; virtual; abstract;
    procedure onActDelete; virtual; abstract;
    procedure onActEdit; virtual; abstract;
    procedure onActSave; virtual; abstract;
    procedure onActCancel; virtual; abstract;
  end;

var
  baseDbForm: TbaseDbForm;

implementation
uses
  uConfirm;
{$R *.lfm}

{ TbaseDbForm }

procedure TbaseDbForm.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  {free and nil}
  CloseAction:= caFree;
  self:= nil;
end;

procedure TbaseDbForm.doFirstRec(var dataSet: TZAbstractDataset);
begin
  {jump to first rec if not bof}
  if(not TZAbstractDataset(dataSet).IsEmpty) then
    begin
      if(not TZAbstractDataset(dataSet).BOF) then
        begin
          TZAbstractDataset(dataSet).First;
          {check again}
          if(not TZAbstractDataset(dataSet).BOF) then
            begin
              actFirst.Enabled:= True;
              actPrior.Enabled:= True;
              actNext.Enabled:= True;
              actLast.Enabled:= True;
            end
          else
            begin
              actFirst.Enabled:= False;
              actPrior.Enabled:= False;
              actNext.Enabled:= True;
              actLast.Enabled:= True;
            end
        end;
    end
  else
    disableScrollBtns; {empty dataSet}
end;

procedure TbaseDbForm.doPriorRec(var dataSet: TZAbstractDataset);
begin
  {jump to prior rec if not bof}
  if(not TZAbstractDataset(dataSet).IsEmpty) then
    begin
      if(not TZAbstractDataset(dataSet).BOF) then
        begin
          TZAbstractDataset(dataSet).Prior;
          {check again}
          if(not TZAbstractDataset(dataSet).BOF) then
            begin
              actFirst.Enabled:= True;
              actPrior.Enabled:= True;
              actNext.Enabled:= True;
              actLast.Enabled:= True;
            end
          else
            begin
              actFirst.Enabled:= False;
              actPrior.Enabled:= False;
              actNext.Enabled:= True;
              actLast.Enabled:= True;
            end
        end;
    end
  else
    disableScrollBtns; {empty dataSet}
end;

procedure TbaseDbForm.doNextRec(var dataSet: TZAbstractDataset);
begin
  {jump to next rec if not eof}
  if(not TZAbstractDataset(dataSet).IsEmpty) then
    begin
      if(not TZAbstractDataset(dataSet).EOF) then
        begin
          TZAbstractDataset(dataSet).Next;
          {check again}
          if(not TZAbstractDataset(dataSet).EOF) then
            begin
              actFirst.Enabled:= True;
              actPrior.Enabled:= True;
              actNext.Enabled:= True;
              actLast.Enabled:= True;
            end
          else
            begin
              actFirst.Enabled:= True;
              actPrior.Enabled:= True;
              actNext.Enabled:= False;
              actLast.Enabled:= False;
            end
        end;
    end
  else
    disableScrollBtns; {empty dataSet}
end;

procedure TbaseDbForm.doLastRec(var dataSet: TZAbstractDataset);
begin
  {jump to last rec if not eof}
  if(not TZAbstractDataset(dataSet).IsEmpty) then
    begin
      if(not TZAbstractDataset(dataSet).EOF) then
        begin
          TZAbstractDataset(dataSet).Last;
          {check again}
          if(not TZAbstractDataset(dataSet).EOF) then
            begin
              actFirst.Enabled:= True;
              actPrior.Enabled:= True;
              actNext.Enabled:= True;
              actLast.Enabled:= True;
            end
          else
            begin
              actFirst.Enabled:= True;
              actPrior.Enabled:= True;
              actNext.Enabled:= False;
              actLast.Enabled:= False;
            end
        end;
    end
  else
    disableScrollBtns; {empty dataSet}
end;

procedure TbaseDbForm.doInsertRec(var dataSet: TZAbstractDataset);
begin
  {new record - insert}
  if TZAbstractDataset(dataSet).Active then
    begin
      TZAbstractDataset(dataSet).Insert;
      {disable scrollBtns}
      disableScrollBtns;
      {command btns}
      actInsert.Enabled:= False;
      actDelete.Enabled:= False;
      actEdit.Enabled:= False;
      actSave.Enabled:= True;
      actCancel.Enabled:= True;
    end;
end;

procedure TbaseDbForm.doDeleteRec(var dataSet: TZAbstractDataset);
var
  newDlg : TdlgConfirm;
  confirmMsg : String = 'Sigurno brišete slog ?';
begin
  {update confirm msg}
  confirmMsg:= confirmMsg + #13#10;
  confirmMsg:= confirmMsg + '(Trajno brisanje zpisa)';
  if(TZAbstractDataset(dataSet).RecordCount < 1) then
    Exit; {empty dataSet}
  if(not(TZAbstractDataset(dataSet).State in [dsBrowse])) then
    Exit;
  {else show confirm msg}
  newDlg:= TdlgConfirm.Create(nil);
  {set msgText}
  newDlg.memoMsg.Lines.Text:= confirmMsg;
  {ask user to confirm}
  if(newDlg.ShowModal = mrOK) then
    begin
      TZAbstractDataset(dataSet).Delete;
      {check dataSet}
      if(not TZAbstractDataset(dataSet).IsEmpty) then
        begin
          {enable user to scroll}
          enableScrollBtns;
          {enable edit, insert or delete}
          actInsert.Enabled:= True;
          actDelete.Enabled:= True;
          actEdit.Enabled:= True;
          {disable save and cancel}
          actCancel.Enabled:= False;
          actSave.Enabled:= False;
        end
      else
        begin
          {disable user to scroll}
          disableScrollBtns;
          {enable insert}
          actInsert.Enabled:= True;
          actDelete.Enabled:= True;
          actEdit.Enabled:= True;
          {disable save, cancel, delete and edit}
          actCancel.Enabled:= False;
          actSave.Enabled:= False;
          actDelete.Enabled:= False;
          actEdit.Enabled:= False;
        end;
    end;
    {finally free dialog}
    newDlg.Free;
end;

procedure TbaseDbForm.doEditRec(var dataSet: TZAbstractDataset);
begin
  {check dataSet}
  if(not TZAbstractDataset(dataSet).IsEmpty) then
    if(TZAbstractDataset(dataSet).State in [dsBrowse]) then
      begin
        TZAbstractDataset(dataSet).Edit;
        {disable user to scroll}
        disableScrollBtns;
        {disable edit, insert or delete}
        actInsert.Enabled:= False;
        actDelete.Enabled:= False;
        actEdit.Enabled:= False;
        {enable save and cancel}
        actCancel.Enabled:= True;
        actSave.Enabled:= True;
      end;
end;

procedure TbaseDbForm.doSaveRec(var dataSet: TZAbstractDataset);
begin
  {check dataSet state}
  if(TZAbstractDataset(dataSet).State in [dsInsert, dsEdit]) then
    begin
      {save changes}
      TZAbstractDataset(dataSet).Post;
      {enable user to scroll}
      enableScrollBtns;
      {enable edit, insert or delete}
      actInsert.Enabled:= True;
      actDelete.Enabled:= True;
      actEdit.Enabled:= True;
      {disable save and cancel}
      actCancel.Enabled:= False;
      actSave.Enabled:= False;
    end;
end;

procedure TbaseDbForm.doCancelRec(var dataSet: TZAbstractDataset);
begin
{check dataSet state}
if(TZAbstractDataset(dataSet).State in [dsInsert, dsEdit]) then
  begin
    {save changes}
    TZAbstractDataset(dataSet).Cancel;
    {count records}
    if(not TZAbstractDataset(dataSet).IsEmpty) then
      begin
        {enable user to scroll}
        enableScrollBtns;
        {enable edit, insert or delete}
        actInsert.Enabled:= True;
        actDelete.Enabled:= True;
        actEdit.Enabled:= True;
        {disable save and cancel}
        actCancel.Enabled:= False;
        actSave.Enabled:= False;
      end
    else
      begin
        {disable user to scroll}
        disableScrollBtns;
        {enable insert}
        actInsert.Enabled:= True;
        {disable save, cancel, delete and edit}
        actCancel.Enabled:= False;
        actSave.Enabled:= False;
        actDelete.Enabled:= False;
        actEdit.Enabled:= False;
      end;
  end;
end;

procedure TbaseDbForm.doAfterOpenDataSet(var dataSet: TZAbstractDataset);
begin
  {count records}
  if(not TZAbstractDataset(dataSet).IsEmpty) then
    begin
      {enable scrollBtns}
      enableScrollBtns;
      {enable insert, delete, edit}
      actInsert.Enabled:= True;
      actDelete.Enabled:= True;
      actEdit.Enabled:= True;
      {disable cancel and save}
      actCancel.Enabled:= False;
      actSave.Enabled:= False;
    end
  else
    begin
      {disable scrollBtns}
      disableScrollBtns;
      {enable insert}
      actInsert.Enabled:= True;
      {disable cancel, save, delete, edit}
      actCancel.Enabled:= False;
      actSave.Enabled:= False;
      actDelete.Enabled:= False;
      actEdit.Enabled:= False;
    end;
end;

procedure TbaseDbForm.doSortDbGrid(var dataSet: TZAbstractDataset;
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

procedure TbaseDbForm.disableScrollBtns;
begin
  {disable scroll actions}
  actFirst.Enabled:= False;
  actPrior.Enabled:= False;
  actNext.Enabled:= False;
  actLast.Enabled:= False;
end;

procedure TbaseDbForm.enableScrollBtns;
begin
  {enable scroll actions}
  actFirst.Enabled:= True;
  actPrior.Enabled:= True;
  actNext.Enabled:= True;
  actLast.Enabled:= True;
end;

procedure TbaseDbForm.actFirstExecute(Sender: TObject);
begin
  {virtual-abstract override procedure}
  onActFirst;
end;

procedure TbaseDbForm.actDeleteExecute(Sender: TObject);
begin
  {virtual-abstract override procedure}
  onActDelete;
end;

procedure TbaseDbForm.actCancelExecute(Sender: TObject);
begin
  {virtual-abstract override procedure}
  onActCancel;
end;

procedure TbaseDbForm.actCloseFormExecute(Sender: TObject);
begin
  {close form}
  self.Close;
end;

procedure TbaseDbForm.actEditExecute(Sender: TObject);
begin
  {virtual-abstract override procedure}
  onActEdit;
end;

procedure TbaseDbForm.actInsertExecute(Sender: TObject);
begin
  {virtual-abstract override procedure}
  onActInsert;
end;

procedure TbaseDbForm.actLastExecute(Sender: TObject);
begin
  {virtual-abstract override procedure}
  onActLast;
end;

procedure TbaseDbForm.actNextExecute(Sender: TObject);
begin
  {virtual-abstract override procedure}
  onActNext;
end;

procedure TbaseDbForm.actPriorExecute(Sender: TObject);
begin
  {virtual-abstract override procedure}
  onActPrior;
end;

procedure TbaseDbForm.actSaveExecute(Sender: TObject);
begin
  {virtual-abstract override procedure}
  onActSave;
end;

end.

