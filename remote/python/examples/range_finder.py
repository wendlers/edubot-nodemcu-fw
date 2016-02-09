
from robot import Robot
import time

__author__ = 'stefan'

robot = Robot("ESP_116285")

i = 0

while True:
    # o = robot.sees_obstacle()
    r = robot.dist()
    # print("%04d   Robot sees obstacle: %s (%f m away)" % (i, o, r))
    print("%04d   Robot sees obstacle %f m away" % (i, r))
    time.sleep(0.2)
    i += 1
