@echo off

echo ==============================================================
echo Morar Zivica(exdatis)
echo emis Restore
echo ==============================================================

gbak -replace -v d:\emissoftware-code\fdbBcp\emis.fbk localhost:c:\exdatis\emis.fdb -user sysdba -password Fpc013

pause