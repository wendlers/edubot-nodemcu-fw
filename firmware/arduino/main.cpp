#include <ESP8266WiFi.h>
#include <ESP8266mDNS.h>
#include <DNSServer.h>

#include "WiFiManager.h"
#include "webserver.h"
#include "gear.h"
#include "range.h"
// #include "Adafruit_NeoPixel.h"

const char* ssid = _SSID_;
const char* password = _WIFI_PASSWORD_;

MDNSResponder mdns;

WebServer &server = WebServer::instance();
Gear gear(5, 0, 4, 2);
Range range(14, 12);
// Adafruit_NeoPixel pixels(8, 10, NEO_GRB + NEO_KHZ800);

#define WIFI_MODE_PIN  13

void setup(void) {

    Serial.begin(115200);

	Serial.println("");
	Serial.println("** EduBot, sw@kaltpost.de **");

    pinMode(WIFI_MODE_PIN, INPUT_PULLUP);

    if(digitalRead(WIFI_MODE_PIN) == LOW) {
        // use WiFi-Manager for network connection to STA
        Serial.println("Using WiFi-Manager");

        WiFiManager wifiManager;
        wifiManager.autoConnect(_SSID_, _WIFI_PASSWORD_);
    }
    else {
        // create own AP
        Serial.println("Using own AP");

        WiFi.mode(WIFI_AP);
        WiFi.softAP(_SSID_, _WIFI_PASSWORD_);	
    }

    if (mdns.begin(_MDNS_NAME_, WiFi.localIP())) {
        Serial.println("MDNS responder started");
    }

    server.begin();
    Serial.println("HTTP server started");

//	pixels.begin();
}

void loop(void) {

    server.handleClient();
	range.update();
}

