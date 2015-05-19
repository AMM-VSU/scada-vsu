Необходимо добавить файлы scadasrv, scadacomm в /etc/init.d
Далее для регистрации демонов необходимо выполнить следующие команды: 

sudo update-rc.d scadasrv defaults 97 03    
sudo update-rc.d scadacomm defaults 98 02

Числа 97, 98 отвечают за порядок запуска при включении, 03 и 02 за порядок остановки при выключении системы.

sudo service scadacomm start - запуск демона с именем scadacomm

sudo service scadacomm stop - остановка

sudo service scadacomm restart - перезапуск

sudo update-rc.d -f test_script  remove - отмена регистрации демона с именем test_script
