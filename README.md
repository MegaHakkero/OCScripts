# OCScripts #

A host of scripts for OpenComputers, the advanced version of the Minecraft mod known as ComputerCraft.
These scripts at least work on OpenOS; I haven't experimented with Plan9K yet, so don't kill me if they don't work on it.

## Usage, requirements & info ##

All of the programs require working graphics components (screen & GPU or accelerated CPU), duh

<br />

### port_open, port_close, port_check ###

Usage:

    port_open <port>  
    port_close <port>  
    port_check [port]

- A working network card, wireless or not

They open, close and check for open network ports, in that order.
Meant to be used with both servers and clients (mostly clients for some reason) for message transmission.
If no port is defined for port_check, it scans all open ports within the range of 1 to 10000.
Otherwise it tells you whether the specified port is open or closed

<br />

### network_broadcast ###

Usage:

    network_broadcast <port> <message>  

- A working network card, wireless or not

Broadcasts messages via the specified port

<br />

### network_messagedisplay ###

Usage:

    network_messagedisplay  

- A working network card, wireless or not

Opens a message display with a reduced resolution to make reading of messages easier without getting close to the screen.
Best used on the back wall of a huge factory or to send hilarious messages via twitter.
Once you exit the program (ctrl + alt + C), the resolution won't change back, so you'll have to change it back in the interactive lua prompt by typing "local x, y = component.gpu.maxResolution() component.gpu.setResolution(x, y)"

<br />

### displaymanager ###

Usage:

    displaymanager screen|gpu <component address or part of it>
    
- No additional requirements

Binds CPUs to screens or selects the primary CPU on the fly if you have several ones

<br />

### dhcpcd ###

Usage:

    dhcpcd
    
- No additional requirements

Assigns a random IPv4 address to your computer. The numbers are completely random between 0 and 255 just like real IPv4. It doesn't detect for overlapping addresses though so don't kill me if you get several computers with the same address (that would take like 14234234 computers on the same network anyway)
