
from robot import Robot
import time

__author__ = 'stefan'

robot = Robot("ESP_D67C3F")

while True:
    o = robot.sees_obstacle()
    print("Robot sees obstacle: %s" % o)
    time.sleep(0.1)
