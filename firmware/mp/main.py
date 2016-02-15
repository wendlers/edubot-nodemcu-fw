import pyb
import esp
import sys

from sta import Sta
from ultrasonic import Ultrasonic


us = Ultrasonic(13, 15)

def onnewclient(s):
    # print("Client connected!")
    s.onrecv(onclientdata)
    s.onsent(onclientsent)

def onclientdata(s, d):
    if d.startswith(b'GET /dist '):
       s.send("HTTP/1.0 200 OK\r\n"
               "Server: Micropython for ESP8266\r\n"
               "Content-Type: text/plain\r\n"
               "Connection: close\r\n"
               "\r\n" + str(us.dist()))

def onclientsent(s):
    # print("Closing...")
    s.close()

sta = Sta()
sta.connect()


server = esp.socket()

server.onconnect(onnewclient)
server.bind(("", 80))
server.listen(5)
