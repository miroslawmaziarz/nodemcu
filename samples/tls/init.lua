print('start test !!')

function test(host, path)
  local url = "https://" .. host .. path;
  http.get(url, nil, function(code, data)
    if (code < 0) then
      print("HTTP request to " .. url .. " failed")
    else
      print("HTTP request to " .. url .. " succeeded")
    end
  end)
  local srv = tls.createConnection(net.TCP, 0)
  srv:on("receive", function(sck, c) print("net/TLS to " .. url .. " succeeded") end)
  srv:on("connection", function(sck, c)
    sck:send("GET " .. path .. " HTTP/1.1\r\nHost: " .. host .. "\r\nConnection: keep-alive\r\nAccept: */*\r\n\r\n")
  end)
  srv:connect(443, host)
end
test("raw.githubusercontent.com", "/espressif/esptool/master/MANIFEST.in")
