#!/bin/bash

ADVMHOME=$1
hardwaremode_current=$2
UPDATED="N"

advmame_rc_pi2jamma=$(grep "advmame_rc_pi2jamma" "/tmp/patch_server.txt" | awk -F 'advmame_rc_pi2jamma=' '{print $2}' )
advmame_rc_pi2scart=$(grep "advmame_rc_pi2scart" "/tmp/patch_server.txt" | awk -F 'advmame_rc_pi2scart=' '{print $2}' )
case $hardwaremode_current in
  Jamma )
    official_advmame_file="$advmame_rc_pi2jamma"
  ;;
  SCART )
    official_advmame_file="$advmame_rc_pi2scart"
  ;;
esac

# Download advmame.rc file
if ! [ -e /tmp/official_advmame.rc ]; then
  curl --connect-timeout $connection_timeout -k -L -o /tmp/official_advmame.rc "$official_advmame_file"
  response=$?
  if [ "$response" = "28" ] || [ ! -e "/tmp/official_advmame.rc" ]; then
    if [ "$response" = "28" ]; then
      dialog --timeout 15 --begin 10 7 --title "pinHP Arcade Classics" --msgbox "\n*** TIMEOUT ERROR ***\n\nCheck connection" 9 26
    else
      dialog --timeout 15 --begin 10 9 --title "pinHP Arcade Classics" --msgbox "\n*** ERROR ***\n\nFile not found" 9 22
    fi
  fi
fi

