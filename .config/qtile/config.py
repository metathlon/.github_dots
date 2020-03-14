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


#======================================================================================
# ---- CHANGE THIS CONFIG
#======================================================================================
DEBUG = os.environ.get("DEBUG")
HOME = os.path.expanduser('~')
QTILE_CONFIG_DIR = HOME + '/.config/qtile/'
ROFI_SCRIPTS_DIR = HOME + '/.config/rofi/'
MY_TERM = "alacritty"
MY_ETHERNET = "enp3s0"

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


logging.info("ARRANCAMOS QTILE")





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

keys = [
    # Switch between windows in current stack pane
    Key([mod], "k", lazy.layout.down()),
    Key([mod], "j", lazy.layout.up()),

    # Move windows up or down in current stack
    Key([mod, "control"], "k", lazy.layout.shuffle_down()),
    Key([mod, "control"], "j", lazy.layout.shuffle_up()),

    # Switch window focus to other pane(s) of stack
    Key([mod], "space", lazy.layout.next()),

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
    # Key(["mod4", "control"], "r", validate_and_restart),
    Key([mod, "mod1"], "q", lazy.shutdown()),
    Key([mod], "r", lazy.spawncmd()),
    Key([mod, "mod1"], "Escape", lazy.spawn(ROFI_SCRIPTS_DIR +'rofi_logout.sh') ),

    Key([mod], "space", lazy.spawn(ROFI_SCRIPTS_DIR + 'rofi_menu.sh')),
]


##### GROUPS #####
group_names = [("MAIN", {'layout': 'monadtall'}),
               ("INFO", {'layout': 'monadtall'}),
               ("VIDEO", {'layout': 'monadtall'}),
               ("STATS", {'layout': 'monadtall'}),
               ("GAMES", {'layout': 'monadtall'}),
               ("FONDO1", {'layout': 'monadtall'}),
               ("FONDO2", {'layout': 'monadtall'}),
               ("FONDO3", {'layout': 'monadtall'}),
               ("GTX", {'layout': 'floating'})]

groups = [Group(name, **kwargs) for name, kwargs in group_names]

for i, (name, kwargs) in enumerate(group_names, 1):
    keys.append(Key([mod], str(i), lazy.group[name].toscreen()))        # Switch to another group
    keys.append(Key([mod, "shift"], str(i), lazy.window.togroup(name))) # Send current window to another group
    

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

##### COLORS #####
colors = [["#282a36", "#282a36"], # panel background
          ["#434758", "#434758"], # background for current screen tab
          ["#ffffff", "#ffffff"], # font color for group names
          ["#ff5555", "#ff5555"], # background color for layout widget
          ["#A77AC4", "#A77AC4"], # dark green gradiant for other screen tabs
          ["#7197E7", "#7197E7"]] # background color for pacman widget

##### PROMPT #####
prompt = "{0}@{1}: ".format(os.environ["USER"], socket.gethostname())
    
##### DEFAULT WIDGET SETTINGS #####
widget_defaults = dict(
    font="Ubuntu Mono",
    fontsize = 12,
    padding = 2,
    background=colors[2]
)
extension_defaults = widget_defaults.copy()

##### WIDGETS #####

