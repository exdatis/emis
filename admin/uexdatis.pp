unit uExDatis;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, uAdmin, Graphics;

procedure showConnectionStatus(connected : Boolean);

implementation

procedure showConnectionStatus(connected : Boolean);
begin
  //lp generalData
  if connected then
    begin
      frmAdmin.stConnectionStatus.Caption:= 'Connected';
      frmAdmin.BGRALEDConnection.Color:= clTeal;
    end
  else
    begin
      frmAdmin.stConnectionStatus.Caption:= 'Disconnected';
      frmAdmin.BGRALEDConnection.Color:= clRed;
    end;
end;
end.

