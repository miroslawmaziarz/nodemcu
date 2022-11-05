-- gsheets = require('gsheets')
--
local t = dofile("ds18b20-integer.lc")
inspectMemoryUsage(6)

local ow_pin = 3 -- gpio0 = 3, gpio2 = 4

local temperatureHandler = {
  lastValues = nil,
}

function temperatureHandler.readout(temp)
  if t.sens then
    print("Total number of DS18B20 sensors: " .. #t.sens)
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

  temperatureHandler.lastValues = values
  print('values:')
  for key, value in pairs(values) do
    print('  ', key, value)
  end

  gsheets.send_data("piec", values)
end

function temperatureHandler.readAndStore()
  inspectMemoryUsage(2)
  t:read_temp(temperatureHandler.readout, pin, t.C)
end

return temperatureHandler
