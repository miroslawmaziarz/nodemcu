dofile("base_wifi.lua")

gpio.mode(1, gpio.OUTPUT)
gpio.mode(2, gpio.OUTPUT)

gpio.write(1, gpio.LOW)
gpio.write(2, gpio.LOW)


function append_to_file(filename, line)
  if file.open(filename, "a+") then
    file.writeline(line)
    -- file.flush()
    file.close()
  end
end

function get_file_lines_and_clear(filename)
  if file.open(filename, "r") then
    local line = file.readline()
    while line do
      print(line)
      line = file.readline()
    end
    file.close()
  end
end

function currentTime()
  localTime = rtctime.epoch2cal(rtctime.get())
  return string.format("%04d-%02d-%02d %02d:%02d:%02d", localTime["year"], localTime["mon"], localTime["day"], localTime["hour"], localTime["min"], localTime["sec"])
end

print(currentTime())

interval_ms, cycle_num, cycle_limit = 500, 0, 20
data_csv_filename = 'data.csv'
function cycle_body()
  if is_wifi_ready then print("wifi ready!") end
  if cycle_num % 2 == 0 then
    gpio.write(1, gpio.HIGH)
    gpio.write(2, gpio.LOW)
  else
    gpio.write(1, gpio.LOW)
    gpio.write(2, gpio.HIGH)
  end
  local line = ""..currentTime()..","..tostring(is_wifi_ready)..","..tostring(cycle_num)
  print(line)
  -- append_to_file(data_csv_filename, line)
end

function cycle_finish()
  get_file_lines_and_clear(data_csv_filename)
  gpio.write(1, gpio.LOW)
  gpio.write(2, gpio.LOW)
end

dofile("base_cycle.lua")
-- =mytimer:unregister()

