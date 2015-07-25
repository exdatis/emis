@echo off

echo ==============================================================
echo Morar Zivica(exdatis)
echo emis backUp
echo ==============================================================

gbak -b -g -v localhost:c:\exdatis\emis.fdb d:\emissoftware-code\fdbBcp\emis.fbk -user sysdba -password Fpc013

pause