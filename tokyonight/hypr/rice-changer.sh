#!/usr/bin/env bash

dir="$HOME/.config/hypr/"
wofi_command="wofi --dmenu"

# Options
tokyonight=" tokyonight"
superhot=" superhot"

options="$tokyonight\n$superhot"
chosen="$(printf "$options" | $wofi_command)"
	case $chosen in
			$tokyonight)
				cat <<< "tokyonight" > $dir/rice.cfg
				;;
			$superhot)
				cat <<< "superhot" > $dir/rice.cfg
				;;
	esac
