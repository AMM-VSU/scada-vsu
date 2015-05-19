#include "dht.h"

String str;
DHT sensor = DHT();
int temperature;
int humidity;

void setup() {
    Serial.begin(9600);
    sensor.attach(A0);
    delay(1000);
}

void loop() {


}

int getDataFromDht(int& temp, int& hum) {
    sensor.update();
    
    int result = sensor.getLastError();
    switch (result)
    {
        case DHT_ERROR_OK:
            temp = sensor.getTemperatureInt();
            hum = sensor.getHumidityInt();
            break;
        case DHT_ERROR_START_FAILED_1:
            //Serial.println("Error: start failed (stage 1)");
            break;
        case DHT_ERROR_START_FAILED_2:
            //Serial.println("Error: start failed (stage 2)");
            break;
        case DHT_ERROR_READ_TIMEOUT:
            //Serial.println("Error: read timeout");
            break;
        case DHT_ERROR_CHECKSUM_FAILURE:
            //Serial.println("Error: checksum error");
            break;
    }  
    return result;
  
}

void serialEvent() {
    str = Serial.readStringUntil('\n');
    if (str == "request") {
        digitalWrite(13, HIGH);
        if (getDataFromDht(temperature, humidity) == DHT_ERROR_OK) {
            char msg[128];
            sprintf(msg, "ok;%d;%d;%d", temperature, humidity, temperature+humidity);
            Serial.println(msg);
        } else
            Serial.println("error;0;0;0");
        digitalWrite(13, LOW);
    } else
        Serial.println("error;0;0;0");
}
