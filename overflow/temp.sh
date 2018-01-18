#!/bin/sh
for f in `tr -cd '\011\012\040-\176' < temp.csv`
do
#  ff=$(echo "$f" | tr -cd '\11\12\15\40-\176')
#  echo 0 $ff
  echo 0 $(echo $f | od -x)
  echo 1 fastq/${f}_1.fastq.gze
#  echo 2 fastq/${ff}_1.fastq.gze
done

