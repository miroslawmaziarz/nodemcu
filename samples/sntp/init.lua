
print("Base cycle")
gpio.mode(1, gpio.OUTPUT)
gpio.mode(2, gpio.OUTPUT)

-- gpio.write(2, gpio.LOW)
gpio.write(1, gpio.LOW)
gpio.write(2, gpio.LOW)

interval_ms, cycle_num, cycle_limit = 500, 0, 20

function cycle_body()
  if cycle_num % 2 == 0 then
    gpio.write(1, gpio.HIGH)
    gpio.write(2, gpio.LOW)
  else
    gpio.write(1, gpio.LOW)
    gpio.write(2, gpio.HIGH)
  end
end

function cycle_finish()
  gpio.write(1, gpio.LOW)
  gpio.write(2, gpio.LOW)
end

dofile("base_cycle.lua")

-- =mytimer:unregister()

