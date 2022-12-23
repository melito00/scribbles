#!/bin/bash

ORG_ARG=$(basename "$1" .mp4)
TT=$(echo ${ORG_ARG}|sed 's/ - JAV Online HPJAV//')
#echo ${TT}
#echo "A: ${ORG_ARG}"
#echo -n "B: "; echo ${TT} | sed -e "s/\(^[^ ]*\).*/\1/"
SYM=$(echo ${TT} | sed -e "s/\(^[^ ]*\).*/\1/")
echo -n "C: "; echo ${TT} | sed -e "s/\(^[^ ]*\)\(.*\)/\2/" | sed "s/['. ()!,]//g"
#TITLE=$(echo ${TT} | sed -e "s/\(^[^ ]*\)\(.*\)/\2/" | sed "s/['. ()!,]//g")
TITLE=$(echo ${TT} | sed -e "s/\(^[^ ]*\)\(.*\)/\2/" | sed "s/[^a-zA-Z0-9_]//g")
#echo $1
#echo "B: ${SYM}_${TITLE}.mp4"
#echo $1 | sed -n "s/\.//g"
#echo ${TT} | sed "s/['.]//g"

[ -e "$1" ] && mv "$1" "${SYM}_${TITLE}.mp4"
