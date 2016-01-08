
from robot import Robot
import time

__author__ = 'stefan'

robot = Robot()

try:

    while True:

        print("driving forward")
        robot.drive_forward(80)

        while not robot.sees_obstacle():
            time.sleep(0.1)

        print("obstacle - turning left")
        robot.turn_left(100)

        # if obstacle is close (2)
        while robot.sees_obstacle() == 2:
            # let it turn a while
            time.sleep(0.25)

except KeyboardInterrupt:

    robot.stop()
