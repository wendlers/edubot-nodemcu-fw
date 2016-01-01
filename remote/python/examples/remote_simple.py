
from robot import Robot
import time

__author__ = 'stefan'

robot = Robot()

robot.drive(100, 100)
time.sleep(1)

robot.drive_backward(80)
time.sleep(1)

robot.turn_left(80)
time.sleep(1)

robot.turn_right(80)
time.sleep(1)

robot.stop()
