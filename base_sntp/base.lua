-- tz = require('tz')

local function sync_time()
  -- tz.setzone('eastern')
  sntp.sync(nil, function(now)
    --local tm = rtctime.epoch2cal(now + tz.getoffset(now))
    local tm = rtctime.epoch2cal(now)
    print(string.format("%04d/%02d/%02d %02d:%02d:%02d", tm["year"], tm["mon"], tm["day"], tm["hour"], tm["min"], tm["sec"]))
  end)

--  sntp.sync(nil,
--  function(sec, usec, server, info)
--    print('sync', sec, usec, server)
--  end,
--  function()
--    print('failed!')
--    end
--  )
end

sync_time()
