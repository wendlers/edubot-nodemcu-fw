
from robot import Robot

__author__ = 'stefan'

robot = Robot("192.168.1.122")

# connect to running scratch sensor instance (use only IP)
robot.connect_scratch("192.168.1.113")
