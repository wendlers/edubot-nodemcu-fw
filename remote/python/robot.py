import telnetlib

__author__ = 'stefan'

# TODO: error handling (response from robot is "OK" or "ERROR" => map to True or False


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

    def stop(self, speed=0):
        self.drive(0, 0)

    def connect_scratch(self, host_ip):
        self.tn.write("Sc%s" % host_ip)

    def disconnect_scratch(self):
        self.tn.write("Sd")

    def sees_obstacle(self):
        self.tn.write("o")
        id, re, txt = self.tn.expect([r"NO\n", r"FAR\n", r"CLOSE\n"])
        return id
