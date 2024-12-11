#!/bin/bash

# Check if led_pin is provided as an argument
if [[ $# -eq 0 ]]; then
    echo "Usage: $0 <led_pin>"
    exit 1
fi

led_pin=$1

is_connected=0

last_check_millis=0
last_blink_millis=0

pigs w $led_pin 0

# Loop indefinitely
while true
do
    curr_millis=$(date +%s%3N)
    difference=`expr $curr_millis - $last_check_millis`
    #echo "$difference"
    if [[ $difference -gt 10000 ]]; then
        #echo "Check status"
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
        last_check_millis=$curr_millis


        if [[ "$is_on" -ne 1 ]] && [[ "$is_connected" -eq 1 ]]; then
            #echo "On"
            pigs w $led_pin 1
            is_on=1
        fi
    fi

    if [[ "$is_connected" -ne 1 ]] then
        if [[ "$is_on" -eq 1 ]]; then
            #echo "Blink On"
            pigs w $led_pin 0
            is_on=0
        else
            #echo "Blink Off"
            pigs w $led_pin 1
            is_on=1
        fi
        last_blink_millis=$curr_millis
    fi


    # Sleep for 1 seconds
    sleep 1
done