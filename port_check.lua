local computer = require("computer")
local component = require("component")
local shell = require("shell")

local args = shell.parse(...)

if component.modem == nil then
  print("Error: Network card is not installed")
  return
end

if #args < 1 then
  print("Open ports on " .. computer.address() .. ":")

  for i = 1, 10000, 1 do
    if component.modem.isOpen(i) == true then
      print(i)
    end
  end

  return
elseif #args >= 1 then
  if string.find(args[1], "%a") then
    print("Error: Use numbers when defining port")
    return
  else
    if component.modem.isOpen(tonumber(args[1])) then
      print("Port is open")
      return
    else
      print("Port is closed")
      return
    end
  end
end