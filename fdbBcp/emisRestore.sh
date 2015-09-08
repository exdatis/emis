#!/bin/sh
echo "=============================================================="
echo "Morar Zivica(exdatis)"
echo "emis Restore"
echo "=============================================================="



gbak -replace -v /home/exdatis/emis/fdbBcp/emis25.fbk localhost:/home/exdatis/exdatis/emis25.fdb -user sysdba -password masterkey

# read -p "Press [Enter] key to exit..."
