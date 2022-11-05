local switchHandler = {
  state = nil,
  mode = nil,
  param1 = nil,
  param2 = nil
}

function switchHandler.loadNewOptions(switchOptions)
  local state  = switchOptions['state']
  local mode   = switchOptions['mode']
  local param1 = switchOptions['param1']
  local param2 = switchOptions['param2']

  if state == 'new' then
    switchHandler.runNewAction(mode, param1, param2)
  end

  switchHandler.updateOptions(switchOptions)
end

function switchHandler.updateOptions(switchOptions)
  switchHandler.state  = switchOptions['state']
  switchHandler.mode   = switchOptions['mode']
  switchHandler.param1 = switchOptions['param1']
  switchHandler.param2 = switchOptions['param2']
end

function switchHandler.runNewAction(mode, param1, param2)
  if mode == "turn on..off in" and param2 > 0 then
    print(mode .. "- run")
    relay.turnOnWithTimer(
      param2 * 1000,
      function () gsheets.setSwitchOptions({ name = 'state', value = 'completed' }); end
    )
    gsheets.setSwitchOptions({ name = 'state', value = 'progress' }) 
  end
end

return switchHandler
