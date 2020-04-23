#!/usr/bin/env python3
#
#=====================================================================
#  Sintax:
#  keybinding_help_rofi.py <WM> [file]
#
#  Example:
#  keybinding_help_rofi_script.py i3
#  keybinding_help_rofi_script.py i3 ~/.config/i3/custom.config.i3
#
#=====================================================================

import sys
import os
from os.path import expanduser

HOME = expanduser("~")



if len(sys.argv) < 2:
    exit("Insufficient arguments: "+str(len(sys.argv)))

WM=sys.argv[1]



def get_config_from_wm(args):
    WM_CONFIGS = {
        "i3": HOME + "/.config/i3/config",
    }

    if len(args) > 3:
        return args[2]

    return WM_CONFIGS.get(WM, False)

CONFIG_FILE = get_config_from_wm(sys.argv)

if not(CONFIG_FILE) :
    exit("No file available")

with open(CONFIG_FILE,"r") as conf_file:
    info = []
    ln_prev = ""
    help_lines = ""
    for ln in conf_file:
        if ln.startswith("bindsym "):
            if ln_prev.startswith("# --"):
                info.append((ln.split()[1],ln_prev))
                help_lines = help_lines + ln.split()[1] + "   " + ln_prev
        ln_prev = ln

ROFI = "rofi -dmenu -i -no-shadow-icons -width 1000"
os.system("echo -e '"+ help_lines + "' | " + ROFI)
