program emisGeneral;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}
  Interfaces, // this includes the LCL widgetset
  Forms, uDModule, uGeneral, lazcontrols, zcomponent, uBaseDbForm, uConfirm,
  uLogin, uLocation, uDocWarehouseIn, uDocWarehouseOut, uDocSOInput,
  uDocSOOutput, uDocBuying, uDocSell, uDocContract, uMeasure, uDrugForms,
  uDocMedicalInput, uDocMedicalOutput, uDocMedicalOrders, uDocLab, uDocPayment,
  uDocOutgoings, uDocFinance, uDocRequisition, uDocReservation, uTaxes,
  uSuppliers, uDonors, uDrugNomenclatures, uGenerics, uPropertiesOfDrug,
  uDrugGroups, uDrugs, uPharmacyMaterialGroup, uPropertiesOfPHMaterial,
  uPharmacyMaterial, uPropertiesOfAppliances, uAppliancesGroup,
  uMedicineAppliances, uHEquipmentGroup, uPropertiesOfHEquipment,
  uHospitalEquipment, uPropertiesOfFood, uFoodGroups, uFood,
  upropertiesOfOfficeM, uOfficeMGroups, uOfficeMaterial, uPropertiesOfMaterials,
  uMaterialsGroup, uMaterialsAccessories, uHygieneProperties, uHygieneGroups,
  uHygieneMaterial, uSServicesGroups, uSupplyServices, uExDatisShare;

{$R *.res}

begin
  Application.Title:='Emis software';
  RequireDerivedFormResource := True;
  Application.Initialize;
  Application.CreateForm(TfrmGeneral, frmGeneral);
  Application.CreateForm(TdModule, dModule);
  //Application.CreateForm(TfrmSupplyServices, frmSupplyServices);
  //Application.CreateForm(TfrmSServicesGroups, frmSServicesGroups);
  //Application.CreateForm(TfrmHygieneMaterial, frmHygieneMaterial);
  //Application.CreateForm(TfrmHygieneGroups, frmHygieneGroups);
  //Application.CreateForm(TfrmHygieneProperties, frmHygieneProperties);
  //Application.CreateForm(TfrmMaterialsAccessories, frmMaterialsAccessories);
  //Application.CreateForm(TfrmMaterialsGroup, frmMaterialsGroup);
  //Application.CreateForm(TfrmPropertiesOfMaterials, frmPropertiesOfMaterials);
  //Application.CreateForm(TfrmOfficeMaterial, frmOfficeMaterial);
  //Application.CreateForm(TfrmOfficeMGroups, frmOfficeMGroups);
  //Application.CreateForm(TfrmPropertiesOfOfficeM, frmPropertiesOfOfficeM);
  //Application.CreateForm(TfrmFood, frmFood);
  //Application.CreateForm(TfrmFoodGroups, frmFoodGroups);
  //Application.CreateForm(TfrmPropertiesOfFood, frmPropertiesOfFood);
  //Application.CreateForm(TfrmHospitalEquipment, frmHospitalEquipment);
  //Application.CreateForm(TfrmPropertiesOfHEquipment, frmPropertiesOfHEquipment);
  //Application.CreateForm(TfrmHEquipmentGroup, frmHEquipmentGroup);
  //Application.CreateForm(TfrmMedicineAppliances, frmMedicineAppliances);
  //Application.CreateForm(TfrmAppliancesGroup, frmAppliancesGroup);
  //Application.CreateForm(TfrmPharmacyMaterial, frmPharmacyMaterial);
  //Application.CreateForm(TfrmPropertiesOfAppliances, frmPropertiesOfAppliances);
  //Application.CreateForm(TfrmPropertiesOfPHMaterial, frmPropertiesOfPHMaterial);
  //Application.CreateForm(TfrmPharmacyMaterialGroup, frmPharmacyMaterialGroup);
  //Application.CreateForm(TfrmDrugs, frmDrugs);
  //Application.CreateForm(TfrmDrugGroups, frmDrugGroups);
  //Application.CreateForm(TfrmGenerics, frmGenerics);
  //Application.CreateForm(TfrmPropertiesOfDrug, frmPropertiesOfDrug);
  //Application.CreateForm(TfrmDrugNomenclatures, frmDrugNomenclatures);
  //Application.CreateForm(TfrmSuppliers, frmSuppliers);
  //Application.CreateForm(TfrmDonors, frmDonors);
  //Application.CreateForm(TfrmTaxes, frmTaxes);
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

