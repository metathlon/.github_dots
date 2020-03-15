#! /bin/bash

killall -q picom
picom &

killall -q nitrogen
nitrogen --restore &

#exec /usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 & eval $(gnome-keyring-daemon -s --components=pkcs11,secrets,ssh,gpg) &
