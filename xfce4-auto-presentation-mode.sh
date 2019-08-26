#!/usr/bin/bash
set -e

SCREENSAVER_ENABLED=0

xfce_update_presentation_mode() {
  prop='/xfce4-power-manager/presentation-mode'
  channel='xfce4-power-manager'

  if [ "$SCREENSAVER_ENABLED" -eq 0 ]; then
    xfconf-query -c "$channel" -p "$prop" -s 'false'
  else
    xfconf-query -c "$channel" -p "$prop" -s 'true'
  fi
}

screensaver() {
  if [ "$1" != "0" ] && [ "$1" != "1" ]; then
    echo "$0: screensaver(): Bad argument. Expected '0' or '1'; got '$1'."
    return 1
  fi

  if [ $SCREENSAVER_ENABLED -ne $1 ]; then
    SCREENSAVER_ENABLED=$1
    xfce_update_presentation_mode
  fi
}

await_root_property_change() {
  prop="$1"

  xprop -spy -root "$prop" | head -n2 >/dev/null
}

watch_window() {
  xprop -spy -id "$id" _NET_WM_STATE |
    while read state; do
      xprop_pid="$(pgrep -P $$ xprop)"

      if echo "$state" | grep -vq _NET_WM_STATE_FOCUSED; then
        kill "$xprop_pid"
      fi

      if echo "$state" | grep -q _NET_WM_STATE_FULLSCREEN; then
        screensaver 1
      else
        screensaver 0
      fi
    done
}

while true; do
  id="$(xprop -root _NET_ACTIVE_WINDOW | grep -o '0x[0-9A-Fa-f]*' | head -n -1)"
  if [ -z "$id" ] || [ "$id" == "0x0" ]; then
    echo "$0: active window is null"
    await_root_property_change _NET_ACTIVE_WINDOW
    echo "$0: active window changed, retrying..."
    continue
  fi

  echo "$0: watching window #$id"
  watch_window "$id"
done
