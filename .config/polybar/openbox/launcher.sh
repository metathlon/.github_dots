#!/usr/bin/env bash
killall -q polybar

LOG_MAIN_BAR=~/.logs/polybar_openbox_main.log

echo " --- " $(hostname) | tee -a $LOG_MAIN_BAR

if test -f "$LOG_MAIN_BAR"; then
    echo "Log file found"
else
    touch $LOG_MAIN_BAR
fi


#--------- nombre de los monitores con xrandr -q | grep -w connected
if [[ $(hostname) == 'hades' ]]; then

    MONITOR='HDMI-0' polybar -c ~/.config/polybar/openbox/config main >> $LOG_MAIN_BAR 2>&1 &

elif [[ $(hostname) == 'udaicfernando' ]]; then
    #IZQ
    # MONITOR='DVI-I-0' polybar -c ~/.config/polybar/bspwm/config top &

    #DRCHO
    MONITOR='HDMI-0' polybar -c ~/.config/polybar/openbox/config main >> $LOG_MAIN_BAR 2>&1
fi



echo "Polybar lanzado..."
