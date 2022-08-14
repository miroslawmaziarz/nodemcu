
function turnOnPompa()
  gpio.write(pompa_pin, gpio.LOW)
end

function turnOffPompa()
  gpio.write(pompa_pin, gpio.HIGH)
end

turnOffPompa()

