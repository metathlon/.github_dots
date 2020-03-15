# Copyright (c) 2010 Aldo Cortesi
# Copyright (c) 2010, 2014 dequis
# Copyright (c) 2012 Randall Ma
# Copyright (c) 2012-2014 Tycho Andersen
# Copyright (c) 2012 Craig Barnes
# Copyright (c) 2013 horsik
# Copyright (c) 2013 Tao Sauvage
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

import os
import re
import socket
import subprocess
import platform
import sys
import logging


from libqtile.config import Key, Screen, Group, Drag, Click
from libqtile.lazy import lazy
from libqtile import layout, bar, widget, hook

from typing import List  # noqa: F401

from qtile_caronte_monitor_num import *
from qtile_caronte_widgets import *
from qtile_validate_and_reload import *


#======================================================================================
# ---- CHANGE THIS CONFIG
#======================================================================================
DEBUG = os.environ.get("DEBUG")
HOME = os.path.expanduser('~')
QTILE_CONFIG_DIR = HOME + '/.config/qtile/'
ROFI_SCRIPTS_DIR = HOME + '/.config/rofi/'
MY_TERM = "alacritty"
MY_ETHERNET = "enp3s0"
MAIN_MONITOR_NUM = 0     # to configure this you can run "python ~/.config/qtile/config.py" it will show the numbes

#------------------------------------------------------------------------------------------------------
# If you want all groups in all monitors:
#
# MONITOR_GROUP_DIVIDE = FALSE
#
# If you want groups to be assigned a monitors:
#
# To assign a group name to a monitor, the monitor numbers go from 0 to (total of monitors -1)
# you can find how many you have with python config.py
#
# MONITOR_GROUPS_NUM[MONITOR_NUM] = "GROUP_NAME"
#
# To assign tags to the monitor group
# MONITOR_GROUPS["GROUP_NAME"] = ["G1", "G2"]
#
# The groups will be accesible with numbers
#
#
#--------------------------------------------------------------------------------------------------------
# *** monitor_num -> group_name
MONITOR_GROUPS_NUM = {}
MONITOR_GROUPS_NUM[0] = "MAIN"
MONITOR_GROUPS_NUM[1] = "AUX_LEFT"
MONITOR_GROUPS_NUM[2] = "AUX_RIGHT"

MONITOR_GROUPS = {}
MONITOR_GROUPS["MAIN"] = [
                          ("MAIN", {'layout': 'monadtall'}),
                          ("CODE", {'layout': 'monadtall'}),
                          ("GAMES", {'layout': 'monadtall'}),
                          ]
MONITOR_GROUPS["AUX_RIGHT"] = [
                                  ("WWW", {'layout': 'monadtall'}),
                                  ("WWW2", {'layout': 'monadtall'}),
                                  ("WWW3", {'layout': 'monadtall'}),
                              ]
MONITOR_GROUPS["AUX_LEFT"] = [
                                  ("VIDEO", {'layout': 'monadtall'}),
                                  ("AUX2", {'layout': 'monadtall'}),
                                  ("AUX3", {'layout': 'monadtall'}),

                             ]

#----------- LOGGIN
LOG=True
LOG_DIR=HOME + "/.local/share/qtile/caronte/"

#======================================================================================
# ---- LOGGER
#======================================================================================
if LOG:
    if not os.path.exists(LOG_DIR):
        os.mkdir(LOG_DIR)

    logging.basicConfig(
        filename=LOG_DIR + 'caronte_qtile.log',
        filemode="a",
        format="%(asctime)s - %(name)s - %(levelname)s - %(message)s",
        level=logging.INFO,
    )


#======================================================================================
# ---- MONITORS IDENTIFICATION
#======================================================================================
monitor_list = get_monitors()
num_monitors = get_num_monitors(monitor_list)


#======================================================================================
# ---- QTILE CONFIG
#======================================================================================
hostname = platform.uname().node
mod = "mod4"
space = 12



# Si arrancamos en modo debug cambiamos el "modificador" a bloqueo de mays, para evitar liarla con los qtile al tiempo
if DEBUG:
    hostname = "PRUEBAS"
    mod = "lock"  # Cambiamos el MOD a Caps-Lock


#-----------------------------------------------------------------------
# --- ASSIGN BARS TO MONITORS
#---------------------------------------------------------------------

if 'MAIN_MONITOR_NUM' not in globals():
    print("NO MAIN MONITOR SELECTED - edit ~/.conifg/qtile/config.py  to select main monitor. Defaulting to 0")
    MAIN_MONITOR_NUM = 0


