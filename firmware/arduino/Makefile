ARDUINO_VARIANT = nodemcuv2
SERIAL_PORT = /dev/ttyUSB0

USER_DEFINE  = -D_SSID_=\"StefanBot\" 
USER_DEFINE += -D_WIFI_PASSWORD_=\"botpass123\"
USER_DEFINE += -D_MDNS_NAME_=\"stefanbot\"

include ${HOME}/dev/git/Esp8266-Arduino-Makefile/esp8266Arduino.mk

html: static/index.html
	test -d generated || mkdir generated 
	xxd -i static/index.html generated/static_index_html.h

