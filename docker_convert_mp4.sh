#!/bin/bash

# 1280x720
#  960x540
#  842x632

docker_dir='/config'

ffprobe_cmd="docker run --rm -it --entrypoint /usr/local/bin/ffprobe -v $(pwd):/config linuxserver/ffmpeg:6.1.1 -v error -hide_banner -select_streams v:0 -show_entries stream=codec_name,duration,width,height -show_entries stream_tags=title,duration -of csv"
#ffmpeg_cmd='ffmpeg -hide_banner'
ffmpeg_cmd="docker run --rm -it -e PUID=$(id -u) -e PGID=$(id -g) -v $(pwd):/config linuxserver/ffmpeg:6.1.1 -hide_banner"
opt1='-vf scale=960:-1'
#opt2='-c:a copy -c:v libx265'
#opt2='-threads 4 -c:a copy -c:v libx265 -preset medium'
opt2='-threads 4 -c:a copy -c:v libx265 -preset veryfast'
#opt2='-threads 4 -c:a copy -c:v libx265 -preset fast'

for f in "$@"; do
	ffprobe_result=`$ffprobe_cmd -i "${docker_dir}/$f"`
	codec=`echo $ffprobe_result | cut -d ',' -f 2`
	width=`echo $ffprobe_result | cut -d ',' -f 3`
	height=`echo $ffprobe_result | cut -d ',' -f 4`
	if [ x"$codec" = "xh264" ]; then
		echo 'Need to convert'
		ORG_ARG=$(basename "$f" .mp4)
		TT=$(echo ${ORG_ARG}|sed 's/ - JAV Online HPJAV//')
		SYM=$(echo ${TT} | sed -e "s/\(^[^ ]*\).*/\1/")
		#echo -n "C: "; echo ${TT} | sed -e "s/\(^[^ ]*\)\(.*\)/\2/" | sed "s/['. ()!,]//g"
		#TITLE=$(echo ${TT} | sed -e "s/\(^[^ ]*\)\(.*\)/\2/" | sed "s/['. ()!,]//g")
		TITLE=$(echo ${TT} | sed -e "s/\(^[^ ]*\)\(.*\)/\2/" | sed "s/[^a-zA-Z0-9_-]//g")
		# [ -e "$f" ] && mv "$f" "${SYM}_${TITLE}.mp4"
		ls -l1 "$f"
		echo ${SYM}_${TITLE}
		if [ $width -gt 960 ]; then
			[ -e "$f" ] && echo $ffmpeg_cmd -i "${docker_dir}/$f" $opt1 $opt2 "${docker_dir}/${SYM}_${TITLE}.mp4"
			[ -e "$f" ] && $ffmpeg_cmd -i "${docker_dir}/$f" $opt1 $opt2 "${docker_dir}/${SYM}_${TITLE}.mp4"
		else
			[ -e "$f" ] && echo $ffmpeg_cmd -i "${docker_dir}/$f" $opt2 "${docker_dir}/${SYM}_${TITLE}.mp4"
			[ -e "$f" ] && $ffmpeg_cmd -i "${docker_dir}/$f" $opt2 "${docker_dir}/${SYM}_${TITLE}.mp4"
		fi
	fi
	echo $f,$ffprobe_result
done
$HOME/bin/notify-discord.sh -m "convert finish :: $(date +'%Y-%m-%d %H:%M:%S')"
