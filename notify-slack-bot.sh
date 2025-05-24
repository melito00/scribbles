#!/bin/sh -eu

### Incoming WebHooksのURL
URL="https://slack.com/api/chat.postMessage"
AUTH_TOKEN='Authorization: Bearer xoxb-'
REQ_HEADER='Content-Type: application/json; charset=utf-8'

CHANNEL='#notify'
EMOJI=":tada:"

HEADER="*NOTIFY BOT*"
MESSAGE="default message"

usage_exit() {
    echo "Usage: $0 [-h header] [-m message]" 1>&2
    exit 0
}

while getopts h:m: opts
do
    case $opts in
        h)
            HEADER=$OPTARG
            ;;
        m)
            MESSAGE=$OPTARG
            ;;
        \?)
            usage_exit
            ;;
    esac
done

FORMATED_MSG="${HEADER}"'```'"${MESSAGE}"'```'

JSON_DATA=$(jq -n --arg channel "$CHANNEL" --arg text "$FORMATED_MSG" '{
  channel: $channel,
  text: $text
}')

curl --silent \
  --show-error \
  --request POST "${URL}" \
  --header "${AUTH_TOKEN}" \
  --header "${REQ_HEADER}" \
  --data  "${JSON_DATA}"
