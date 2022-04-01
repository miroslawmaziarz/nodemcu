
local function write(filename, data)
  local save_file = file.open(filename, "a+")
  save_file:writeline(data)
  save_file:close()
end

local function read_all(filename)
  local file_data = file.open(filename, "r")

  if file_data then
    local data = file_data:read()
    file_data:close(); file_data = nil
    return data
  end
end

local function read_and_clear(filename)
  local data = read_all(filename)
  file.remove(filename)
  return data
end

local M = {
  write = write,
  read_all = read_all,
  read_and_clear = read_and_clear
}
return M
