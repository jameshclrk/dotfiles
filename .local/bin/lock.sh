#!/bin/sh
player_status=$(playerctl status)
grim /tmp/lock.png
convert /tmp/lock.png -scale 2% -scale 5000% -brightness-contrast -1x0 /tmp/lock.png
test "$player_status" = "Playing" && playerctl pause
swaylock -u -e -i /tmp/lock.png
test "$player_status" = "Playing" && playerctl play
rm /tmp/lock.png
