# !/bin/bash
# sudo adb kill-all
# sudo adb start-server

sudo smmod v4l2looopback_dc
sudo insmod /lib/modules/`uname -r`/kernel/drivers/media/video/v4l2loopback-dc.ko width=1920 height=1080
droidcam &
