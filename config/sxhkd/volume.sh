#!/bin/bash
# https://gist.github.com/sebastiencs/5d7227f388d93374cebdf72e783fbd6a

function get_volume {
  amixer -D pulse sget Master | grep 'Left:' | awk -F'[][]' '{ print $2 }'
}

function is_mute {
  amixer get Master | grep '%' | grep -oE '[^ ]+$' | grep off > /dev/null
}

function send_notification {
  volume=`get_volume`
  bar=$(seq -s "─" $(($((${volume: :-1}+5))/5)) | sed 's/[0-9]//g')
  dunstify -r 2593 -u normal "$bar"
}

case $1 in
  up)
    amixer -D pulse set Master on > /dev/null
    amixer -D pulse sset Master 5%+ > /dev/null
    send_notification
    ;;
  down)
    amixer -D pulse set Master on > /dev/null
    amixer -D pulse sset Master 5%- > /dev/null
    send_notification
    ;;
  toggle)
    amixer -D pulse set Master 1+ toggle > /dev/null
    if is_mute ; then
      dunstify -r 2593 -u normal " Muted"
    else
      send_notification
    fi
    ;;
esac
