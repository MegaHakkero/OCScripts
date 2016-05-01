local component = require("component")
local shell = require("shell")
local gpu = component.gpu

local args = shell.parse(...)

if #args < 2 then
  print("Usage: displaymanager screen|gpu <address>")
  return
else
  if args[1] == "screen" then
    local screen = component.get(args[2])
    if screen == nil or component.type(screen) ~= "screen" then
      print("Error: This component is invalid")
      return
    else
      print("Binding to " .. screen)
      gpu.bind(screen)
    end
  elseif args[1] == "gpu" then
    local gpu = component.get(args[2])
    if gpu == nil or component.type(gpu) ~= "gpu" then
      print("Error: this component is invalid")
      return
    else
      print("Setting primary gpu to " .. gpu)
      component.setPrimary("gpu", gpu)
      return
    end
  end
end
