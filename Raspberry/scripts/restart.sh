#!/bin/bash
echo "Restarting SCADA..."
sudo service scadacomm stop
sudo service scadasrv stop
sudo service scadasrv start
sudo service scadacomm start
