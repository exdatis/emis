program admin;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}
  Interfaces, // this includes the LCL widgetset
  Forms, lazcontrols, datetimectrls, zcomponent, uAdmin, uDModule, uExDatis,
  uBaseDbForm, uConfirm, uModule, uUserPrivileges, uReportBase, uDbIni
  { you can add units after this };

{$R *.res}

begin
  Application.Title:='ExDatis';
  RequireDerivedFormResource := True;
  Application.Initialize;
  Application.CreateForm(TfrmAdmin, frmAdmin);
  Application.CreateForm(TdModule, dModule);
  Application.CreateForm(TfrmReportBase, frmReportBase);
  Application.CreateForm(TfrmDbIni, frmDbIni);
  //Application.CreateForm(TfrmUserPrivileges, frmUserPrivileges);
  //Application.CreateForm(TfrmModule, frmModule);
  Application.Run;
end.