# File exists already or has been just downloaded
if [ -e /tmp/official_advmame.rc ]; then

  rm /tmp/timings_current_names &> /dev/null
  rm /tmp/timings_official &> /dev/null
  rm /tmp/timings_missing &> /dev/null
  touch /tmp/timings_current_names
  touch /tmp/timings_official
  touch /tmp/timings_missing
  cat $ADVMHOME/advmame.rc | grep device_video_modeline | awk -F"\"" '{print $2}' > /tmp/timings_current_names
  cat /tmp/official_advmame.rc | grep -v "^#" | grep device_video_modeline > /tmp/timings_official
  
  awk -v INPUTFILE="/tmp/timings_official" -v COMPAREFILE="/tmp/timings_current_names" -v OUTFILE="/tmp/timings_missing" -f "/root/scripts/missing_timings.awk"
  
  if grep -q "device_video_modeline" /tmp/timings_missing; then
  
    # Write missing timings into array
    cat /tmp/timings_missing | awk -F"\"" '{print $2}' > /tmp/timings_missing_names
    declare -a dialog_array
    i=1 # Array index
    j=1 # Visible menu item number to be displayed in menu list
    while read line
    do     
      dialog_array[ $i ]=$j
      (( j++ ))
      dialog_array[ ($i + 1) ]=$line
      (( i=($i+2) ))
    done < /tmp/timings_missing_names
  
    dummy=`dialog --timeout 30 --title "pinHP Arcade Classics" --menu "\nNew video modes" 0 0 0 "${dialog_array[@]}" 3>&1 1>&2 2>&3`
    if [ ! -z $dummy ]; then
      count_missing=$( cat /tmp/timings_missing | wc -l )
      dialog --timeout 15 --title "pinHP Arcade Classics" --defaultno --yesno "\nAdd $count_missing new modelines\nto current advmame.rc\nconfiguration file?\n\n" 0 0
      response=$?
      if [ "$response" = "0" ]; then
        rm /tmp/timings_insert_code &> /dev/null
        touch /tmp/timings_insert_code
        echo -e "\n# Added by online update" > /tmp/timings_insert_code
        cat /tmp/timings_missing >> /tmp/timings_insert_code
        echo "#" >> /tmp/timings_insert_code
        sed -i -e '/device_video_clock/r /tmp/timings_insert_code' $ADVMHOME/advmame.rc
  
        # Check if all lines were addded
        copycount=0
        while read line
        do
          if grep -q "$Line" "$ADVMHOME/advmame.rc"; then
            ((copycount++))
          fi
        done < /tmp/timings_missing
  
        if [ $count_missing -eq $copycount ]; then
          dialog --timeout 15 --begin 10 7 --title "pinHP Arcade Classics" --msgbox "\nSuccess!\n\n$copycount lines added" 9 26
          UPDATED="Y"
        else
          dialog --timeout 15 --begin 10 7 --title "pinHP Arcade Classics" --msgbox "\n*** ERROR ***\n\n$copycount/$count_missing lines added" 9 26
        fi
  
      fi
    fi
  fi
  
  # Save state input map
  missing_code=""
  missing_info=""
  rm /tmp/missing_code &> /dev/null
  
  if ! grep -q "input_map\[ui_save_state\]" $ADVMHOME/advmame.rc; then
    missing_info="input_map[ui_save_state]"
    grep "input_map\[ui_save_state\]" /tmp/official_advmame.rc >> /tmp/missing_code
  fi
  if ! grep -q "input_map\[ui_load_state\]" $ADVMHOME/advmame.rc; then
    missing_info="${missing_info}\ninput_map[ui_load_state]"
    grep "input_map\[ui_load_state\]" /tmp/official_advmame.rc >> /tmp/missing_code
  fi
  
  if [ ! -z "$missing_info" ]; then
    dialog --timeout 15 --title "pinHP Arcade Classics" --defaultno --yesno "\nAdd game save state keys?\n\n$missing_info\n\n" 0 0
    response=$?
    if [ "$response" = "0" ]; then
      rm /tmp/insert_code &> /dev/null
      touch /tmp/insert_code
      echo -e "\n# Added by online update" > /tmp/insert_code
      cat /tmp/missing_code >> /tmp/insert_code
      echo "#" >> /tmp/insert_code
      if grep -q "^# mameconfig=." $ADVMHOME/advmame.rc; then
        sed -i -e '/^# mameconfig=./r /tmp/insert_code' $ADVMHOME/advmame.rc
      else
        sed -i -e '/DO NOT EDIT THIS LINE/r /tmp/insert_code' $ADVMHOME/advmame.rc
      fi            
    UPDATED="Y"
    fi
  fi
  
  # Mouse/spinner support
  missing_code=""
  missing_info=""
  rm /tmp/missing_code &> /dev/null
  
  if ! grep -q "device.*mouse" $ADVMHOME/advmame.rc && ! grep -q "input_map.*mouse" $ADVMHOME/advmame.rc; then
    dialog --timeout 15 --title "pinHP Arcade Classics" --defaultno --yesno "\nAdd mouse/spinner support?\n\n" 0 0
    response=$?
    if [ "$response" = "0" ]; then
      rm /tmp/insert_code &> /dev/null
      touch /tmp/insert_code
      grep "device.*mouse" /tmp/official_advmame.rc >> /tmp/missing_code
      grep "input_map.*mouse" /tmp/official_advmame.rc >> /tmp/missing_code
      echo -e "\n# Added by online update" > /tmp/insert_code
      cat /tmp/missing_code >> /tmp/insert_code
      echo "#" >> /tmp/insert_code
      if grep -q "^# mameconfig=." $ADVMHOME/advmame.rc; then
        sed -i -e '/^# mameconfig=./r /tmp/insert_code' $ADVMHOME/advmame.rc
      else
        sed -i -e '/DO NOT EDIT THIS LINE/r /tmp/insert_code' $ADVMHOME/advmame.rc
      fi            
    UPDATED="Y"
    fi
  fi

fi

if [ "$UPDATED" = "Y" ]; then
  dialog --timeout 15 --title "pinHP Arcade Classics" --msgbox "\nSystem files\n\nUpdate finished\n\n" 0 0
else
  dialog --timeout 15 --title "pinHP Arcade Classics" --msgbox "\nSystem files\n\n*** up to date ***\n\n" 0 0
fi

