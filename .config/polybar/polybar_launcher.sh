#!/usr/bin/env bash

killall  -q polybar

echo $(hostname)

#--------- nombre de los monitores con xrandr -q | grep -w connected
if [[ $(hostname) == 'hades' ]]; then

    MONITOR='HDMI-0' polybar top &
    MONITOR='DVI-I-0' polybar top_aux &
    MONITOR='DVI-D-0' polybar top_aux &

elif [[ $(hostname) == 'udaicfernando' ]]; then
    #IZQ
    bspc monitor DVI-I-0 -d 1 2 3 4
    #DRCHO
    bspc monitor HDMI-0 -d 8 9 0

    MONITOR='HDMI-0' polybar top_aux &
    MONITOR='DVI-I-0' polybar top &
fi