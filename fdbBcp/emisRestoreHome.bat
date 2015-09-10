@echo off

echo ==============================================================
echo Morar Zivica(exdatis)
echo emis Restore - home ver.
echo ==============================================================

REM emissoftware-

gbak -replace -v c:\emis\fdbBcp\emis25.fbk localhost:c:\exdatis\emis25.fdb -user sysdba -password masterkey

pause