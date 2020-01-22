#!/bin/bash
cont=true
stty -icanon time 0 min 0 -echo
while $cont
do
  sleep 1
  read input
  if [ ."$input". = ".t." ]
  then
    spd-say -i -75 "$(date +%I:%M)"
  elif [ ."$input". = ".a." ]
  then
    stty -icanon time 100 
    echo -n "Write: "
    read line
    echo -n "$(date +%I:%M) - "
    echo $line
    stty -icanon time 0 min 0
  elif [ ."$input". = ".q." ]
  then
    cont=false
  fi
done
stty sane

