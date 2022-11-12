#!/bin/bash
scrot /tmp/screen.png
ICON="~/.config/i3/imgs/1.png"
TMPBG=/tmp/screen.png
convert $TMPBG -blur 0x5 $TMPBG
convert $TMPBG $ICON -gravity center -composite -matte $TMPBG
i3lock -u -i $TMPBG
rm /tmp/screen.png