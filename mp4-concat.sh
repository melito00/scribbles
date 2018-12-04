#!/usr/bin/env zsh

OIFS="$IFS"
IFS=$'\n'

lastfile=""
cp /dev/null input-base.txt
for f in $*; do
  newfile=$(echo "$f" | sort -n | sed -e 's/[^a-zA-Z0-9\.]//g')
  echo $f $newfile
  mv $f $newfile
  echo file \'$newfile\' >> input-base.txt
  lastfile=$newfile
done

lastfile=`basename ${lastfile} .mp4`
mv ${lastfile}.mp4 "${lastfile}0.mp4"
echo file \'${lastfile}0.mp4\'> input.txt
sed '$d' input-base.txt >> input.txt

IFS="$OIFS"

ffmpeg -f concat -i input.txt -c copy ${lastfile}.mp4
