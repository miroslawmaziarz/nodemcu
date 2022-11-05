inspectMemoryUsage = function(idx)
  print("-----" .. idx .. "-----")
  local heapSize=node.heap()
  if heapSize<1000 then
    node.restart()
  end
  print("Memory Used1:"..collectgarbage("count"))
  collectgarbage()
  print("Memory Used2:"..collectgarbage("count"))
  print("Heap Available:"..heapSize)
end

node.compile("ds18b20-integer.lua")
inspectMemoryUsage(0)

--local t = require("ds18b20")
local t = dofile("ds18b20-integer.lc")
local pin = 3 -- gpio0 = 3, gpio2 = 4

inspectMemoryUsage(1)
local function readout(temp)
inspectMemoryUsage(2)
  if t.sens then
    print("Total number of DS18B20 sensors: ".. #t.sens)
    for i, s in ipairs(t.sens) do
      print(string.format("  sensor #%d address: %s%s",  i, ('%02X:%02X:%02X:%02X:%02X:%02X:%02X:%02X'):format(s:byte(1,8)), s:byte(9) == 1 and " (parasite)" or ""))
    end
  end
  for addr, temp in pairs(temp) do
    print(string.format("Sensor %s: %s °C", ('%02X:%02X:%02X:%02X:%02X:%02X:%02X:%02X'):format(addr:byte(1,8)), temp))
  end

  -- Module can be released when it is no longer needed
  t = nil
  package.loaded["ds18b20"] = nil

end

function read()
  t:read_temp(readout, pin, t.C)
end

mytimer = tmr.create()
mytimer:register(6000, tmr.ALARM_AUTO, read)
mytimer:start()
