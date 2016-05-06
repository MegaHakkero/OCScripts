local component = require("component")

local ipaddresstable = {0,0,0,0}

for i = 1, 4, 1 do
  ipaddresstable[i] = tostring(math.random(0, 255))
end

local ipaddress = ipaddresstable[1] .. "." .. ipaddresstable[2] .. "." .. ipaddresstable[3] .. "." .. ipaddresstable[4]
component.computer.address = ipaddress