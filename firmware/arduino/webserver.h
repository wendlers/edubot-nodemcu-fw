#pragma once

#include <ESP8266WiFi.h>
#include <ESP8266WebServer.h>

class WebServer: public ESP8266WebServer
{
private:

    static WebServer _instance;

public:

    static WebServer &instance()
    {
        return _instance;
    }

private:

    WebServer();
    WebServer(const WebServer &);
    WebServer &operator = (const WebServer &);

    static void handleRoot();
	static void handleDrive();
	static void handleRange();
    static void handleNotFound();
};

