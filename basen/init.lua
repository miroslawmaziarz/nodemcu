pompa_pin = 1 

interval_ms, cycle_num, cycle_limit = 5 * 60 * 1000, 0, -1

pump_on_duration = 30 * 1000

dofile("relay.lua")
turnOnPumpaForPeriod(pump_on_duration)

function cycle_body()
print("start cycle")
  turnOnPumpaForPeriod(pump_on_duration)
end

function cycle_finish()
end

dofile('cycle.lua')
