#!/bin/bash
convert "$1" +dither -colors 4 txt: | grep -v '^#' | sed 's/.*\(#[0-9A-F][0-9A-F]*\).*/\1/g' | sort | uniq -c | sort -n | tr 'a-f' 'A-F' | while IFS= read -r line
do
  l=$(echo -e "$line" | tr -s '[:space:]' ' ')
  color=$(echo $l | cut -f3 -d' ')
  count=$(echo $l | cut -f2 -d' ')
  rr=$(echo "$color" | cut -c2-3)
  gg=$(echo "$color" | cut -c4-5)
  bb=$(echo "$color" | cut -c6-7)
  r=$(echo "ibase=16; $rr" | bc)
  g=$(echo "ibase=16; $gg" | bc)
  b=$(echo "ibase=16; $bb" | bc)
  rG=$(($r / 3294))
  gG=$(($g / 3294))
  bG=$(($b / 3294))
  if [ $r > 10 ]
  then
    rG=$(echo "e(2.4 * l($r / 269 + 0.0513))" | bc -l)
  fi
  if [ $g > 10 ]
  then
    gG=$(echo "e(2.4 * l($g / 269 + 0.0513))" | bc -l)
  fi
  if [ $b > 10 ]
  then
    bG=$(echo "e(2.4 * l($b / 269 + 0.0513))" | bc -l)
  fi
  lum=$(echo "0.2126 * $rG + 0.7152 * $gG + 0.0722 * $bG" | bc -l)
  echo "$lum ($color x $count)"
done

