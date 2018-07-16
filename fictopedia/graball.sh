#!bin/bash
for url in $(cat "$1")
do
  name=$(echo "${url}" | rev | cut -f1 -d'/' | rev)
  srcurl=$(curl -s "${url}" | grep "ca-viewsource" | sed 's/.*<a href="\([^"]*\)".*/http:\/\/fictopedia.net\1/g;s/amp;//g')
  src=$(curl -s "${srcurl}")
  firstline=$(echo "${src}" | grep -n "<textarea" | cut -f1 -d':')
  lastline=$(echo "${src}" | grep -n "</textarea>" | cut -f1 -d':')
  textarea=$(echo "${src}" | head --lines=${lastline} | tail --lines=+${firstline} | sed 's/<\/textarea>.*//g')
  echo "$textarea" | cut -f2 -d'>' > "files/$name.txt"
  echo "${name}"
done

