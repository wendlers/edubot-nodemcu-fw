#include "webserver.h"
#include "gear.h"
#include "range.h"

#include "generated/static_index_html.h"

extern Gear gear;
extern Range range;

WebServer WebServer::_instance;

WebServer::WebServer() : ESP8266WebServer()
{
    on("/", WebServer::handleRoot);
    on("/botname", WebServer::handleBotname);
    on("/drive", WebServer::handleDrive);
    on("/range", WebServer::handleRange);
    onNotFound(WebServer::handleNotFound);
}

void WebServer::handleRoot()
{
	// Serial.print("handleRoot\n");

	instance().send_P(200, "text/html", (const char *)static_index_html, static_index_html_len);
}

void WebServer::handleBotname() 
{
    instance().send(200, "text/plain", _MDNS_NAME_);
}


void WebServer::handleDrive()
{
	// Serial.print("handleDrive\n");

	if(instance().hasArg("a")) {
		int s = instance().arg("a").toInt();
		gear.setDir(0, s < 0 ? 0 : 1);
		gear.setSpeed(0, s < 0 ? -s : s);
	}

	if(instance().hasArg("b")) {
		int s = instance().arg("b").toInt();
		gear.setDir(1, s < 0 ? 0 : 1);
		gear.setSpeed(1, s < 0 ? -s : s);
	}

	int a = (gear.getDir(0) == 0 ? -1 : 1) *  gear.getSpeed(0);
	int b = (gear.getDir(1) == 0 ? -1 : 1) *  gear.getSpeed(1);

	String message = "{\"a\": ";
	message += a;
	message += ", \"b\": ";
	message += b;
	message += "}";

    instance().send(200, "text/json", message);
}

void WebServer::handleRange()
{
	// Serial.print("handleRange\n");

	String message = "{\"d\": ";
	message += range.getDistance();
	message += "}";

    instance().send(200, "text/json", message);
}

void WebServer::handleNotFound()
{
	// Serial.print("handleNotFound\n");

    String message = "File Not Found\n\n";
    message += "URI: ";
    message += instance().uri();
    message += "\nMethod: ";
    message += (instance().method() == HTTP_GET) ? "GET" : "POST";
    message += "\nArguments: ";
    message += instance().args();
    message += "\n";

    for (uint8_t i = 0; i < instance().args(); i++) {
        message += " " + instance().argName(i) + ": " + instance().arg(i) + "\n";
    }

    instance().send(404, "text/plain", message);
}