def init_widgets_list():
    widgets_list = [
               widget.Sep(
                        linewidth = 0,
                        padding = 6,
                        foreground = colors[2],
                        background = colors[0]
                        ),
               widget.GroupBox(font="Ubuntu Bold",
                        fontsize = 9,
                        margin_y = 0,
                        margin_x = 0,
                        padding_y = 5,
                        padding_x = 5,
                        borderwidth = 1,
                        active = colors[2],
                        inactive = colors[2],
                        rounded = False,
                        highlight_method = "block",
                        this_current_screen_border = colors[4],
                        this_screen_border = colors [1],
                        other_current_screen_border = colors[0],
                        other_screen_border = colors[0],
                        foreground = colors[2],
                        background = colors[0]
                        ),
               widget.Prompt(
                        prompt=prompt,
                        font="Ubuntu Mono",
                        padding=10,
                        foreground = colors[3],
                        background = colors[1]
                        ),
               widget.Sep(
                        linewidth = 0,
                        padding = 10,
                        foreground = colors[2],
                        background = colors[0]
                        ),
               widget.WindowName(font="Ubuntu",
                        fontsize = 11,
                        foreground = colors[4],
                        background = colors[0],
                        padding = 5
                        ),
               widget.TextBox(
                        text='',
                        background = colors[0],
                        foreground = colors[4],
                        padding=0,
                        fontsize=37
                        ),
               widget.TextBox(
                        font="Ubuntu Bold",
                        text=" ⟳",
                        padding = 5,
                        foreground=colors[2],
                        background=colors[4],
                        fontsize=14
                        ),
               widget.Pacman(
                        execute = "alacritty",
                        update_interval = 1800,
                        foreground = colors[2],
                        background = colors[4]
                        ),
               widget.TextBox(
                        text="Updates",
                        padding = 5,
                        foreground=colors[2],
                        background=colors[4]
                        ),
               widget.TextBox(
                        text='',
                        background = colors[4],
                        foreground = colors[5],
                        padding= 0,
                        fontsize=37
                        ),
               widget.TextBox(
                        text=" 🖬",
                        foreground=colors[2],
                        background=colors[5],
                        padding = 0,
                        fontsize=14
                        ),
               widget.Memory(
                        foreground = colors[2],
                        background = colors[5],
                        padding = 5
                        ),
               widget.TextBox(
                        text='',
                        background = colors[5],
                        foreground = colors[4],
                        padding=0,
                        fontsize=37
                        ),
               widget.TextBox(
                        text=" ↯",
                        foreground=colors[2],
                        background=colors[4],
                        padding = 0,
                        fontsize=14
                        ),
               widget.Net(
                        interface = MY_ETHERNET,
                        foreground = colors[2],
                        background = colors[4],
                        padding = 5
                        ),
               widget.TextBox(
                        text='',
                        background = colors[4],
                        foreground = colors[5],
                        padding=0,
                        fontsize=37
                        ),
               widget.TextBox(
                        font="Ubuntu Bold",
                        text=" ♫",
                        padding = 5,
                        foreground=colors[2],
                        background=colors[5],
                        fontsize=14
                        ),
               widget.Cmus(
                        max_chars = 40,
                        update_interval = 0.5,
                        background=colors[5],
                        play_color = colors[2],
                        noplay_color = colors[2]
                        ),      
               widget.TextBox(
                        text='',
                        background = colors[5],
                        foreground = colors[4],
                        padding=0,
                        fontsize=37
                        ),
               widget.TextBox(
                        text=" 🔊",
                        foreground=colors[2],
                        background=colors[4],
                        padding = 0,
                        fontsize=14
                        ),
               widget.Volume(
                        foreground = colors[2],
                        background = colors[4],
                        padding = 5
                        ),
               widget.TextBox(
                        text='',
                        background = colors[4],
                        foreground = colors[5],
                        padding=0,
                        fontsize=37
                        ),
               widget.TextBox(
                        font="Ubuntu Bold",
                        text=" ☵",
                        padding = 5,
                        foreground=colors[2],
                        background=colors[5],
                        fontsize=14
                        ),
               widget.CurrentLayout(
                        foreground = colors[2],
                        background = colors[5],
                        padding = 5
                        ),
               widget.TextBox(
                        text='',
                        background = colors[5],
                        foreground = colors[4],
                        padding=0,
                        fontsize=37
                        ),
               widget.TextBox(
                        font="Ubuntu Bold",
                        text=" 🕒",
                        foreground=colors[2],
                        background=colors[4],
                        padding = 5,
                        fontsize=14
                        ),
               widget.Clock(
                        foreground = colors[2],
                        background = colors[4],
                        format="%A, %B %d - %H:%M"
                        ),
               widget.Sep(
                        linewidth = 0,
                        padding = 5,
                        foreground = colors[0],
                        background = colors[4]
                        ),
               widget.Systray(
                        background=colors[0],
                        padding = 5
                        ),
              ]
    return widgets_list

