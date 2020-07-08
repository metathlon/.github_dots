import os
import socket
from libqtile import widget
from caronte_config import *




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
               widget.AGroupBox(font="Ubuntu Bold",
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
                        background = colors[0],
                        hide_unused = True
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
                        execute = MY_TERM,
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
               # widget.TextBox(
               #          text='',
               #          background = colors[5],
               #          foreground = colors[4],
               #          padding=0,
               #          fontsize=37
               #          ),
               # widget.TextBox(
               #          text=" ↯",
               #          foreground=colors[2],
               #          background=colors[4],
               #          padding = 0,
               #          fontsize=14
               #          ),
               # widget.Net(
               #          interface = MY_ETHERNET,
               #          foreground = colors[2],
               #          background = colors[4],
               #          padding = 5
               #          ),
               # widget.TextBox(
               #          text='',
               #          background = colors[4],
               #          foreground = colors[5],
               #          padding=0,
               #          fontsize=37
               #          ),
               # widget.TextBox(
               #          font="Ubuntu Bold",
               #          text=" ♫",
               #          padding = 5,
               #          foreground=colors[2],
               #          background=colors[5],
               #          fontsize=14
               #          ),
               # widget.Cmus(
               #          max_chars = 40,
               #          update_interval = 0.5,
               #          background=colors[5],
               #          play_color = colors[2],
               #          noplay_color = colors[2]
               #          ),
               widget.TextBox(
                        text='',
                        background = colors[5],
                        foreground = colors[4],
                        padding=0,
                        fontsize=37
                        ),
               widget.TextBox(
                        font="Iosevka",
                        text=" ",
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
               # widget.TextBox(
               #          text='',
               #          background = colors[4],
               #          foreground = colors[5],
               #          padding=0,
               #          fontsize=37
               #          ),
               # widget.TextBox(
               #          font="Ubuntu Bold",
               #          text=" ☵",
               #          padding = 5,
               #          foreground=colors[2],
               #          background=colors[5],
               #          fontsize=14
               #          ),
               # widget.CurrentLayout(
               #          foreground = colors[2],
               #          background = colors[5],
               #          padding = 5
               #          ),
               widget.TextBox(
                        text='',
                        background = colors[5],
                        foreground = colors[4],
                        padding=0,
                        fontsize=37
                        ),
               widget.TextBox(
                        font="Iosevka",
                        text=" ",
                        foreground=colors[2],
                        background=colors[4],
                        padding = 5,
                        fontsize=14
                        ),
               widget.Clock(
                        foreground = colors[2],
                        background = colors[4],
                        # format="%A, %B %d - %H:%M"
                        format="%d-%m-%Y - %H:%M"
                        ),
               widget.Sep(
                        linewidth = 0,
                        padding = 5,
                        foreground = colors[0],
                        background = colors[4]
                        ),
               widget.Systray(
                        background=colors[0],
                        icon_size = 20,
                        padding = 5
                        ),
              ]
    return widgets_list
