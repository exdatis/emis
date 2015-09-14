program emisGeneral;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}
  Interfaces, // this includes the LCL widgetset
  Forms, uDModule, uGeneral, lazcontrols, zcomponent, uBaseDbForm, uConfirm,
  uLocation, uDocWarehouseIn, uDocWarehouseOut, uDocSOInput, uDocSOOutput,
  uDocBuying, uDocSell, uDocContract, uMeasure, uDrugForms, uDocMedicalInput,
  uDocMedicalOutput, uDocMedicalOrders, uDocLab, uDocPayment, uDocOutgoings,
  uDocFinance, uDocRequisition, uDocReservation;

{$R *.res}

begin
  Application.Title:='Emis software';
  RequireDerivedFormResource := True;
  Application.Initialize;
  Application.CreateForm(TfrmGeneral, frmGeneral);
  Application.CreateForm(TdModule, dModule);
  //Application.CreateForm(TfrmDocSOOutput, frmDocSOOutput);
  //Application.CreateForm(TfrmDocSOInput, frmDocSOInput);
  //Application.CreateForm(TfrmDocWarehouseOut, frmDocWarehouseOut);
  //Application.CreateForm(TfrmDocWarehouseIn, frmDocWarehouseIn);
  //Application.CreateForm(TdlgConfirm, dlgConfirm);
  //Application.CreateForm(TfrmLocation, frmLocation);
  //Application.CreateForm(TbaseDbForm, baseDbForm);
  //Application.CreateForm(TfrmDocReservation, frmDocReservation);
  //Application.CreateForm(TfrmDocRequisition, frmDocRequisition);
  //Application.CreateForm(TfrmDocFinance, frmDocFinance);
  //Application.CreateForm(TfrmDocOutgoings, frmDocOutgoings);
  //Application.CreateForm(TfrmDocPayment, frmDocPayment);
  //Application.CreateForm(TfrmDocLab, frmDocLab);
  //Application.CreateForm(TfrmDocMedicalOrders, frmDocMedicalOrders);
  //Application.CreateForm(TfrmDocMedicalOutput, frmDocMedicalOutput);
  //Application.CreateForm(TfrmDocMedicalInput, frmDocMedicalInput);
  //Application.CreateForm(TfrmDrugForms, frmDrugForms);
  //Application.CreateForm(TfrmMeasure, frmMeasure);
  //Application.CreateForm(TfrmDocContract, frmDocContract);
  //Application.CreateForm(TfrmDocSell, frmDocSell);
  //Application.CreateForm(TfrmDocBuying, frmDocBuying);
  Application.Run;
end.

