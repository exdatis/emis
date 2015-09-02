@echo off

echo ==============================================================
echo Morar Zivica(exdatis)
echo emis Restore
echo ==============================================================

REM emissoftware-

gbak -replace -v d:\emissoftware-code\fdbBcp\emis25.fbk localhost:c:\exdatis\emis25.fdb -user sysdba -password masterkey

pause