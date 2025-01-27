#!/bin/sh -eu

### Incoming WebHooksのURL
#WEBHOOKURL="https://hooks.slack.com/services/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"
WEBHOOKURL='https://discord.com/api/webhooks/1330312280499290162/I0kkSU-9V-Poy3b1HxtS8AYyXIqX2LlyqV2Jhky2obXxXunHZK87oq681RlxizQKTfzP/slack'

BOTNAME="NOTIFY Shell Bot"

ICON='icon_emoji' # 'icon_url'か'icon_emoji'を選択可能
FACEICON=":tada:" #urlで設置可能

HEADER=""
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
            MESSAGE=$OPTARG"\n"
            ;;
        \?)
            usage_exit
            ;;
    esac
done

WEBMESSAGE="${MESSAGE}"

# Incoming WebHooks送信
#echo curl -s -S -X POST --data-urlencode "payload={\"username\": \"${BOTNAME}\", \"${ICON}\": \"${FACEICON}\", \"text\": \"${HEADER}${WEBMESSAGE}\" }" ${WEBHOOKURL}
curl -s -S -X POST --data-urlencode "payload={\"username\": \"${BOTNAME}\", \"${ICON}\": \"${FACEICON}\", \"text\": \"${HEADER}${WEBMESSAGE}\" }" ${WEBHOOKURL} >/dev/null
