#!/bin/sh
echo "=============================================================="
echo "Morar Zivica(exdatis)"
echo "emis Restore"
echo "=============================================================="



gbak -replace -v /home/morar/emis/fdbBcp/emis25.fbk localhost:/home/morar/exdatis/emis25.fdb -user sysdba -password masterkey

# read -p "Press [Enter] key to exit..."
