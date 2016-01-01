import telnetlib

__author__ = 'stefan'


class Robot:

    def __init__(self, host="ESP_06F38E"):

        self.tn = telnetlib.Telnet(host)

    def drive(self, speed_a, speed_b):

        self.tn.write("d%+04d%+04d\n" % (speed_a, speed_b))

    def drive_forward(self, speed=100):
        self.drive(speed, speed)

    def drive_backward(self, speed=100):
        self.drive(-speed, -speed)

    def turn_left(self, speed=100):
        self.drive(-speed, speed)

    def turn_right(self, speed=100):
        self.drive(speed, -speed)

    def stop(self, speed):
        self.drive(0, 0)

