#!/bin/sh

# 引数(ホスト:ディレクトリ)は必須
REMOTE_HOME=${REMOTE_HOME:-/home/kyamada}

PROFILE=""
HOST=""
REMOTE_DIR=""

while getopts ":p:" opt; do
  case "$opt" in
    p)
      PROFILE="$OPTARG"
      ;;
    \?)
      printf "Usage: %s [-p profile] host path\n" "$0" >&2
      exit 1
      ;;
    :)
      printf "Option -%s requires an argument.\n" "$OPTARG" >&2
      exit 1
      ;;
  esac
done

shift $((OPTIND - 1))

if [ $# -ne 2 ]; then
  printf "Usage: %s [-p profile] host path\n" "$0" >&2
  exit 1
fi

HOST="$1"
REMOTE_DIR="$2"

printf "PROFILE: %s\n" "$PROFILE"
printf "HOST: %s\n" "$HOST"
printf "REMOTE_DIR: %s\n" "$REMOTE_DIR"

path="${REMOTE_HOME}/${REMOTE_DIR}"
echo $host ${path}

if [ "${PROFILE}" = "" ]; then
  code --folder-uri "vscode-remote://ssh-remote+$host$path"
else
  code --profile ${PROFILE} --folder-uri "vscode-remote://ssh-remote+$host$path"
fi
