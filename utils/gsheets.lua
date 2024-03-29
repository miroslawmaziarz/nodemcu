require "http"
require "encoder"

local gsheets = {};
local STEROWANIE_SCRYPT_URL = "https://script.google.com/macros/s/AKfycbxcFHJdNbVDg8hkJsD6AHLhqKizwR0QbjRHgvem8LvN8owXs2yNZKUus07F5T4V9Xp2RA/exec"

local function callback(status_code, body)
end

function http_get(host, path)
  local url = "https://" .. host .. path;
 -- http.get(url, nil, function(code, data)
 --   if (code < 0) then
 --     print("HTTP request to " .. url .. " failed " .. 'code: ' .. code .. 'date: ' .. data)
 --   else
 --     print("HTTP request to " .. url .. " succeeded")
 --   end
 --  end)
  local srv = tls.createConnection(net.TCP, 0)
  srv:on("receive", function(sck, c) print("net/TLS to " .. url .. " succeeded") end)
  srv:on("connection", function(sck, c)
    sck:send("GET " .. path .. " HTTP/1.1\r\nHost: " .. host .. "\r\nConnection: keep-alive\r\nAccept: */*\r\n\r\n")
  end)
  srv:connect(443, host)
end

-- data: { p1: 24, p2: 12 } 
local function build_url(data)
  local url = STEROWANIE_SCRYPT_URL .. '?'

  local idx = 0 -- first param is name
  for key,value in pairs(data) do
    if idx == 0 then
      separator =  ''
    else
      separator = '&'
    end
    idx = idx + 1

    url = url..separator..key..'='..value
  end

  return url
end

-- data: { name: 'szklarnia', p1: 24, p2: 12 } 
local function build_url_with_name(name, data)
  data['name'] = name;
  return build_url(data);
end

function gsheets.send_data(name, data)
  local script_url = build_url_with_name(name, data)
  local url_b64 = encoder.toBase64(script_url)

  local url =  'http://nodemcu-http2https.herokuapp.com/propagate_https?url=' .. url_b64
  print(url)

  http.get(url, nil, function(code, data)
    if (code < 0) then
      print("HTTP request failed")
    else
      -- print(code, data)
      print(code)
    end
  end)

  print("sent")
  return "OK"
  -- tls.setDebug(2)
  -- http.get('http://www.faunaflora.com.pl/arch/2001/stycz/perliczki.php')
  -- http.get('https://google.pl')
  -- local url = build_url(name, data)
  -- print(http_get('script.google.com', url))
end

function gsheets.getSwitchOptions(getOptsCallback)
  data = data or {}
  data['actionName'] = 'getSwitchOptions';

  return gsheets.executeQuery(data, getOptsCallback)
end

function gsheets.setSwitchOptions(data, setOptsCallback)
  setOptsCallback = setOptsCallback or (function (data) end)
  data['actionName'] = 'setSwitchOptions'

  return gsheets.executeQuery(data, setOptsCallback)
end

function gsheets.executeQuery(data, callback)
  local script_url = build_url(data)
  --print(script_url)
  local url_b64 = encoder.toBase64(script_url)

  local url =  'http://nodemcu-http2https.herokuapp.com/propagate_https?url=' .. url_b64
  --print(url)

  http.get(url, nil, function(code, data)
    if (code < 0) then
      print("HTTP request failed")
    else
      print(code, data)
      callback(sjson.decoder():write(data))
    end
  end)

  print("sent")
  return "OK"
end

function gsheets.getControlOptions(getOptsCallback, chipId = nil)
  data = data or {}
  data['actionName'] = 'getSwitchOptions';
  data['chipId']     = chipId 

  return gsheets.executeQuery(data, getOptsCallback)
end



return gsheets
