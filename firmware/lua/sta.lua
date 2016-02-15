-- EDU Bot NodeMCU Lua firmware, 2016 sw@kaltpost.de
-- MIT License (MIT)
-- See LICENSE file for details

wifi.setmode(wifi.STATION)
wifi.sta.config("MosEisleySpaceport", "supersonic")
print("Connected to AP")
