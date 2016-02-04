
from robot import Robot
import time

__author__ = 'stefan'

robot = Robot("ESP_116285")

i = 0

while True:
    o = robot.sees_obstacle()
    r = robot.dist()
    print("%04d   Robot sees obstacle: %s (%f m away)" % (i, o, r))
    # time.sleep(0.1)
    i += 1
