#!/bin/bash

function download_gh_release() {
  local repo="$1"
  local target="$2"
  echo Download "${target}" from github: "${repo}"
  # curl -sLO $(curl -s https://api.github.com/repos/$1/releases/latest | jq -r '.assets[] | select(.name | startswith("'"$2"'")) | .browser_download_url')
  download_url=$(curl -s "https://api.github.com/repos/${repo}/releases/latest" | jq -r '.assets[] | select(.name | startswith("'"${target}"'")) | .browser_download_url')
  echo ${download_url}
  curl -sLO ${download_url}
}

#download_gh_release yuru7/HackGen HackGen_NF
#download_gh_release yuru7/moralerspace MoralerspaceNF

while IFS=',' read -r key value; do
  download_gh_release "$key" "$value"
done <<EOF
yuru7/HackGen,HackGen_NF
yuru7/moralerspace,MoralerspaceNF
EOF
