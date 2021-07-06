#!/usr/bin/bash

# pinHP Arcade image
# 06JUL21

#
# This script toggles an Ultimarc ServoStik.
#

#
# Additional software required: 'SetServoStik', to be placed in '/usr/local/bin'
# http://users.telenet.be/rgbcommander/downloads/SetServoStik.tar.gz
#

# Make sure a file which stores the last switched state exists 
STATE="/tmp/servostik_state"
touch $STATE

# 8-way
if grep -q "4way -> OK" "$STATE"; then
  SetServoStik 8 > "$STATE"
# 4-way (default)
else
  SetServoStik 4 > "$STATE"
fi

# Display result
if grep -q "4way -> OK" "$STATE"; then
  dialog --title "ServoStik    " --infobox "\nCurrent state:\n\n4-way\n\n" 0 0
elif grep -q "8way -> OK" "$STATE"; then
  dialog --title "ServoStik    " --infobox "\nCurrent state:\n\n8-way\n\n" 0 0
else
  servostik_error=$( cat "$STATE" )
  dialog --title "ServoStik    " --infobox "\n\n$servostik_error\n\n" 0 0
  sleep 2
fi

sleep 2
clear