#!/usr/bin/env python3

import subprocess
import json


def get_status():
    state = subprocess.check_output([
        'dbus-send',
        '--session',
        '--dest=org.gnome.Pomodoro',
        '--print-reply',
        '/org/gnome/Pomodoro',
        'org.freedesktop.DBus.Properties.Get',
        'string:org.gnome.Pomodoro',
        'string:State'
    ]).decode('utf-8')

    # Parse state
    state = state.split(' ')[-1].strip('"\n')

    return state


def get_remaining_time():
    elapsed_time = subprocess.check_output([
        'dbus-send',
        '--session',
        '--dest=org.gnome.Pomodoro',
        '--print-reply',
        '/org/gnome/Pomodoro',
        'org.freedesktop.DBus.Properties.Get',
        'string:org.gnome.Pomodoro',
        'string:Elapsed'
    ]).decode('utf-8')

    state_duration = subprocess.check_output([
        'dbus-send',
        '--session',
        '--dest=org.gnome.Pomodoro',
        '--print-reply',
        '/org/gnome/Pomodoro',
        'org.freedesktop.DBus.Properties.Get',
        'string:org.gnome.Pomodoro',
        'string:StateDuration'
    ]).decode('utf-8')

    # Parse elapsed time and state duration
    elapsed_time = float(elapsed_time.split(' ')[-1])
    state_duration = float(state_duration.split(' ')[-1])

    # Calculate remaining time
    remaining_time = state_duration - elapsed_time
    remaining_minutes = int(remaining_time // 60)
    remaining_seconds = int(remaining_time % 60)
    return f"{remaining_minutes:02d}:{remaining_seconds:02d}"


status = get_status()
remaining_time = get_remaining_time()

if status == "pomodoro":
    text = "🍅"
else:
    text = "☕"

if status == "pomodoro":
    tooltip = remaining_time + " to break"
else:
    tooltip = remaining_time + " to work"

module = {
    "text": text,
    "tooltip": tooltip
}

print(json.dumps(module))
