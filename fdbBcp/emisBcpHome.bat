@echo off

echo ==============================================================
echo Morar Zivica(exdatis)
echo emis backUp - home PC
echo ==============================================================

gbak -b -g -v localhost:c:\exdatis\emis25.fdb c:\emis\fdbBcp\emis25.fbk -user sysdba -password masterkey

pause