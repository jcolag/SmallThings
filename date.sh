#!/bin/sh

# Splitting up the date inputs for debugging
now=$(date +%s $now)
target=$(date +%s -d $1)
days=$(($target - $now));
if [ $days -lt 0 ]
then
  echo error
  exit 1
else
  days=$(($days / 86400))
  echo "There are $days days left to this date.";
fi

