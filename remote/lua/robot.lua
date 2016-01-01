local socket = require("socket")

robot = {}

function robot.open_remote(host, port)

	local client, err = socket.connect(host, port)

	if client == nil then
		print("failed to connect to remote: " .. err)
		return false	
	end

	robot.client = client

	return true
end

function robot.close_remote()

	if robot.client == nil then
		print("not connected to remote")
		return false	
	end

	robot.client:close()
	
	return true
end

function robot.drive(speed_a, speed_b)
	
	local success = false

	if robot.client == nil then
		print("not connected to remote")
		return false	
	end

	local a = string.format("%+04d", speed_a)
	local b = string.format("%+04d", speed_b)

	local cnt, err = robot.client:send("d" .. a .. b .."\n")

	if cnt == nil then
		print("sending to remote failed: " .. err)
	else
		local line, err = robot.client:receive()

		if line == nil then
			print("receiving from remote failed: " .. err)
		elseif line == "OK" then
			success = true	
		end
	end

	return success 
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

	if robot.dummy_cnt == nil then
		robot.dummy_cnt = 0
	else
		robot.dummy_cnt = robot.dummy_cnt + 1
	end

	if robot.dummy_cnt > 10 and robot.dummy_cnt < 20 then
		print("BOOOM!")
		return true
	elseif robot.dummy_cnt == 20 then
		robot.dummy_cnt = 0
	end

	return false
end

local clock = os.clock

function sleep(n)  -- seconds
   local t = clock()
   while clock() - t <= n do end
end
