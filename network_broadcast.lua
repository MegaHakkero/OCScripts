local component = require("component")
local computer = require("computer")
local shell = require("shell")

local args = shell.parse(...)

if component.modem == nil then
  print("Error: Network card not installed")
  return
end

if #args < 2 then
  print("Usage: network_broadcast <port> <message>")
  return
elseif #args >= 2 then
  if string.find(args[1], "%a") then
    print("Use numbers when defining ports")
    return
  else
    component.modem.broadcast(tonumber(args[1]), args[2])
    print("Message sent via port " .. args[1] .. ":")
    print(args[2])
    return
  end
end
