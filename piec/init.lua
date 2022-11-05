node.compile("ds18b20-integer.lua")
node.compile("temperatureHandler.lua")
node.compile("wifi.lua")
node.compile("cycle.lua")

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

inspectMemoryUsage(0)

dofile("wifi.lc")
local cycle = require("cycle")
local temperatureHandler = dofile("temperatureHandler.lc")
print(temperatureHandler)
gsheets = dofile("gsheets.lc")

getOptsCallback = function(data)
  gsheets.switch_options = data

  local frequency = gsheets.switch_options['frequency']
  cycle.change_interval(frequency * 1000 + 1)

  switchHandler.loadNewOptions(gsheets.switch_options)
end

wifi_ready_callback = function()
  print('wifi_ready_callback run' .. wifi.sta.getrssi())
end

function cycle_body()
  print 'cycle_body'
  if is_wifi_ready ~= true then
    print("wifi not ready!")
    return
  end

  --gsheets.getSwitchOptions(getOptsCallback)

  temperatureHandler.readAndStore()
end

function cycle_finish()
end

print("ChipId:", node.chipid())

local cycle_limit = 100
local interval = 60 * 10
cycle.init(interval * 1000, cycle_limit)

