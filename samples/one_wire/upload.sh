#!/bin/bash

/home/mirek/.local/bin/nodemcu-uploader upload --restart init.lua ../../utils/ds18b20.lua:ds18b20.lua ../../utils/cycle.lua:base_cycle.lua
sudo /home/mirek/.local/bin/nodemcu-uploader terminal
