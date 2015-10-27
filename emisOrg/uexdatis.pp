unit uExDatis;
{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, uorg, Graphics;

procedure showConnectionStatus(connected : Boolean);

implementation

procedure showConnectionStatus(connected : Boolean);
begin
  //lp generalData
  if connected then
    begin
      frmOrg.stConnectionStatus.Caption:= 'Connected';
      frmOrg.BGRALEDConnection.Color:= clTeal;
    end
  else
    begin
      frmOrg.stConnectionStatus.Caption:= 'Disconnected';
      frmOrg.BGRALEDConnection.Color:= clRed;
    end;
end;

end.

