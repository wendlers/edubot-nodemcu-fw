dofile("../robot.lua")

host = arg[1] or "192.168.1.111"

print("Connecting to robot at: " .. host)

if not robot.open_remote(host, 23) then
	return
end

print("Driving forward for 1 sec. at 80% speed")
robot.drive_forward(80)
sleep(1)

print("Turning left for 1 sec. at 80% speed")
robot.turn_left(80)
sleep(1)

print("Driving backward for 1 sec. at 80% speed")
robot.drive_backward(80)
sleep(1)

print("Turning right for 1 sec. at 80% speed")
robot.turn_right(80)
sleep(1)

print("Stopping")
robot.stop()

robot.close_remote()