##### SCREENS ##### (TRIPLE MONITOR SETUP)

def init_widgets_screen1():
    widgets_screen1 = init_widgets_list()
    return widgets_screen1                       # Slicing removes unwanted widgets on Monitors 1,3

def init_widgets_screen2():
    widgets_screen2 = init_widgets_list()
    return widgets_screen2                       # Monitor 2 will display all widgets in widgets_list

def init_screens():
    return [Screen(top=bar.Bar(widgets=init_widgets_screen1(), opacity=0.95, size=20)),
            Screen(top=bar.Bar(widgets=init_widgets_screen2(), opacity=0.95, size=20)),
            Screen(top=bar.Bar(widgets=init_widgets_screen1(), opacity=0.95, size=20))]

if __name__ in ["config", "__main__"]:
    screens = init_screens()
    widgets_list = init_widgets_list()
    widgets_screen1 = init_widgets_screen1()
    widgets_screen2 = init_widgets_screen2()

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




#========================================================================
# ----------- SCRIPT DE CONTROL DE CONFIGURACION
# =======================================================================
import sys
import subprocess
import importlib

from libqtile.confreader import Config, ConfigError
from libqtile.command import lazy
from libqtile.xkeysyms import keysyms
# from libqtile.core.xcore import XCore
from libqtile.backend.x11 import xcore

# python package 'regex' is required
# will fail gracefully if it is not importable, see validate_config
def find_similar_keys(key):
    import regex

    regexp = regex.compile(
        r"({}{{e<{}}})".format(key, len(key)), regex.IGNORECASE
    )
    similar_keys = []
    for qtile_key in keysyms.keys():
        if regexp.match(qtile_key):
            similar_keys.append(qtile_key)
    if not similar_keys:
        return "No key similar to '{}' could be found in libqtile.xkeysyms.keysyms :/".format(
            key
        )
    if len(similar_keys) == 1:
        return "Maybe you meant '{}'?".format(similar_keys[0])
    return "Maybe you meant '{}', or '{}'?".format(
        "', '".join(similar_keys[:-1]), similar_keys[-1]
    )


def validate_config():
    output = [
        "The configuration file '",
        __file__,
        "' generated the following error:\n\n",
    ]


    try:
        # mandatory: we must reload the module (the config file was modified)
        importlib.reload(sys.modules[__name__])
        Config.from_file(XCore(), __file__)

    except ConfigError as error:
        output.append(str(error))

        # handle the case when a key is erroneous
        # more cases could be handled maybe
        if str(error).startswith("No such key"):
            output.append("\n\n")
            key = str(error).replace("No such key: ", "")
            try:
                similar_keys = find_similar_keys(key)
            except ImportError:
                output.append("Install 'regex' if you want to see valid similar keys")
            else:
                output.append(similar_keys)
        raise ConfigError("".join(output))

    except Exception as error:
        # here we handle SyntaxError and the likes
        print("ERROR DE SINTAXIS")
        output.append("{}: {}".format(sys.exc_info()[0].__name__, str(error)))
        raise ConfigError("".join(output))

@lazy.function
def validate_and_restart(qtile):
    try:
        validate_config()
    except ConfigError as error:
        # adapt to fit your needs: here I pop a system notification with the error
        subprocess.call(["notify-send", "-t", "10000", str(error)])
    else:
        qtile.cmd_restart()

#---------------------------------------------------------
#   recuerda cambiar la tecla en los keybindings arriba
#--------------------------------------------------------
# keys = [
# ...
    # Key(["mod4", "control"], "r", validate_and_restart),
    # ...
# ]
# keys.append(Key([mod, "mod1"], "r", validate_and_restart)) # lo quito porque hago la validación abajo)
# print(__name__)

if __name__ == "__main__":
    try:
        validate_config()
    except ConfigError as error:
        print(str(error), file=sys.stderr)
        sys.exit(1)
    else:
        print("OK!")
        sys.exit(0)
