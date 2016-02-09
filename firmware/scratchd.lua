-- EDU Bot NodeMCU Lua firmware, 2016 sw@kaltpost.de
-- MIT License (MIT)
-- See LICENSE file for details

require("robot")

print("Started scratchd")

scratch = {}

scratch.conn = net.createConnection(net.TCP, 0)
scratch.speed = 100
scratch.robot_action = robot.stop

scratch.conn:on("connection",
	function(conn, payload)
		print("Connected to scratch")
		scratch.update("robot", "EduBot NodeMCU")
	end)

scratch.conn:on("receive", 
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

			local narg = scratch.speed 

			if arg then
				narg = tonumber(arg)
			end

			local valid_cmd = true

			if cmd == "forward" then
				scratch.robot_action = robot.drive_forward
			elseif cmd == "backward" then
				scratch.robot_action = robot.drive_backward
			elseif cmd == "left" then
				scratch.robot_action = robot.turn_left
			elseif cmd == "right" then
				scratch.robot_action = robot.turn_right
			elseif cmd == "stop" then
				scratch.robot_action = robot.stop
			else
				valid_cmd = false
			end

			if valid_cmd then
				scratch.robot_action(narg)
			end

		elseif mtype == "sensor-update" then

			local mpay = string.sub(msg, i+2, -2)

			local var = nil
			local val = nil

			for token in string.gmatch(mpay, "[^%s]+") do
				if not var and not val then
					var = string.sub(token, 1, -2)
				elseif not var then
					var = string.sub(token, 2, -2)
				else
					val = token

					if var == "speed" then
						scratch.speed = tonumber(val)
						scratch.robot_action(scratch.speed)
					end

					var = nil	
				end
			end
		end

	end)

function scratch.connect(host)
	scratch.conn:connect(42001, host)
	robot.set_obstacle_cb(scratch.update_obstacle)
end

function scratch.disconnect()
	robot.set_obstacle_cb(nil)
	scratch.conn:close()
end

function scratch.send(payload)

	local len = string.len(payload)
	local l3 = string.char(bit.band(0xff, len))
	local l2 = string.char(bit.band(0xff, bit.rshift(len, 8)))
	local l1 = string.char(bit.band(0xff, bit.rshift(len, 16)))
	local l0 = string.char(bit.band(0xff, bit.rshift(len, 24)))
 	local data = l0 .. l1 .. l2 .. l3 .. payload
	
	scratch.conn:send(data)
end

function scratch.broadcast(msg)
	scratch.send("broadcast \"" .. msg .."\"")
end

function scratch.update(var, val)
	
	if tonumber(val) then
		scratch.send("sensor-update \"" .. var .."\" " .. val)
	else
		scratch.send("sensor-update \"" .. var .."\" \"" .. val .. "\"")
	end
end
function scratch.update_obstacle(seen)
	if seen == 0 then
		scratch.broadcast("no obstacle")
	elseif seen == 1 then
		scratch.broadcast("obstacle far")
	elseif seen == 2 then
		scratch.broadcast("obstacle close")
	end
end

