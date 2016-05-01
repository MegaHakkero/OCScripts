local component = require("component")
local shell = require("shell")
local computer = require("computer")

local args = shell.parse(...)

if component.modem == nil then
  print("Error: Network card not installed")
  return
end

if #args < 1 then
  print("Usage: port_open <port>")
  return
elseif #args >= 1 then
  if string.find(args[1], "%a") then
    print("Error: Use only numbers when defining port")
    return
  elseif component.modem.isOpen(tonumber(args[1])) == true then
    component.modem.close(tonumber(args[1]))
    component.modem.open(tonumber(args[1]))
    print("Refreshed port " .. args[1])
  else
    component.modem.open(tonumber(args[1]))
    print("Port " .. args[1] .. " opened on device " .. computer.address())
    return
  end
end