program emisGeneral;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}
  Interfaces, // this includes the LCL widgetset
  Forms, uDModule, uGeneral, lazcontrols, zcomponent, uBaseDbForm, uConfirm,
  uLocation, uDocWarehouseIn
  { you can add units after this };

{$R *.res}

begin
  Application.Title:='Emis software';
  RequireDerivedFormResource := True;
  Application.Initialize;
  Application.CreateForm(TfrmGeneral, frmGeneral);
  Application.CreateForm(TdModule, dModule);
  //Application.CreateForm(TfrmDocWarehouseIn, frmDocWarehouseIn);
  //Application.CreateForm(TdlgConfirm, dlgConfirm);
  //Application.CreateForm(TfrmLocation, frmLocation);
  //Application.CreateForm(TbaseDbForm, baseDbForm);
  Application.Run;
end.

