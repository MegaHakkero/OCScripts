local component = require("component")
local shell = require("shell")

local args = shell.parse(...)

if component.modem == nil then
  print("Network card not installed")
  return
end

if #args < 1 then
  print("Usage: port_close <port>")
  return
elseif #args >= 1 then
  if string.find(args[1], "%a") then
    print("Error: Use numbers when defining ports")
    return
  elseif component.modem.isOpen(tonumber(args[1])) == false then
    print("Error: port is already closed")
    return
  else
    component.modem.close(tonumber(args[1]))
    print("Closed port " .. args[1])
    return
  end
end