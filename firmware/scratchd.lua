require("robot")

print("Started scratchd")

scratch=net.createConnection(net.TCP, 0)

scratch:on("receive", 
	function(conn, payload) 

		local len = bit.lshift(string.byte(payload, 1), 24) + bit.lshift(string.byte(payload, 2), 16) + bit.lshift(string.byte(payload, 3), 8) + string.byte(payload, 4) 
		local msg = string.sub(payload, 5, len+5)
		local i, j = string.find(msg, " ")
		local mtype = string.sub(msg, 1, i-1)
		
		if mtype == "broadcast" then
			local mpay = string.sub(msg, i+2, -2)
			local cmd = mpay 

			i, j = string.find(mpay, " ")

			if i then
				cmd = string.sub(mpay, 1, i-1)
				arg = string.sub(mpay, j+1, -1)
			end

			local narg = 100

			if arg then
				narg = tonumber(arg)
			end

			if cmd == "forward" or cmd == "vorwaerts" then
				robot.drive_forward(narg)
			elseif cmd == "backward" or cmd == "rueckwaerts" then
				robot.drive_backward(narg)
			elseif cmd == "left" or cmd == "links" then
				robot.turn_left(narg)
			elseif cmd == "right" or cmd == "rechts" then
				robot.turn_right(narg)
			elseif cmd == "stop" then
				robot.stop()
			end
		end

	end)
