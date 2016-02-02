rf = {};

function rf.init(pin_trig, pin_echo)

	rf.trig = pin_trig or 4
	rf.echo = pin_echo or 3

	gpio.mode(rf.trig, gpio.OUTPUT)
	gpio.mode(rf.echo, gpio.INT)

	rf.t1 = 0
	rf.t2 = 0
	rf.current_dist = 0
	rf.prev_obstacle = false
	rf.obstacle_cb = nil
end

function rf.start()
	tmr.alarm(0, 500, tmr.ALARM_SEMI, rf.range_internal)
end

function rf.set_obstacle_cb(cb_func)

	rf.obstacle_cb = cb_func 
end

function rf.trigger(level)

	if level == 1 then
		rf.t1 = tmr.now()
		gpio.trig(rf.echo, "down")

		-- It looks like we are not able to detect very short pulses with the trigger
		-- thus, we check here if pulse went already down, and if so, restart the timer.
		tmr.delay(10)

		if gpio.read(rf.echo) == 0 then
			rf.current_dist = 0
			tmr.start(0)
		else
		end

	else
		rf.t2 = tmr.now()

		if (rf.t2 - rf.t1) >= 0 then
			rf.current_dist = (rf.t2 - rf.t1) / 5800

			obstacle = rf.sees_obstacle() 

			-- Execute callback (if registered)
			if obstacle ~= rf.prev_obstacle and rf.obstacle_cb then
				rf.obstacle_cb(obstacle)
				rf.prev_obstacle = obstacle
			end

		end
		tmr.start(0)
	end
end

function rf.range_internal()

	gpio.trig(rf.echo, "up", rf.trigger)

	-- Charge the range finder ...
	gpio.write(rf.trig, gpio.HIGH)
	tmr.delay(10)
	gpio.write(rf.trig, gpio.LOW)

end

function rf.range()
	return rf.current_dist
end

function rf.sees_obstacle()

	if rf.range() < 0.2 then
		-- obstacle close 
		return 2 
	elseif rf.range() < 0.5 then
		-- obstacle far away
		return 1 
	end

	-- no obstacle
	return 0 
end

