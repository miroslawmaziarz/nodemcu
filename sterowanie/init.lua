local t = require("ds18b20")
-- print('heap ' .. node.heap())
dofile("wifi.lua")
gsheets = require('gsheets')

local ow_pin = 4 -- gpio0 = 3, gpio2 = 4
local pompa_pin = 1 

interval_ms, cycle_num, cycle_limit = 5 * 60 * 1000, 0, -1

wifi_ready_callback = function()
  print("!!! wifi ready !!!!")
  read_sensors()
end

local function readout(temp)
  if t.sens then
    print("Total number of DS18B20 sensors: ".. #t.sens)
    for i, s in ipairs(t.sens) do
      print(string.format("  sensor #%d address: %s%s",  i, ('%02X:%02X:%02X:%02X:%02X:%02X:%02X:%02X'):format(s:byte(1,8)), s:byte(9) == 1 and " (parasite)" or ""))
    end
  end

  local values = {}

  for addr, temp in pairs(temp) do
    addr_str = ('%02X:%02X:%02X:%02X:%02X:%02X:%02X:%02X'):format(addr:byte(1,8))
    print(string.format("Sensor %s: %s °C", addr_str, temp))

    values[addr_str] = temp
  end

  values['rssi'] = wifi.sta.getrssi()

  print('values:')
  print(table.concat(values, ' '))

  gsheets.send_data("szklarnia", values)
end

function read_sensors()
  return t:read_temp(readout, ow_pin, t.C)
end

function cycle_body()
  if is_wifi_ready ~= true then
    print("wifi not ready!")
    return
  end

  read_sensors()
end

function cycle_finish()
end

dofile('cycle.lua')
