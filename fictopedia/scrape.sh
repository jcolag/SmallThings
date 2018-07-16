#!/bin/sh
addcount=0
skipcount=0
for ref in $(cat * | sed 's/\[\[/\n[[/g;s/\]\]/]]\n/g;s/\[\[ /[[/g' | grep "^\[\[" | grep -v "Category:" | grep -v "wikipedia:" | grep -v "User:" | grep -v "http://" | grep -v "#" | sed 's/\[\[\(.*\)\]\]/\1/g' | sort -iu | cut -f1 -d'|' | tr ' ' '_')
do
  name=$(echo $ref | sed 's/\//%2F/g')
  if [ -f "${name}.txt" ]
  then
    echo ${ref} exists!
    skipcount=$(($skipcount + 1))
  else
    srcurl="http://fictopedia.net/w/index.php?title=${ref}&action=edit"
    src=$(curl -s "${srcurl}")
    firstline=$(echo "${src}" | grep -n "<textarea" | cut -f1 -d':')
    lastline=$(echo "${src}" | grep -n "</textarea>" | cut -f1 -d':')
    textarea=$(echo "${src}" | head --lines=${lastline} | tail --lines=+${firstline} | sed 's/<\/textarea>.*//g')
    echo "$textarea" | cut -f2 -d'>' > "${name}.txt"
    echo "${name}: ${firstline} to ${lastline}."
    addcount=$(($addcount + 1))
  fi
done
echo "${skipcount} files already here and ${addcount} files added!"

