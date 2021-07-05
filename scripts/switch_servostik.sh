#!/usr/bin/bash

# pinHP Arcade image

#
# This script reads a joystick parameter from _games.template and switches an Ultimarc ServoStik accordingly.
# Rename it 'runscript-mame-before.sh' and place it in '/root/scripts/custom' to run it with each game start.
#
# Additional software required: 'SetServoStik', to be placed in '/usr/local/bin'
# http://users.telenet.be/rgbcommander/downloads/SetServoStik.tar.gz
#

#
# Example _games.template lines:
# game { rom ="1942" title ="1942 (set 1)" params ="-0ONE-0TWO-0TRE-1ALL-0FAV" orientation ="v" joy ="8" }
# game { rom ="pacman" title ="Pac-Man (Midway)" params ="-0ONE-0TWO-0TRE-1ALL-0FAV" orientation ="v" joy ="4" }
#

# Complete passed gameline from _games.template, enabling to awk custom added parameters 
GAMELINE=$5

# Read "joy" parameter
JOY=$( echo "$GAMELINE" | awk -F'joy ?= ?"' '{print $2}' | awk -F'"' '{print $1}' )

# Make sure a file which stores the last switched state exists 
STATE="/tmp/servostik_state"
touch $STATE

# 8-way
if [ "$JOY" = "8" ]; then
  # Only switch if ServoStik is not 8-way already
  if ! grep -q "8way -> OK" "$STATE"; then
    SetServoStik 8 > "$STATE"
  fi
# 4-way (default)
else
  # Only switch if ServoStik is not 4-way already
  if ! grep -q "4way -> OK" "$STATE"; then
    SetServoStik 4 > "$STATE"
  fi
fi
