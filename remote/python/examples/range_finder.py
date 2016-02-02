
from robot import Robot
import time

__author__ = 'stefan'

robot = Robot("ESP_D67C3F")

i = 0

while True:
    o = robot.sees_obstacle()
    print("%04d   Robot sees obstacle: %s" % (i, o))
    time.sleep(0.1)
    i += 1
