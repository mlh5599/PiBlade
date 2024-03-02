# PiLEDlights

## Description
For the Raspberry Pi - Make LEDs blink on network and/or SD card/USB storage activity.

Based on the [PiLEDLights](https://github.com/RagnarJensen/PiLEDlights) project by Ragnar Jensen utilizing pigpio instead of WiringPi for GPIO manipulation.

hddledPi blinks a LED connected to a GPIO pin on any mass storage access. Not only on SD card access, but also on USB thumbdrive and hard drive activity.  
netledPi blinks a LED connected to a GPIO pin when there is activity on any network interface. Not only the built-in ethernet interface, but also on any other USB ethernet or WiFi interface.  
actledPi blinks the Pi's ACT led on all mass storage I/O, i.e. not only the SD card.
tailscaleledPi turns on the LED if tailscale is connected and flashes if it is not.


## Prerequisites
This application uses pigpiod instead of WiringPi for GPIO manipulation. 

To install the application
``` sh
sudo apt-get update
sudo apt-get install pigpiod
```

Enable and start the service:
``` sh
sudo systemctl enable pigpiod
sudo systemctl start pigpiod
```

## Building
``` sh
gcc -Wall -pthread -o actledPi actledPi.c
gcc -Wall -pthread -o netledPi netledPi.c -lpigpiod_if2 -lrt
gcc -Wall -pthread -o hddledPi hddledPi.c -lpigpiod_if2 -lrt
```

## Installation
Copy the compiled program files to /usr/local/bin and follow the instructions in the initscripts [README](initscripts/README.md) to run as a daemon.
