local t = require('ds18b20')
local pin = 3 -- gpio0 = 3, gpio2 = 4

local function readout(temps)
  timestamp = currentTime()
  for addr, temp in pairs(temps) do
    row = string.format("%s, %s, %s;", ('%02X:%02X:%02X:%02X:%02X:%02X:%02X:%02X'):format(addr:byte(1,8)), temp, timestamp)
    print(row)
  end
end

--rtctime.sync()
rtctime.set(1436430589, 0)

function currentTime()
  localTime = rtctime.epoch2cal(rtctime.get())
  return string.format("%04d-%02d-%02d %02d:%02d:%02d", localTime["year"], localTime["mon"], localTime["day"], localTime["hour"], localTime["min"], localTime["sec"])
end

interval_ms, cycle_num, cycle_limit = 2000, 0, 4
function cycle_body()
  print("hello")
  --file.remove("ds18b20_save.lc") -- remove saved addresses
  print("=============================================", node.heap())
  t:read_temp(readout, pin, t.C)
end

function cycle_finish()
  print("bye")
end

dofile("base_cycle.lua")
