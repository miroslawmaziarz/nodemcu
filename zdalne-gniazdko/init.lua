dofile("wifi.lua")
cycle = require('cycle')
gsheets = require('gsheets')
relay = require('relay')
switchHandler = require('switchHandler')

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
  if is_wifi_ready ~= true then
    print("wifi not ready!")
    return
  end

  gsheets.getSwitchOptions(getOptsCallback)
end

function cycle_finish()
end

local pin = 1
relay.init(pin)
relay.turnOnWithTimer(20*1000)

local cycle_limit = 100
local interval = 3
cycle.init(interval * 1000, cycle_limit)

