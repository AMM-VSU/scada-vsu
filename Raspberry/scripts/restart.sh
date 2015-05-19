#!/bin/bash
echo "Restarting SCADA..."
sudo service scadasrv restart
sudo service scadacomm restart
