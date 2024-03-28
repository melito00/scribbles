#!/bin/sh

# Usage: ./rename-video.sh YYYYMMDD *.mp4
#
echo $1
base=$1; shift

counter=1
for f in "$@"; do
  newname=${base}_$(printf "%02d" $counter).mp4
  echo mv $f $newname
  # mv $f $newname
  counter=`expr $counter + 1`
done
