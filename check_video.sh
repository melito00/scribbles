#!/bin/sh

ffprobe_cmd='ffprobe -v error -hide_banner -select_streams v:0 -show_entries stream=codec_name,duration,width,height -show_entries stream_tags=title,duration -of csv'

for f in "$@"; do
	ffprobe_result=`$ffprobe_cmd -i "$f"`
	codec=`echo $ffprobe_result | cut -d ',' -f 2`
	height=`echo $ffprobe_result | cut -d ',' -f 4`
	if [ x"$codec" = "xh264" ]; then
		if [ $height -gt 540 ]; then
			echo -n 'Need to convert: '
			ls --block-size=M -l1 "$f"
		fi
	fi
	#echo $f,$ffprobe_result
	#echo
done
