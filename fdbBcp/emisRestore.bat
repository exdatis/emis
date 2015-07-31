@echo off

echo ==============================================================
echo Morar Zivica(exdatis)
echo emis Restore
echo ==============================================================

REM emissoftware-

gbak -replace -v d:\code\fdbBcp\emis.fbk localhost:c:\exdatis\emis.fdb -user sysdba -password Fpc013

pause