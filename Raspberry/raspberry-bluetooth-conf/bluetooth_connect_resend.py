import serial
from time import sleep
 
while True:
    try:
        bluetoothSerial = serial.Serial( "/dev/rfcomm2", baudrate=9600 )
        s = bluetoothSerial.readline()
        print s
        bluetoothSerial = serial.Serial("/dev/rfcomm1", baudrate=9600)
        bluetoothSerial.write(s)
    except:
        pass
