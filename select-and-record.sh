#!/bin/bash

beep() {
    paplay /usr/share/sounds/freedesktop/stereo/message.oga &
}

boop() {
    paplay /usr/share/sounds/freedesktop/stereo/complete.oga &
}

PID_FILE="/tmp/screenrecord.pid"
PATH_FILE="/tmp/screenrecord.fle"

if [[ -f $PID_FILE ]]; then
    if (( $1 == "screenkey" )); then
        killall screenkey
    fi
    kill -INT "$(cat $PID_FILE)"
    xclip -se c -t video/mp4 "$(cat $PATH_FILE)"
    rm $PID_FILE $PATH_FILE
    boop
    exit 0
fi

read -r X Y W H < <(hacksaw -f "%x %y %w %h")
if [[ -z "$X" ]]; then
    exit 0
fi
if (( $W % 2 == 1)); then
    W=$((W + 1))
fi
if (( $H % 2 == 1)); then
    H=$((H + 1))
fi

beep
DATE=$(date '+%Y-%m-%d_%H-%M-%S')
FILE="$HOME/Desktop/sr-$DATE.mp4"

if (( $1 == "screenkey" )); then
    screenkey -g${W}x$H+$X+$Y
fi

ffmpeg \
    -video_size ${W}x$H \
    -framerate 25 \
    -f x11grab \
    -i :0.0+$X,$Y \
    -pix_fmt yuv420p \
    $FILE &

echo $! > $PID_FILE
echo $FILE > $PATH_FILE
