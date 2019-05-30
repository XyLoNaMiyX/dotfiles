#!/bin/bash
DIR=~/Pictures/Screenshots
FILE="$DIR/$(date '+%Y-%m-%d_%H-%M-%S').png"

mkdir -p "$DIR"
shotgun $(slop -f "-i %i -g %g") "$FILE"
xclip -se c -t image/png "$FILE"
