local relay = {}

function relay.turnOnWithTimer(timeMs, terminateCallback)
  terminateCallback = terminateCallback or function (data) end

  relay.timer = tmr.create()
  relay.timer:register(
    timeMs,
    tmr.ALARM_SINGLE,
    function (t) print("relay off"); relay.turnOff(); t:unregister(); terminateCallback(); end
  )
  relay.timer:start()
  relay.turnOn()
end

function relay.teminateTimer()
  relay.timer:unregister()
  relay.turnOff()
end

function relay.turnOn()
  gpio.write(relay.pin, gpio.LOW)
end

function relay.turnOff()
  gpio.write(relay.pin, gpio.HIGH)
end

function relay.init(pin)
  relay.pin = pin
  relay.turnOff()
end

return relay;
