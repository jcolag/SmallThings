#!/bin/sh
lang=$1
col=3
vowels='aäæɐɑɒeəɛɘɜɞɤiɪɨoøø̞o̞œɶɔɵuʉɯʊʌyʏ'
rev "$lang.csv" | sort -t',' -k$col,$col | rev > "$lang.rhyme.csv"
for i in $(cat "$lang.rhyme.csv" | tr ' ' '_')
do
  syl=$(echo $i | cut -f2 -d'/' | tr -cd '$vowels' | wc -m)
  echo "$i,$syl"
done | tr '_' ' ' > "$lang.rhyme2.csv"
mv "$lang.rhyme2.csv" "$lang.rhyme.csv"

