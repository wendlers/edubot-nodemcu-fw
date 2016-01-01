
from robot import Robot
import pygame

__author__ = 'stefan'


def robot_ctrl():

    robot_prev_speed = 60
    robot_prev_state = None
    robot = Robot()

    robot_images = {
        robot.stop: pygame.image.load("assets/robot_aoff_boff.png"),
        robot.drive_forward: pygame.image.load("assets/robot_afwd_bfwd.png"),
        robot.drive_backward: pygame.image.load("assets/robot_abwd_bbwd.png"),
        robot.turn_left: pygame.image.load("assets/robot_abwd_bfwd.png"),
        robot.turn_right: pygame.image.load("assets/robot_afwd_bbwd.png")
    }

    robot_image_rect = robot_images[robot.stop].get_rect()
    robot_image_rect.left = 0

    pygame.init()

    font = pygame.font.Font(None, 40)
    size = [robot_image_rect.width, robot_image_rect.height]
    screen = pygame.display.set_mode(size)

    pygame.display.set_caption("Remote Robot")

    done = False
    clock = pygame.time.Clock()

    pygame.joystick.init()
    joystick_count = pygame.joystick.get_count()

    assert joystick_count > 0, "No Joystick found!"

    joystick = pygame.joystick.Joystick(0)
    joystick.init()

    assert joystick.get_name() == "Sony PLAYSTATION(R)3 Controller", "Joystick 0 is not a PS3 controller"

    while not done:

        for event in pygame.event.get():
            if event.type == pygame.QUIT:
                done = True

        button_up = joystick.get_button(4)
        button_down = joystick.get_button(6)
        button_left = joystick.get_button(7)
        button_right = joystick.get_button(5)
        axis_speed = joystick.get_axis(3)

        robot_speed = 60 - (axis_speed * 40)

        if button_up:
            robot_state = robot.drive_forward
        elif button_down:
            robot_state = robot.drive_backward
        elif button_left:
            robot_state = robot.turn_left
        elif button_right:
            robot_state = robot.turn_right
        else:
            robot_state = robot.stop

        if robot_state != robot_prev_state or abs(robot_prev_speed - robot_speed) > 2:
            robot_state(robot_speed)
            robot_prev_state = robot_state
            robot_prev_speed = robot_speed

        screen.blit(robot_images[robot_state], robot_image_rect)

        txt = font.render("Speed: %d" % robot_speed, True, (0, 0, 0))
        screen.blit(txt, [10, 10])

        pygame.display.flip()
        clock.tick(20)

try:
    robot_ctrl()
except Exception as e:
    print(e)
