-- interval_ms, cycle_num, cycle_limit = 500, 0, 120
-- function cycle_body()
-- end

-- function cycle_finish()
-- end

local function cycle_func(t)
  cycle_num = cycle_num + 1
  print("cycle num: "..cycle_num)

  cycle_body()

  if cycle_num > cycle_limit then
    cycle_finish()
    print("Unregister")
    t:unregister()
  end
end

mytimer = tmr.create()
mytimer:register(interval_ms, tmr.ALARM_AUTO, cycle_func)
mytimer:start()

-- =mytimer:unregister()

