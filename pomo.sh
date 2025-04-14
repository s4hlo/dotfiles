start_pomodoro() {
  pomodoro_time=$1
  rest_time=$2
  while true; do
    notify-send --urgency=critical "Pomodoro started!" "$pomodoro_time minutes of focus." 
    sleep $((pomodoro_time * 60)) &
    wait $!
    notify-send --urgency=critical "Pomodoro complete!" "$rest_time minutes break." 
    sleep $((rest_time * 60)) &
    wait $!
  done
}


show_help() {
  echo "Usage: pomo.sh <pomodoro_time> <short_break_time>"
}

if [[ -z "$1" || "$1" == "-h" ]]; then
  show_help
  exit 0
fi

start_pomodoro $1 $2

## command to run in .zshrc
# alias pomo='nohup ~/dotfiles/pomo.sh 25 5 &'
