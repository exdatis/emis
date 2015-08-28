program org;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}
  Interfaces, // this includes the LCL widgetset
  Forms, uorg, lazcontrols, uDModule, uBaseDbForm, uConfirm, zcomponent, 
uhospital, uDepartment, uDrugWarehouse
  { you can add units after this };

{$R *.res}

begin
  Application.Title:='Emis software';
  RequireDerivedFormResource := True;
  Application.Initialize;
  Application.CreateForm(TfrmOrg, frmOrg);
  Application.CreateForm(TdModule, dModule);
  //Application.CreateForm(TfrmHospital, frmHospital);
  //Application.CreateForm(TfrmDepartment, frmDepartment);
  //Application.CreateForm(TfrmDrugWarehouse, frmDrugWarehouse);
  Application.Run;
end.

