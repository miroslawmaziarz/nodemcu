#!/bin/bash
/home/mirek/.local/bin/nodemcu-uploader --verbose upload --restart init.lua switchHandler.lua ../utils/relay.lua:relay.lua ../utils/cycle.lua:cycle.lua ../utils/wifi.lua:wifi.lua ../utils/gsheets.lua:gsheets.lua ../credentials.lua:credentials.lua
