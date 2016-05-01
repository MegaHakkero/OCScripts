local event = require("event")
local term = require("term")
local component = require("component")

local maxWidth, maxHeight = component.gpu.maxResolution()

component.setResolution(maxWidth / 7, maxHeight / 7)

local width, height = component.gpu.getResolution()

component.gpu.fill(1, 1, width, height, " ")

function displaymsg()
  local _, _, _, _, _, message = event.pull("modem_message")
  
  component.gpu.fill(1, 1, width, height, " ")
  term.setCursor(1, 2)
  print(message)
  displaymsg()
end

displaymsg()
