require("gear")

robot = {}

function robot.init()

	gear.init()
end

function robot.drive(speed_a, speed_b)

	local dir_a = 0
	local dir_b = 0

	-- limit values to what makes sense (0..100%)
	if speed_a > 100 then
		speed_a = 100
	elseif speed_a < -100 then
		speed_a = -100
	end

	if speed_b > 100 then
		speed_b = 100
	elseif speed_b < -100 then
		speed_b = -100
	end

	-- decide on direction
	if speed_a > 0 then
		dir_a = 1
	end
	if speed_b > 0 then
		dir_b = 1
	end

	gear.set_speed(1, math.abs(speed_a))
	gear.set_dir(1, dir_a)
	gear.set_speed(2, math.abs(speed_b))
	gear.set_dir(2, dir_b)

end

function robot.drive_forward(speed)

	speed = speed or 100

	return robot.drive(speed, speed)
end

function robot.drive_backward(speed)

	speed = speed or 100

	return robot.drive(-speed, -speed)
end

function robot.turn_left(speed)

	speed = speed or 100

	return robot.drive(-speed, speed)
end

function robot.turn_right(speed)

	speed = speed or 100

	return robot.drive(speed, -speed)
end

function robot.stop()

	return robot.drive(0, 0)
end

function robot.sees_obstacle()

	return false
end

robot.init()
