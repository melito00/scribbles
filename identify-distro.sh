#!/bin/sh

if [ -e /etc/os-release ]; then
  . /etc/os-release
fi

echo $ID

case $ID in
  debian | void)
    echo "void"
    ;;
  *)
    echo "None"
    ;;
esac

