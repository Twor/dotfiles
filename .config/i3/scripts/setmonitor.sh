#!/bin/sh
xrandrcmd="--output eDP1 --primary --mode 1920x1080 --pos 0x0 --rotate normal"

devname=$(xrandr |grep -e "HDMI"| grep -e " connected" |awk '{print$1}')

for m in ${devname}
do
    xrandrcmd="${xrandrcmd} --output ${m} --mode 1920x1080 --pos 0x0 --rotate normal"
done

devname=$(xrandr |grep "disconnected" |awk '{print$1}')

unset m

for m in ${devname}
do
    xrandrcmd="${xrandrcmd} --output ${m} --off"
done

unset m
#echo ${xrandrcmd}
xrandr ${xrandrcmd}

unset xrandrcmd
