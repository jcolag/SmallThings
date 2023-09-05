#!/bin/bash
touch a.txt b.txt
date -r a.txt +%y-%m-%d > b.txt
A="$(cat b.txt)"
B="$(date -r a.txt +%y-%m-%d)"
if [[ "$A" == "$B" ]]
then
  echo "equal"
else
  echo "not equal"
fi
