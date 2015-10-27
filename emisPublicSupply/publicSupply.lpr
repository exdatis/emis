program publicSupply;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}
  Interfaces, // this includes the LCL widgetset
  Forms, lazcontrols, zcomponent, uPublicSupply, uDModule, uExDatis,
  uBaseDbForm, uConfirm
  { you can add units after this };

{$R *.res}

begin
  Application.Title:='Emis software';
  RequireDerivedFormResource := True;
  Application.Initialize;
  Application.CreateForm(TfrmPublicSupply, frmPublicSupply);
  Application.CreateForm(TdModule, dModule);
  Application.Run;
end.

