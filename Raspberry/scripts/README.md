Необходимо добавить файлы scadasrv, scadacomm в /etc/init.d и СДЕЛАТЬ их исполняемыми командой 
sudo chmod +x filename
Далее для регистрации демонов необходимо выполнить следующие команды: 

sudo update-rc.d scadasrv defaults 97 03    
sudo update-rc.d scadacomm defaults 98 02

Или просто sudo update-rc.d scadasrv defaults как здесь: http://www.neil-black.co.uk/raspberry-pi-beginners-guide#.VVru5_ntlBc

Числа 97, 98 отвечают за порядок запуска при включении, 03 и 02 за порядок остановки при выключении системы (точнее за приоритет).

sudo service scadacomm start - запуск демона с именем scadacomm

sudo service scadacomm stop - остановка

sudo service scadacomm restart - перезапуск

sudo update-rc.d -f test_script  remove - отмена регистрации демона с именем test_script


Для использования скрипта перезапуска restart.sh необходимо сначала сделать его исполняемым (sudo chmod +x restart.sh), выполнять как обычно: ./restart.sh
