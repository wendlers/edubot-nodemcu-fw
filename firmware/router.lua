require("robot")

router = {}

function router.route(cmd)

	local status = "ERROR"

	if string.sub(cmd, 1, 1) == "d" then

		-- route to drive ctrl
		status = router.route_drive(string.sub(cmd, 2))			
	end

	return status 
end

function router.route_drive(cmd)

	if string.len(cmd) < 8 then
		return "ERROR"
	end
	
	local speed_a = tonumber(string.sub(cmd, 0, 4))
	local speed_b = tonumber(string.sub(cmd, 5, 8))

	if speed_a == nil or speed_b == nil then
		return "ERROR"
	end

	robot.drive(speed_a, speed_b)

	return "OK"
end


