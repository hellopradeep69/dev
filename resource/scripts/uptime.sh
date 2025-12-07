#!/bin/bash

while true; do
    echo "$(uptime -p)" > ~/.config/i3status/uptime.txt
    sleep 30
done

