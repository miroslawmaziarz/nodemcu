function turnOnPumpaForPeriod(period)
  local offtmr = tmr.create()
  offtmr:register(
    period,
    tmr.ALARM_SINGLE, 
    function (t) print("expired"); turnOffPumpa(); t:unregister() end
  )
  -- offtmr.delay(period) 
  offtmr:start()
  turnOnPumpa()
end

function turnOnPumpa()
  gpio.write(pompa_pin, gpio.LOW)
end

function turnOffPumpa()
  gpio.write(pompa_pin, gpio.HIGH)
end

