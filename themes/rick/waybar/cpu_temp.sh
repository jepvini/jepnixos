# !/usr/bin/env bash

TEMP_FILE=/sys/class/hwmon/hwmon4/temp1_input
TEMP=$(cat "$TEMP_FILE")
TEMP_FORMATTED=$(bc <<< "scale = 0;($TEMP / 1000)")"°C";


echo "$TEMP_FORMATTED"
