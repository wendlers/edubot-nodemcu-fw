#include <ESP8266WiFi.h>
#include <ESP8266mDNS.h>
#include <DNSServer.h>

#include "WiFiManager.h"
#include "webserver.h"
#include "gear.h"
#include "range.h"
#include "Adafruit_NeoPixel.h"

// const char* ssid = _SSID_;
// const char* password = _WIFI_PASSWORD_;

MDNSResponder mdns;

WebServer &server = WebServer::instance();
Gear gear(5, 0, 4, 2);
Range range(14, 12);
// Adafruit_NeoPixel pixels = Adafruit_NeoPixel(8, 10, NEO_GRB + NEO_KHZ800);
Adafruit_NeoPixel pixels(8, 10, NEO_GRB + NEO_KHZ800);


void setup(void) {

    Serial.begin(115200);

	/*
    WiFi.begin(ssid, password);
    Serial.println("");

    // Wait for connection
    while (WiFi.status() != WL_CONNECTED) {
        delay(500);
        Serial.print(".");
    }

    Serial.println("");
    Serial.print("Connected to ");
    Serial.println(ssid);
    Serial.print("IP address: ");
    Serial.println(WiFi.localIP());
	*/

	WiFiManager wifiManager;
	wifiManager.autoConnect("edubot", "edubot");

    if (mdns.begin(_MDNS_NAME_, WiFi.localIP())) {
        Serial.println("MDNS responder started");
    }

    server.begin();
    Serial.println("HTTP server started");

	pixels.begin();
}

void loop(void) {

    server.handleClient();
	range.update();
}

