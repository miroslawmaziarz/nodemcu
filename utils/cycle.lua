-- interval_ms, cycle_num, cycle_limit = 500, 0, 120
-- function cycle_body()
-- end

-- function cycle_finish()
-- end

local cycle = {}

function cycle.callback(t)
  cycle.counter = cycle.counter + 1
  print("cycle counter: " .. cycle.counter)
  print("cycle interval: " .. cycle.interval)

  cycle_body()
  cycle.unregister_when_limit()
end

function cycle.init(interval, limit)
  cycle.interval = interval
  cycle.limit = limit or -1
  cycle.counter = 0

  cycle.timer = tmr.create()
  cycle.timer:register(cycle.interval, tmr.ALARM_AUTO, cycle.callback)
  cycle.timer:start()
end

function cycle.unregister()
  cycle.timer:unregister()
end

function cycle.unregister_when_limit()
  if cycle.cycle_limit ~= -1 and cycle.counter >= cycle.limit then
    cycle_finish()
    print("Unregister")
    cycle.unregister()
  end
end

function cycle.change_interval(interval)
  cycle.interval = interval
  cycle.timer:interval(interval)
end

function cycle.inspect()
  return {
    interval  = cycle.interval,
    limit     = cycle.limit,
    counter   = cycle.counter
  }
end

return cycle
