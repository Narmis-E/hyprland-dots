#!/bin/env bash

source "$HOME"/.config/rofi/applets/shared/theme.bash
theme="$type/$style"
mesg='~/Pictures/wallpapers'
prompt='Wallpapers'


wallpaper_folder=$HOME/Pictures/wallpapers
wallpaper_location="$(ls "$wallpaper_folder" | sort | rofi -dmenu -hover-select -me-select-entry '' -me-accept-entry MousePrimary -theme ${theme} -theme-str 'textbox-prompt-colon {str: "󰋩 ";}' -p $prompt -mesg $mesg)"


if [[ -d $wallpaper_folder/$wallpaper_location ]]; then
    wallpaper_temp="$wallpaper_location"
elif [[ -f $wallpaper_folder/$wallpaper_location ]]; then
	swww img "$wallpaper_folder"/"$wallpaper_temp"/"$wallpaper_location" --transition-fps 120 --transition-type any --transition-duration 3
else
    exit 1
fi
