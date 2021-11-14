#!/bin/sh
# This script takes the list of boot times and calculates the number
# of days between reboots.
last -F reboot | grep "^reboot" | cut -c40-63 | while read dd
do
  ts=$(date -d"${dd}" +%s)
  if [ .$last. != .. ]
  then
    diff=$((last - ts))
    days=$(echo "$diff / 86400" | bc -l)
    printf "%.0f\n" "$days"
  fi
  last="$ts"
done

