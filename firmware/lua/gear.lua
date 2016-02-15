-- EDU Bot NodeMCU Lua firmware, 2016 sw@kaltpost.de
-- MIT License (MIT)
-- See LICENSE file for details

gear = {}

function gear.init(pin_pwm1, pin_dir1, pin_pwm2, pin_dir2)

	--1,2EN 	D1 GPIO5	PWM 0
	--3,4EN 	D2 GPIO4	PWM 1
	--1A  ~2A   D3 GPIO0	DIR 0
	--3A  ~4A   D4 GPIO2	DIR 1

	pin_pwm1 = pin_pwm1 or 1
	pin_pwm2 = pin_pwm2 or 2
	pin_dir1 = pin_dir1 or 3
	pin_dir2 = pin_dir2 or 4

	-- pwm 1
	gpio.mode(pin_pwm1, gpio.OUTPUT)
	gpio.write(pin_pwm1, gpio.LOW);

	pwm.setup(pin_pwm1, 1000, 1000)		--PWM 1KHz, Duty 1000
	pwm.setduty(pin_pwm1, 0)
	pwm.start(pin_pwm1)

	-- pwm 2
	gpio.mode(pin_pwm2, gpio.OUTPUT)
	gpio.write(pin_pwm2, gpio.LOW);

	pwm.setup(pin_pwm2, 1000, 1000)		--PWM 1KHz, Duty 1000
	pwm.setduty(pin_pwm2, 0)
	pwm.start(pin_pwm2)

	-- dir 1
	gpio.mode(pin_dir1, gpio.OUTPUT)
	gpio.write(pin_dir1, gpio.HIGH)
	
	-- dir 2
	gpio.mode(pin_dir2, gpio.OUTPUT)
	gpio.write(pin_dir2, gpio.HIGH)

	-- allow easy access to pins later on
	gear.motor_pwm = {pin_pwm1, pin_pwm2}
	gear.motor_dir = {pin_dir1, pin_dir2}

end

function gear.set_speed(motor, speed)

	local dc = 0

	if motor < 1 or motor > 2 then
		return false
	end

	if speed > 0 then
		dc = 10 * speed
	end

	-- print("Setting motor pin " .. gear.motor_pwm[motor] .. " pwm to " .. dc)
	pwm.setduty(gear.motor_pwm[motor], dc)

	return true

end

function gear.set_dir(motor, direction)

	if motor < 1 or motor > 2 then
		return false
	end

	-- print("Setting motor pin " .. gear.motor_dir[motor] .. " dir to " .. direction)
	gpio.write(gear.motor_dir[motor], direction)

	return true

end

