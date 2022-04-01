dofile("wifi.lua")
gsheets = require('gsheets')

interval_ms, cycle_num, cycle_limit = 500, 2, 6

wifi_ready_callback = function()
  print('wifi_ready_callback run' .. wifi.sta.getrssi())

  gsheets.send_data("szklarnia", {p1 = 12, p2 = 21, p3 = 10, p6 = wifi.sta.getrssi() })
end

function cycle_body()
  if is_wifi_ready ~= true then
    print("wifi not ready!")
    return
  end

  print("!!! wifi ready !!!!")

  -- gsheets.send_data("szklarnia", {p1 = 12, p2 = 21, p3 = 10, p6 = wifi.sta.getrssi() })
  --gsheets.send_data("tunel", {p1 = 24, p2 = 18, p3 =11 })
end

function cycle_finish()
end

--dofile('cycle.lua')
