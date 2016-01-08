
from robot import Robot
import time

__author__ = 'stefan'

robot = Robot()

while True:
    o = robot.sees_obstacle()
    print("Robot sees obstacle: %s" % o)
    time.sleep(0.1)