print("MONITORS TOTAL: ", num_monitors)
# screens = []
if num_monitors > 1:
    # screens =[]
    for count in range(num_monitors):
        current_group = MONITOR_GROUPS_NUM[count]
        widgets = []

        if (count == MAIN_MONITOR_NUM):
            #---- this is the main monitor
            widgets_no_group = init_widgets_list(MY_ETHERNET)
        else:
            widgets_no_group = init_widgets_list(MY_ETHERNET)[0:5]

        #widgets_with_group = []
        #widgets_with_group.append([widget.GroupBox(visible_groups = MONITOR_GROUPS[current_group])])
        widgets_with_group = [widget.GroupBox(visible_groups = [name for name in MONITOR_GROUPS[current_group]])]+widgets_no_group
        

        # print(widgets_with_group)
        if count > 0:
            #print("ADD OTHER SCREEN")
            #groups = groups + [Group(name, **kwargs) for name, kwargs in MONITOR_GROUPS[current_group]]
            for name, kwargs in MONITOR_GROUPS[current_group]:
                print(name)
                groups = groups + [Group(name, **kwargs)]
            screens.append(
                           Screen(top=bar.Bar(widgets=widgets_with_group, opacity=0.95, size=20)),
            )
        else:
            #print("ADD FIRST SCREEN")
            groups =[]
            for name, kwargs in MONITOR_GROUPS[current_group]:
                print(name)
                groups = groups + [Group(name, **kwargs)]
            #groups = [Group(name, **kwargs) for name, kwargs in MONITOR_GROUPS[current_group]]
            screens = [Screen(top=bar.Bar(widgets=widgets_with_group, opacity=0.95, size=20)),]
else:
    groups = [Group(name, **kwargs) for name, kwargs in MONITOR_GROUPS["MAIN"]]
    screens = [
                Screen(top=bar.Bar(widgets=init_widgets_list(MY_ETHERNET), opacity=0.95, size=20)),
              ]



# assign_bar_to_monitors()
# print(screens)

keys = [
    # Switch between windows in current stack pane
    Key([mod], "k", lazy.layout.down()),
    Key([mod], "j", lazy.layout.up()),

   # Move windows up or down in current stack
    Key([mod, "control"], "k", lazy.layout.shuffle_down()),
    Key([mod, "control"], "j", lazy.layout.shuffle_up()),

    # Switch window focus to other pane(s) of stack
    # Key([mod], "space", lazy.layout.next()),

    # Swap panes of split stack
    Key([mod, "shift"], "space", lazy.layout.rotate()),

    # Toggle between split and unsplit sides of stack.
    # Split = all windows displayed
    # Unsplit = 1 window displayed, like Max layout, but still with
    # multiple stack panes
    Key([mod, "shift"], "Return", lazy.layout.toggle_split()),
    Key([mod], "Return", lazy.spawn(MY_TERM)),

    # Toggle between different layouts as defined below
    Key([mod], "Tab", lazy.next_layout()),
    Key([mod], "w", lazy.window.kill()),

    # Key([mod, "mod1"], "r", lazy.restart()), # lo quito porque hago la validación abajo
    Key([mod, "control"], "r", lazy.restart()),
    Key([mod, "mod1"], "r", validate_and_restart),
    Key([mod, "mod1"], "q", lazy.shutdown()),
    Key([mod], "r", lazy.spawncmd()),
    Key([mod, "mod1"], "Escape", lazy.spawn(ROFI_SCRIPTS_DIR +'rofi_logout.sh') ),

    Key([mod], "space", lazy.spawn(ROFI_SCRIPTS_DIR + 'rofi_menu.sh')),
]


##### GROUPS #####
# group_names = [("MAIN", {'layout': 'monadtall'}),
#                ("INFO", {'layout': 'monadtall'}),
#                ("VIDEO", {'layout': 'monadtall'}),
#                ("STATS", {'layout': 'monadtall'}),
#                ("GAMES", {'layout': 'monadtall'}),
#                ("FONDO1", {'layout': 'monadtall'}),
#                ("FONDO2", {'layout': 'monadtall'}),
#                ("FONDO3", {'layout': 'monadtall'}),
#                ("GTX", {'layout': 'floating'})]

# groups = [Group(name, **kwargs) for name, kwargs in group_names]

# for i, (name, kwargs) in enumerate(group_names, 1):
#     keys.append(Key([mod], str(i), lazy.group[name].toscreen()))        # Switch to another group
#     keys.append(Key([mod, "shift"], str(i), lazy.window.togroup(name))) # Send current window to another group
    

