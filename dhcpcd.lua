local serialize = require("serialization")
local component = require("component")
local rc = require("rc")

local ipaddresstable = {}
local mactable = {}
local ifacetable = {}

print("Calculating IPv4 and MAC addresses")

for i = 1, 4, 1 do
  ipaddresstable[i] = tostring(math.random(0, 255))
end

for i = 1, 6, 1 do
  mactable[i] = tostring(math.random(0, 99))
  
  if string.len(mactable[i]) < 2 then
    mactable[i] = "0" .. mactable[i]
  end
end

for i =

local address = ipaddresstable[1] .. "." .. ipaddresstable[2] .. "." .. ipaddresstable[3] .. "." .. ipaddresstable[4]
local bcast = ipaddresstable[1] .. "." .. ipaddresstable[2] .. "." .. ipaddresstable[3] .. ".255"
local mac = mactable[1] .. ":" .. mactable[2] .. ":" .. mactable[3] .. ":" .. mactable[4] .. ":" .. mactable[5] .. ":" .. mactable[6]

print("Assigning IPv4 address: " .. address)
print("MAC address: " .. mac)

component.computer.address = address
component.computer.bcast = bcast
component.computer.mac = mac

if component.isAvailable("modem") == false then
  print("Error: Network card not installed")
  return
end

print("Generating iface eth0")

ifacetable[1] = {
  name = "eth0",
  encap = "Ethernet",
  addr = address,
  hwaddr = mac,
  broadcast = bcast,
  submask = "255.255.255.0",
  flags = {"UP", "BROADCAST", "RUNNING", "MULTICAST"},
  rx = 0
}

if component.modem.isWireless() == true then
  print("Generating iface wlan0")
  ifacetable[2] = {
    name = "wlan0",
    encap = "Wireless",
    addr = address,
    hwaddr = mac,
    broadcast = bcast,
    submask = "255.255.255.0",
    flags = {"UP", "BROADCAST", "RUNNING", "MULTICAST"},
    rx = 0
  }
end

print("Saving ifaces to /etc/ifaces")

local ifacefile = io.open("/etc/ifaces", "w")
ifacefile:write("")
ifacefile:close()

ifacefile = io.open("/etc/ifaces", "a")

for i = 1, #ifacetable, 1 do
  ifacefile:write(ifacetable[i].name .. " = " .. serialize.serialize(ifacetable[i], false) .. "\n")
end

ifacefile:close()

print("Done loading network interfaces")
print("Generating rxdaemon")

local rxcode = [[ 
  local event = require("event")
  local rxfile = io.open("/etc/rxpackets", "r")
  
  local rxpackets = rxfile:read("*a")
  rxfile:close()
  
  function start()
    event.listen("modem_message", writeReceivedPackets())
  end
  
  function writeReceivedPackets()
    rxpackets = rxpackets + 1
    
    rxfile = io.open("/etc/rxpackets", "w")
    rxfile:write(rxpackets)
    rxfile:close()
  end
]]

local rxdaemon = io.open("/etc/rc.d/rxdaemon.lua", "w")

rxdaemon:write(rxcode)

rxdaemon:close()

print("Loading rxdaemon")

rc.runCommand("rxdaemon", "start")
rc.runCommand("rxdaemon", "enable")

print("Done")
