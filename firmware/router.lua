-- EDU Bot NodeMCU Lua firmware, 2016 sw@kaltpost.de
-- MIT License (MIT)
-- See LICENSE file for details

require("robot")

print("Started router")

router = {}

router.count = 0

function router.route(cmd)

	local status = "ERROR"

	router.count = router.count + 1

	if string.sub(cmd, 1, 1) == "d" then
		-- route to drive ctrl
		status = router.route_drive(string.sub(cmd, 2))			

	elseif string.sub(cmd, 1, 1) == "r" then
		local dist = robot.range()

		if dist > -1 then
			status = tostring(dist)
		end

	elseif string.sub(cmd, 1, 1) == "o" then
		-- check for obstacle
		if robot.sees_obstacle() == 1 then
			status = "FAR"
		elseif robot.sees_obstacle() == 2 then
			status = "CLOSE"
		else
			status = "NO"
		end

	elseif string.sub(cmd, 1, 1) == "S" then
		-- route to scratch 
		status = router.route_scratch(string.sub(cmd, 2))			
	end

	return status 
end

function router.route_drive(cmd)

	if string.len(cmd) < 8 then
		return "ERROR"
	end
	
	local speed_a = tonumber(string.sub(cmd, 1, 4))
	local speed_b = tonumber(string.sub(cmd, 5, 8))

	if speed_a == nil or speed_b == nil then
		return "ERROR"
	end

	robot.drive(speed_a, speed_b)

	return "OK"
end

function router.route_scratch(cmd)

	if string.len(cmd) < 1 then
		return "ERROR"
	end
	
	if string.sub(cmd, 1, 1) == "c" then

		-- connect to scratch
		if string.len(cmd) < 2 then
			return "ERROR"
		end
		if scratch then
			scratch.disconnect()
		end
		dofile("scratchd.lua")
		scratch.connect(string.sub(cmd, 2))

	elseif string.sub(cmd, 1, 1) == "d" then

		-- disconnect from scratch
		if scratch then
			scratch.disconnect()
		else
			return "ERROR"
		end

	else
		return "ERROR"
	end

	return "OK"
end
