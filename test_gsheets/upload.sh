#!/bin/bash

/home/mirek/.local/bin/nodemcu-uploader --verbose upload --restart init.lua ../base_cycle/base.lua:cycle.lua ../base_wifi/base.lua:wifi.lua ../base_gsheets/base.lua:gsheets.lua ../credentials.lua:credentials.lua
