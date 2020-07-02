#!/bin/bash
DIR=~/Pictures/Screenshots
FILE="$DIR/$(date '+%Y-%m-%d_%H-%M-%S').png"

mkdir -p "$DIR"

if (( $1 == "freeze" )); then
    sleep 1
    shotgun - | pqiv -if - &
    PID=$!
fi

shotgun $(hacksaw -f "-i %i -g %g") "$FILE"

if (( $1 == "freeze" )); then
    kill -KILL $PID
fi

xclip -se c -t image/png "$FILE"
