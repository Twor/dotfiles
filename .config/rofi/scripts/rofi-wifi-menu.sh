#!/usr/bin/env bash

## This script is based on Zach Baylin's Rofi WiFi Menu.
## https://github.com/zbaylin/rofi-wifi-menu
## I have modified it to utilize iwd instead of NetworkManager.
## @author Tim Clancy
## @date 8.18.2020

## Configuration defaults.
DEVICE=${1:-wlan0}
POSITION=${2:-0}
Y_OFF=${3:-0}
X_OFF=${4:-0}
FONT="DejaVu Sans Mono 12"

## Scan for available and broadcasting SSIDs.
iwctl station $DEVICE scan

## Get the networks that are available to the WiFi adapter and format them.
## Make sure the current network is always at the top of the list.
CURR_SSID=$(iwctl station $DEVICE show | sed -n 's/^\s*Connected\snetwork\s*\(\S*\)\s*$/\1/p')
IW_NETWORKS+=$(iwctl station $DEVICE get-networks | sed '/^--/d')
IW_NETWORKS=$(echo "$IW_NETWORKS" | sed 1,4d)
IW_NETWORKS=$(echo "$IW_NETWORKS" | sed -r "s/\x1B\[([0-9]{1,3}(;[0-9]{1,2})?)?[mGK]//g")
IFS=$'\n'
PREFIX=$'SSID                              SECURITY  \n'
NETWORK_LIST=""
while IFS= read -r line; do
	line=${line:4}
	SSID_NAME=$(echo "$line" | sed 's/\(\s*psk.*\)//')
	printf -v pad %34s
	line=$SSID_NAME$pad
	line=${line:0:34}
	line+=$'PSK'
	printf -v pad %45s
	line=$line$pad
	line=${line:0:45}
	line+=$'\n'
	if [ "$SSID_NAME" = "$CURR_SSID" ]; then
		PREFIX+=$line
	else
		NETWORK_LIST+=$line
	fi
done <<< "$IW_NETWORKS"
IW_NETWORKS=$(echo "$PREFIX$NETWORK_LIST" | sed '$d')

## Get the currently-active WiFi connection if one exists and highlight it.
if [[ ! -z $CURR_SSID ]]; then
	HIGHLINE=$(echo "$(echo "$IW_NETWORKS" | awk -F "[  ]{2,}" '{print $1}' | grep -Fxn -m 1 "$CURR_SSID" | awk -F ":" '{print $1}') + 1" | bc)
fi

## Determine whether or not there exists a WiFi connection for display purposes.
CON_STATE=$(iwctl station $DEVICE show)
if [[ "$CON_STATE" =~ " connected" ]]; then
	MENU="disconnect from ${CURR_SSID}\nmanually connect to a network\n$IW_NETWORKS"
elif [[ "$CON_STATE" =~ "disconnected" ]]; then
	MENU="manually connect to a network\n$IW_NETWORKS"
fi

## Dynamically change the size of the Rofi menu, with a cap on network count.
## Rofi seems to require some text padding dependent on our font size.
R_WIDTH=$(($(echo "$IW_NETWORKS" | head -n 1 | awk '{print length($0); }')+5))
LINE_COUNT=$(echo "$IW_NETWORKS" | wc -l)
if [[ "$CON_STATE" =~ " connected" ]]; then
	LINE_COUNT=12
elif [ "$LINE_COUNT" -gt 8 ] || [[ "$CON_STATE" =~ "disconnected" ]]; then
	LINE_COUNT=12
fi

## Grab the user's chosen SSID entry.
CHENTRY=$(echo -e "$MENU" | uniq -u | rofi -dmenu -p "" -lines "$LINE_COUNT" -a "$HIGHLINE" -location "$POSITION" -yoffset "$Y_OFF" -xoffset "$X_OFF" -font "$FONT" -width -"$R_WIDTH")
CHSSID=$(echo "$CHENTRY" | sed  's/\s\{2,\}/\|/g' | awk -F "|" '{print $1}')

## Support manual SSID entry.
if [ "$CHENTRY" = "manually connect to a network" ] ; then
	MSSID=$(echo "Enter your network's SSID." | rofi -dmenu -p "SSID: " -font "$FONT" -lines 1)
	WIFI_PASS=$(echo "Enter the network password." | rofi -dmenu -password -p "Password: " -lines 1 -location "$POSITION" -yoffset "$Y_OFF" -xoffset "$X_OFF" -font "$FONT" -width -"$R_WIDTH")
	iwctl station $DEVICE disconnect
	iwctl --passphrase $WIFI_PASS station $DEVICE connect $MSSID

## Support WiFi toggling.
elif [[ "$CHENTRY" =~ "disconnect from " ]]; then
	iwctl station $DEVICE disconnect

## Support connecting to the chosen network.
elif [ "$CHSSID" != "" ]; then
	WIFI_PASS=$(echo "Enter the network password." | rofi -dmenu -password -p "Password: " -lines 1 -location "$POSITION" -yoffset "$Y_OFF" -xoffset "$X_OFF" -font "$FONT" -width -"$R_WIDTH")
	iwctl station $DEVICE disconnect
	iwctl --passphrase $WIFI_PASS station $DEVICE connect $CHSSID
fi