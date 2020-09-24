#!/usr/bin/env bash

for i in $(xinput list | grep "TouchPad" | perl -n -e'/id=(\d+)/ && print "$1\n"')
do
  xinput set-button-map "$i" 1 0 3 4 5 6 7
done

if type libinput-gestures-setup > /dev/null; then
  libinput-gestures-setup start
fi
