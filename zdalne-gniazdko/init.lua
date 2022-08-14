pompa_pin = 1 

pump_on_duration = 30 * 1000
dofile("wifi.lua")
cycle = require('cycle')
gsheets = require('gsheets')

getOptsCallback = function(data)
  gsheets.switch_options = data
  frequency = data['frequency']
  print('getOptsCallback')
  print(frequency)

  cycle.change_interval(frequency * 1000 + 1)
end

wifi_ready_callback = function()
  print('wifi_ready_callback run' .. wifi.sta.getrssi())

end

function cycle_body()
  if is_wifi_ready ~= true then
    print("wifi not ready!")
    return
  end

  gsheets.getSwitchOptions(getOptsCallback)

end

function cycle_finish()
end

dofile("relay.lua")


local cycle_limit = 10
local interval = 3
cycle.init(interval * 1000, cycle_limit)

