#!/bin/bash

# Check if led_pin is provided as an argument
if [[ $# -eq 0 ]]; then
    echo "Usage: $0 <led_pin>"
    exit 1
fi

led_pin=$1
is_connected=0

pigs w $led_pin 0

# Loop indefinitely
while true
do
    # Check tailscale daemon status
    tailscale_status=$(tailscale status | grep "Tailscale is stopped." | wc -l)
    # If tailscale is running, turn off the lights via pigpio, if not, turn them on
    if [[ "$tailscale_status" -eq 1 ]]; then
        # Lights should flash
        is_connected=0
    else
        # Turn on the lights
        is_connected=1
    fi

    if [[ "$is_connected" -eq 1 ]]; then
        pigs w $led_pin 1
    else
        is_on=$(pigs r $led_pin)
        if [[ "$is_on" -eq 1 ]]; then
            pigs w $led_pin 0
        else
           pigs w $led_pin 1
        fi
    fi


    # Sleep for .5 seconds
    sleep .5
done