Необходимо добавить файлы scadasrv, scadacomm в /etc/init.d и СДЕЛАТЬ их исполнительными: команда sudo chmod +x filename
Далее для регистрации демонов необходимо выполнить следующие команды: 

sudo update-rc.d scadasrv defaults 97 03    
sudo update-rc.d scadacomm defaults 98 02

Или просто sudo update-rc.d scadasrv defaults как здесь: http://www.neil-black.co.uk/raspberry-pi-beginners-guide#.VVru5_ntlBc

Числа 97, 98 отвечают за порядок запуска при включении, 03 и 02 за порядок остановки при выключении системы (точнее за приоритет).

sudo service scadacomm start - запуск демона с именем scadacomm

sudo service scadacomm stop - остановка

sudo service scadacomm restart - перезапуск

sudo update-rc.d -f test_script  remove - отмена регистрации демона с именем test_script


Для скрипта restart.sh перед первым запуском его необходимо сделать исполнимым, для этого нужно выполнить команду sudo chmod +x restart.sh. Запускать скрипт ./restart.sh
