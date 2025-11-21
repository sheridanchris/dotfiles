#!/usr/bin/env bash

search_dir="$HOME/Pictures/wallpapers"
interval_seconds=$((5 * 60))
[[ "$1" == "--interval" && "$2" =~ ^[0-9]+$ ]] && interval_seconds="$2"
while true; do
    wallpaper=$(find "$search_dir" -type f \( -iname "*.png" -o -iname "*.jpg" \) | shuf -n 1)
    [[ -n "$wallpaper" ]] && wbg -s "$wallpaper" &
    sleep "$interval_seconds"
done