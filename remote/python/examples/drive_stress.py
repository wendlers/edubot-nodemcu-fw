from robot import Robot
import time

__author__ = 'stefan'

robot = Robot("ESP_116285")

i = 0

while True:
	for s in range(-101, 101, 1):
		print("%04d drive %+04d, %+04d\t%s" % (i, s, s, robot.drive(s, s))) 
		i += 1
