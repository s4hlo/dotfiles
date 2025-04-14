#!/bin/bash

start_pomodoro() {
  pomodoro_time=$1
  rest_time=$2
  nohup bash -c "
    pomodoro_time=$pomodoro_time
    rest_time=$rest_time
    while true; do
      notify-send --urgency=critical 'Pomodoro started!' '$pomodoro_time minutes of focus.'
      sleep \$((pomodoro_time * 60))
      notify-send --urgency=critical 'Pomodoro complete!' '$rest_time minutes break.'
      sleep \$((rest_time * 60))
    done
  " >/dev/null 2>&1 &
  echo $! > ~/.pomo.pid
}

stop_pomodoro() {
  if [ -f ~/.pomo.pid ]; then
    pid=$(cat ~/.pomo.pid)
    if kill -0 "$pid" 2>/dev/null; then
      kill "$pid" && rm ~/.pomo.pid
      notify-send --urgency=normal "Pomodoro stopped." 
    else
      rm ~/.pomo.pid
      notify-send "No Pomodoro running (stale PID file removed)."
    fi
  else
    notify-send "No Pomodoro running"
  fi
}

show_help() {
  echo "Usage: pomo <pomodoro_time> <short_break_time> | pomo stop | pomo -h"
}

# Check arguments
if [[ "$1" == "-h" ]]; then
  show_help
  exit 0
elif [[ "$1" == "stop" ]]; then
  stop_pomodoro
  exit 0
elif [[ -z "$1" || -z "$2" ]]; then
  show_help
  exit 1
fi

start_pomodoro $1 $2

## alias in .zshrc
# alias pomo='~/dotfiles/pomo.sh'