##### DEFAULT THEME SETTINGS FOR LAYOUTS #####
layout_theme = {"border_width": 2,
                "margin": 4,
                "border_focus": "AD69AF",
                "border_normal": "1D2330"
                }

##### THE LAYOUTS #####
layouts = [
    layout.Max(),
    layout.Stack(num_stacks=2),
    #layout.MonadWide(**layout_theme),
    #layout.Bsp(**layout_theme),
    #layout.Stack(stacks=2, **layout_theme),
    #layout.Columns(**layout_theme),
    #layout.RatioTile(**layout_theme),
    #layout.VerticalTile(**layout_theme),
    #layout.Tile(shift_windows=True, **layout_theme),
    #layout.Matrix(**layout_theme),
    #layout.Zoomy(**layout_theme),
    layout.MonadTall(**layout_theme),
    layout.Max(**layout_theme),
    layout.TreeTab(
         font = "Ubuntu",
         fontsize = 10,
         sections = ["FIRST", "SECOND"],
         section_fontsize = 11,
         bg_color = "141414",
         active_bg = "90C435",
         active_fg = "000000",
         inactive_bg = "384323",
         inactive_fg = "a0a0a0",
         padding_y = 5,
         section_top = 10,
         panel_width = 320
         ),
     layout.Floating(**layout_theme)
]

##### SCREENS ##### (TRIPLE MONITOR SETUP)

#     return widgets_screen1                       # Sl.nameicing removes unwanted widgets on Monitors 1,3

# def init_widgets_main_screen():
#     widgets_screen2 = init_widgets_list(MY_ETHERNET)
#     return widgets_screen2                       # Monitor 2 will display all widgets in widgets_list

#----------------------------- REMOVED TO MAKE IT DYNAMIC
# def init_screens():
#     return [Screen(top=bar.Bar(widgets=init_widgets_aux_screen(), opacity=0.95, size=20)),
#             Screen(top=bar.Bar(widgets=init_widgets_main_screen(), opacity=0.95, size=20)),
#             Screen(top=bar.Bar(widgets=init_widgets_aux_screen(), opacity=0.95, size=20))]

# if __name__ in ["config"]:
#     # screens = init_screens()
#     widgets_list = init_widgets_list()
#     widgets_aux_screen = init_widgets_aux_screen()
#     widgets_main_screen = init_widgets_main_screen()

##### DRAG FLOATING WINDOWS #####
mouse = [
    Drag([mod], "Button1", lazy.window.set_position_floating(),
         start=lazy.window.get_position()),
    Drag([mod], "Button3", lazy.window.set_size_floating(),
         start=lazy.window.get_size()),
    Click([mod], "Button2", lazy.window.bring_to_front())
]

dgroups_key_binder = None
dgroups_app_rules = []  # type: List
main = None
follow_mouse_focus = True
bring_front_click = False
cursor_warp = False

##### FLOATING WINDOWS #####
floating_layout = layout.Floating(float_rules=[
    {'wmclass': 'confirm'},
    {'wmclass': 'dialog'},
    {'wmclass': 'download'},
    {'wmclass': 'error'},
    {'wmclass': 'file_progress'},
    {'wmclass': 'notification'},
    {'wmclass': 'splash'},
    {'wmclass': 'toolbar'},
    {'wmclass': 'confirmreset'},  # gitk
    {'wmclass': 'makebranch'},  # gitk
    {'wmclass': 'maketag'},  # gitk
    {'wname': 'branchdialog'},  # gitk
    {'wname': 'pinentry'},  # GPG key password entry
    {'wmclass': 'ssh-askpass'},  # ssh-askpass
])
auto_fullscreen = True
focus_on_window_activation = "smart"

@hook.subscribe.startup_once
def autostart():
    if not DEBUG:
        subprocess.call(QTILE_CONFIG_DIR + 'autostart.sh')

# XXX: Gasp! We're lying here. In fact, nobody really uses or cares about this
# string besides java UI toolkits; you can see several discussions on the
# mailing lists, GitHub issues, and other WM documentation that suggest setting
# this string if your java app doesn't work correctly. We may as well just lie
# and say that we're a working one by default.
#
# We choose LG3D to maximize irony: it is a 3D non-reparenting WM written in
# java that happens to be on java's whitelist.
wmname = "LG3D"



if __name__ == "__main__":
    try:
        validate_config()
    except ConfigError as error:
        print(str(error), file=sys.stderr)
        sys.exit(1)
    else:
        print("OK!")
        sys.exit(0)
