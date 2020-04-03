#!/usr/bin/env bash

killall  -q polybar


LOG_MAIN_BAR="/tmp/polybar_bspwm_main.log"
LOG_AUX_1_BAR="/tmp/polybar_bspwm_aux_1.log"
LOG_AUX_2_BAR="/tmp/polybar_bspwm_aux_2.log"

echo $(hostname)

#--------- nombre de los monitores con xrandr -q | grep -w connected
if [[ $(hostname) == 'hades' ]]; then

    MONITOR='HDMI-0' polybar -c ~/.config/polybar/bspwm/config top >> $LOG_MAIN_BAR 2>&1 &
    MONITOR='DVI-I-0' polybar -c ~/.config/polybar/bspwm/config top_aux >> $LOG_AUX_1_BAR 2>&1 &
    MONITOR='DVI-D-0' polybar -c ~/.config/polybar/bspwm/config top_aux  >> $LOG_AUX_2_BAR 2>&1 &

elif [[ $(hostname) == 'udaicfernando' ]]; then
    #IZQ
    bspc monitor DVI-I-0 -d 1 2 3 4
    #DRCHO
    bspc monitor HDMI-0 -d 8 9 0

    MONITOR='HDMI-0' polybar -c ~/.config/polybar/bspwm/config top_aux  >> $LOG_AUX_1_BAR 2>&1 &
    MONITOR='DVI-I-0' polybar -c ~/.config/polybar/bspwm/config top  >> $LOG_MAIN_BAR 2>&1 &
fi
