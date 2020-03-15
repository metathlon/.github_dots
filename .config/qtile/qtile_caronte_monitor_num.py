
#========================================================================
# ----------- MULTI-MONITOR SETUP
# =======================================================================
# - identificación de los monitores, base de: https://github.com/qtile/qtile/wiki/screens
# - la he modificado MUCHO

# this import requires python-xlib to be installed
from Xlib import display as xdisplay
import logging

def get_monitors():
    monitors = []

    try:
        display = xdisplay.Display()
        screen = display.screen()
        resources = screen.root.xrandr_get_screen_resources()
        num = 0
        print("Looking for monitors:")
        for output in resources.outputs:
            added = False
            monitor = display.xrandr_get_output_info(output, resources.config_timestamp)
            if hasattr(monitor, "preferred"):
                added = monitor.preferred
            elif hasattr(monitor, "num_preferred"):
                added = monitor.num_preferred
            if added == True:
                monitors.append(monitor)
                print("MONITOR ",num," - ", monitor.name)
                # print("MONITOR RAW - ", monitor)
                num += 1
    except Exception as e:
        # always setup at least one monitor
        print("ERROR EN get_monitors:", e)
        logging.warning("EXCEPTION RISED: in get_monitors: ", e)
    else:
        return monitors


def get_num_monitors(monitor_list):
    num_monitors = 0
    if 'monitor_list' not in locals():
        print("ERROR: No monitor list passed to get_num_monitors()")
        return 0

    #always set 1 monitor
    if len(monitor_list) == 0:
        print("WARNING: get_num_monitors: monitor_list empty --> returing 1 montor as minimum")
        return 1

    for monitor in monitor_list:
        preferred = False
        if hasattr(monitor, "preferred"):
            preferred = monitor.preferred
        elif hasattr(monitor, "num_preferred"):
            preferred = monitor.num_preferred
        if preferred:
            num_monitors += 1
    return num_monitors




# En la fase de comprobación de la configuración puedo querer testar esto
if __name__ == "__main__":
    print("NUM MONITORS:", num_monitors)
