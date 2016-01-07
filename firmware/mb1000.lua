rf = {}

function rf.init(pin_en, pin_pw)

	pin_en = pin_en or 7
	pin_pw = pin_pw or 8

	gpio.mode(pin_pw, gpio.INPUT)
	gpio.mode(pin_en, gpio.OUTPUT)
	gpio.write(pin_en, gpio.LOW)

	rf.current_dist = 0

	tmr.alarm(0, 100, 1, rf.range_internal)

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

end

function rf.range()
	return rf.current_dist
end

function rf.sees_obstacle()

	if rf.range() < 3000 then
		return true
	end

	return false
end
