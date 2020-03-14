#!/usr/bin/env bash

question=$(echo " Lock| Apagar| Logout| Reboot" | rofi -sep "|" \
    -dmenu -i -p 'System: ' "" -width 20 -hide-scrollbar \
    -eh 1 -line-padding 4 -padding 20 -lines 4 -color-enabled)

case $question in
    *Lock)
        i3lock-fancy-dualmonitor
        ;;
    *Logout)
        #command -v gnome-session-quit 2>/dev/null 2>&1 || command -v session-logout >/dev/null 2>&1
        case $(wmctrl -m | grep Name) in
            *Openbox) cmd="openbox --exit" ;;
            *bspwm) cmd="bspc quit" ;;
            *Metacity) cmd="gnome-save-session --kill" ;; 
            *) exit 1 ;;
        esac
        ;;
    *Reboot)
        systemctl reboot
        ;;
    *Apagar)
        systemctl poweroff
        ;;
    *)
        exit 0  # do nothing on wrong response
        ;;
esac