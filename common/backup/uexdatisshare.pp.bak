unit uExDatisShare;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, uGeneral, Graphics;

procedure showConnectionStatus(connected : Boolean);

implementation

procedure showConnectionStatus(connected : Boolean);
begin
  if connected then
    begin
      frmGeneral.stConnectionStatus.Caption:= 'Connected';
      frmGeneral.BGRALEDConnection.Color:= clMoneyGreen;
    end
  else
    begin
      frmGeneral.stConnectionStatus.Caption:= 'Disconnected';
      frmGeneral.BGRALEDConnection.Color:= clGray;
    end;
end;

end.

