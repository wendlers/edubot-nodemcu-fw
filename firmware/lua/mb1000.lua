-- EDU Bot NodeMCU Lua firmware, 2016 sw@kaltpost.de
-- MIT License (MIT)
-- See LICENSE file for details

rf = {}

function rf.init(pin_en, pin_pw)

	pin_en = pin_en or 7
	pin_pw = pin_pw or 8

	gpio.mode(pin_pw, gpio.INPUT)
	gpio.mode(pin_en, gpio.OUTPUT)
	gpio.write(pin_en, gpio.LOW)

	rf.current_dist = 0
	rf.prev_obstacle = false
	rf.obstacle_cb = nil

	tmr.alarm(0, 100, 1, rf.range_internal)

end

function rf.set_obstacle_cb(cb_func)
	rf.obstacle_cb = cb_func 
end

function rf.range_internal()

	local t1 = 0
	local t2 = 0

	gpio.write(7, gpio.HIGH)

	while gpio.read(8) == gpio.LOW do
		t1 = tmr.now()
	end


	while gpio.read(8) == gpio.HIGH do
		t2 = tmr.now()
	end

	gpio.write(7, gpio.LOW)

	rf.current_dist = t2 - t1

	obstacle = rf.sees_obstacle() 

	if obstacle ~= rf.prev_obstacle and rf.obstacle_cb then
		rf.obstacle_cb(obstacle)
		rf.prev_obstacle = obstacle
	end

end

function rf.range()
	return rf.current_dist
end

function rf.sees_obstacle()

	if rf.range() < 2000 then
		-- obstacle close 
		return 2 
	elseif rf.range() < 6000 then
		-- obstacle far away
		return 1 
	end

	-- no obstacle
	return 0 
end
