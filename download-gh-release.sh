#!/bin/bash
#

function download_gh_release() {
  echo Download $2 from github: $1
  # curl -sLO $(curl -s https://api.github.com/repos/$1/releases/latest | jq -r '.assets[] | select(.name | startswith("'"$2"'")) | .browser_download_url')
  download_url=$(curl -s https://api.github.com/repos/$1/releases/latest | jq -r '.assets[] | select(.name | startswith("'"$2"'")) | .browser_download_url')
  echo ${download_url}
  curl -sLO ${download_url}
}

download_gh_release yuru7/HackGen HackGen_NF
download_gh_release yuru7/moralerspace MoralerspaceNF

