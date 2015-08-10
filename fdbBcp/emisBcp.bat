@echo off

echo ==============================================================
echo Morar Zivica(exdatis)
echo emis backUp
echo ==============================================================

gbak -b -g -v localhost:c:\exdatis\emis25.fdb d:\emissoftware-code\fdbBcp\emis25.fbk -user sysdba -password masterkey

pause