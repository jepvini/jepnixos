#!/usr/bin/env bash

WS="$(swaymsg -t get_workspaces | jq '.[] | select(.focused==true)' | grep "num" | grep -P '\d\d|\d' -o)"

if [[ "$WS" -eq 10 ]]; then
  swaymsg workspace "$(cat /tmp/spt)"
  exit 0
fi

echo "$WS" > "/tmp/spt"

if swaymsg workspace 10;
then
  if ! pidof spt; then
    wezterm start -e spt
  fi
fi
