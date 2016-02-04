rf = {};

function rf.init(pin_trig, pin_echo)

	rf.trig = pin_trig or 4
	rf.echo = pin_echo or 3

	gpio.mode(rf.trig, gpio.OUTPUT)
	gpio.mode(rf.echo, gpio.INT)
end

function rf.range()

	local t1 = 0
	local t2 = 0
	local tout1 = 500 
	local tout2 = 1000 

	gpio.write(rf.trig, gpio.HIGH)
	tmr.delay(10)
	gpio.write(rf.trig, gpio.LOW)

	while gpio.read(rf.echo) == gpio.LOW and tout1 > 0 do
		tmr.wdclr()
		tout1 = tout1 - 1
		if tout1 == 0 then
			return 2.5 
		end
	end

	t1 = tmr.now()

	while gpio.read(rf.echo) == gpio.HIGH do
		tmr.wdclr()
		tout2 = tout2 - 1
		if tout2 == 0 then
			return 2.5 
		end
	end

	t2 = tmr.now()

	return (t2 - t1) / 5800

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

