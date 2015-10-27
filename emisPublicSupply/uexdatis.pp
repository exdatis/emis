unit uExDatis;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, uPublicSupply, Graphics;

procedure showConnectionStatus(connected : Boolean);

implementation

procedure showConnectionStatus(connected : Boolean);
begin
  //lp
  if connected then
    begin
      frmPublicSupply.stConnectionStatus.Caption:= 'Connected';
      frmPublicSupply.BGRALEDConnection.Color:= clTeal;
    end
  else
    begin
      frmPublicSupply.stConnectionStatus.Caption:= 'Disconnected';
      frmPublicSupply.BGRALEDConnection.Color:= clRed;
    end;
end;

end.

