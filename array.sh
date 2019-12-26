#!/bin/bash
printArray() {
  declare -a messages=("${!1}")
  for idx in $(seq 0 ${#messages[@]})
  do
    echo "${messages[$idx]}"
  done
}

msgs=()
for i in $(seq 15)
do
  now=$(date +%s)
  msgs+=("$now - $i")
done
printArray msgs[@]

