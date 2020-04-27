#!/usr/bin/env python3
#
# =====================================================================
#  Sintax:
#  keybinding_help_rofi.py <WM> [file]
#
#  Example:
#  keybinding_help_rofi_script.py i3
#  keybinding_help_rofi_script.py i3 ~/.config/i3/custom.config.i3
#
# =====================================================================

import sys
import os
from os.path import expanduser


ERROR_MSG = {
    "insuf.args": "Insufficient Arguments provided. Num provided: ",
    "no.config": "Default config not found. Please provide path to config.",
}
HOME = expanduser("~")


if len(sys.argv) < 2:
    os.system("rofi -e '" + ERROR_MSG.get("insuf.args") +
              str(len(sys.argv) - 1) + "'")
    exit()

WM = sys.argv[1]


def get_default_config_from_wm():
    """
    Function to return the full path to config file
    """
    WM_CONFIGS = {
        "i3": HOME + "/.config/i3/config",
    }

    return WM_CONFIGS.get(WM, False)


if len(sys.argv) > 3:
    CONFIG_FILE = sys.argv[2]
else:
    CONFIG_FILE = get_default_config_from_wm()

if not(CONFIG_FILE):
    os.system("rofi -e '" + ERROR_MSG.get("no.config") + "'")
    exit()

with open(CONFIG_FILE, "r") as conf_file:
    info = []
    ln_prev = ""
    max_key_length = 0
    for ln in conf_file:
        ln = ln.lstrip()
        if ln.startswith("bindsym "):
            if ln_prev.startswith("# -- "):
                # split divide por espacios, así que "# -- Texto ayuda" se puede dividir como:
                # split() -> ['#','--','Texto','ayuda']
                # split(maxsplit=2) -> ['#','--','Texto ayuda']
                teclas = ln.split()[1].replace("$", "")
                ayuda = ln_prev.split(maxsplit=2)[2]
                info.append((teclas, ayuda))
                if len(teclas) > max_key_length:
                    max_key_length = len(teclas)

        elif ln.startswith("# --- "):
            ayuda = ln.split(maxsplit=2)[2]
            info.append((ayuda,"#"))
        ln_prev = ln

rofi_help_lines = ""
yad_help_lines = ""
max_length = 0
for teclas, ayuda in info:

    if (ayuda == "#"):
        new_line = "----- " + "  " + teclas.ljust(max_key_length)
    else:
        new_line = teclas.ljust(max_key_length) + "  " + ayuda + ""
    if (len(new_line) > max_length):
        max_length = len(new_line)
    rofi_help_lines = rofi_help_lines + new_line
    yad_help_lines = yad_help_lines + '"' + teclas + '" "' + ayuda + '" '

# We have maximun length of line, lets add 5 just to make some space
max_length = max_length + 5
# COMMAND based on rofi
COMMAND = 'echo -e "' + rofi_help_lines + \
    '" | rofi -dmenu -i -no-shadow-icons -width -' + str(max_length)

# COMMAND based on yad
# COMMAND = 'yad --width 300 --title "Ayuda teclas" --list --separator="|" --column "Tecla" --column "Accion" ' + yad_help_lines

os.system(COMMAND)
