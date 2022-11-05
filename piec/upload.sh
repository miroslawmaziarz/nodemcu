#!/bin/bash
#/home/mirek/.local/bin/nodemcu-uploader --verbose upload
/home/mirek/.local/bin/nodemcu-uploader upload --restart ../utils/blank_init.lua:init.lua
/home/mirek/.local/bin/nodemcu-uploader upload --restart init.lua temperatureHandler.lua ../utils/cycle.lua:cycle.lua ../utils/wifi.lua:wifi.lua ../utils/gsheets.lua:gsheets.lua ../credentials.lua:credentials.lua ../utils/ds18b20-integer.lua:ds18b20-integer.lua
/home/mirek/.local/bin/nodemcu-uploader terminal
