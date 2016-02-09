-- EDU Bot NodeMCU Lua firmware, 2016 sw@kaltpost.de
-- MIT License (MIT)
-- See LICENSE file for details

rf = {};

function rf.init(pin_trig, pin_echo)

    rf.trig = pin_trig or 4
    rf.echo = pin_echo or 3

    gpio.mode(rf.trig, gpio.OUTPUT)
    gpio.mode(rf.echo, gpio.INT)
    gpio.write(rf.trig, gpio.LOW)

    rf.t1 = 0
    rf.t2 = 0

    rf.running = false
    rf.current = 0
	rf.prev_obstacle = 0
	rf.obstacle_cb = nil

    gpio.trig(rf.echo, "both", rf.trig_cb)

end

function rf.start()

    if not rf.running then
        tmr.alarm(0, 500, tmr.ALARM_SEMI, rf.range_internal)
        rf.running = true
    end

end

function rf.set_obstacle_cb(cb_func)

	rf.obstacle_cb = cb_func

end

function rf.trig_cb(level)

    if level == 1 then
        if rf.t1 == 0 and rf.t2 == 0 then
            rf.t1 = tmr.now()
        end
    else
        if rf.t1 > 0 and rf.t2 == 0 then
            rf.t2 = tmr.now()
            rf.current = (rf.t2 - rf.t1) / 5800

          	local obstacle = rf.sees_obstacle()

            if obstacle ~= rf.prev_obstacle and rf.obstacle_cb then
                rf.obstacle_cb(obstacle)
                rf.prev_obstacle = obstacle
            end
        end
    end

end

function rf.range()

    rf.start()
    return rf.current

end

function rf.range_internal()

    tmr.wdclr()

    if gpio.read(rf.trig) == gpio.LOW and gpio.read(rf.echo) == gpio.LOW then

        gpio.write(rf.trig, gpio.HIGH)

        rf.t1 = 0
        rf.t2 = 0
        tmr.delay(50)

        gpio.write(rf.trig, gpio.LOW)
    end

    tmr.start(0)
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

