#include <ESP8266WiFi.h>
#include <ESP8266mDNS.h>

#include "webserver.h"
#include "gear.h"

const char* ssid = _SSID_;
const char* password = _WIFI_PASSWORD_;

MDNSResponder mdns;

WebServer &server = WebServer::instance();
Gear gear(5, 0, 4, 2);

void setup(void) {

    Serial.begin(115200);
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

    if (mdns.begin("esp8266", WiFi.localIP())) {
        Serial.println("MDNS responder started");
    }

    server.begin();
    Serial.println("HTTP server started");
}

void loop(void) {
    server.handleClient();
}

