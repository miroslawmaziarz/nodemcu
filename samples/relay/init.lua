local t = require('ds18b20')
local pin = 1 -- gpio0 = 3, gpio2 = 4

gpio.mode(pin, gpio.OUTPUT)
gpio.write(pin, gpio.HIGH)

interval_ms, cycle_num, cycle_limit = 60 * 1000, 0, 99999

function turnOnRelay()
  gpio.write(pin, gpio.LOW)
end

function turnOffRelay()
  gpio.write(pin, gpio.HIGH)
end

turnOnRelay()
tmr.create():alarm(1 * 60 * 1000, tmr.ALARM_SINGLE, turnOffRelay)

function cycle_body()
  print("hello")
  if cycle_num % 15 == 0 then
    turnOnRelay()
    tmr.create():alarm(3 * 60 * 1000, tmr.ALARM_SINGLE, turnOffRelay)
  end
end

functiot:qa
 cycle_finish()
  print("bye")
  turnOffRelay()
end

dofile("base_cycle.lua")
