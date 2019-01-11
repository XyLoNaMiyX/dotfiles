#!/bin/bash

beep() {
    paplay /usr/share/sounds/freedesktop/stereo/message.oga &
}

if [[ -f /tmp/screenrecord.pid ]]; then
	kill -INT $(cat "/tmp/screenrecord.pid")
	rm /tmp/screenrecord.pid
    beep
	exit 0
fi

read -r X Y W H < <(slop -f "%x %y %w %h" -q)
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
ffmpeg \
    -video_size ${W}x$H \
    -framerate 25 \
    -f x11grab \
    -i :0.0+$X,$Y \
    -pix_fmt yuv420p \
    "$HOME/Desktop/sr-$DATE.mp4" &

echo $! > /tmp/screenrecord.pid
