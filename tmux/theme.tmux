#!/usr/bin/env bash
#===============================================================================
#   Author: S4hlo
#===============================================================================

tmux_get() {
    local value="$(tmux show -gqv "$1")"
    [ -n "$value" ] && echo "$value" || echo "$2"
}

tmux_set() {
    tmux set-option -gq "$1" "$2"
}

# ------- CUSTOMIZATION --------------
MAIN_ICON=$(tmux_get @tmux_line_indicator 'TMUX')
DATE_FORMAT=$(tmux_get @tmux_power_date_format '%F')
STYLE=$(tmux_get @tmux_line_style 'angled')
JUSTIFY=$(tmux_get @tmux_line_justify 'left')

# ------ THEME -------
BLUE=$(tmux_get @tmux_line_color_blue "#698DDA")
RED=$(tmux_get @tmux_line_color_red "#e06c75")
PURPLE=$(tmux_get @tmux_line_color_purple "#c678dd")
GREEN=$(tmux_get @tmux_line_color_green "#98c379")

WHITE=$(tmux_get @tmux_line_color_white "#abb2bf")
LIGHT_GREY=$(tmux_get @tmux_line_color_light_grey "#3e4452")
DARK_GREY=$(tmux_get @tmux_line_color_dark_grey "#282c34")
NIL=$(tmux_get @tmux_line_color_nil "default")

STATUS_COLOR="#{?client_prefix,$PURPLE,#{?pane_in_mode,$GREEN,#{?pane_synchronized,$RED,$BLUE}}}"

# ---------------------------------------
case $STYLE in
  flat)
    i_rarrow=''
    rarrow=''
    larrow=''
    ;;
  angled)
    i_rarrow=''
    rarrow=''
    larrow=''
    ;;
  arrow)
    i_rarrow=''
    rarrow=''
    larrow=''
    ;;
  rounded)
    i_rarrow=' '
    rarrow=''
    larrow=''
    ;;
  *)
    echo "Unknown theme: $STYLE"
    ;;
esac

download_speed_icon='󰇚'

# --------------------- GENERAL

# Status options
tmux_set status-style "fg=$WHITE,bg=$NIL"
tmux_set status-interval  1
tmux_set status-justify "$JUSTIFY"
tmux_set status on
tmux_set status-attr none

# ---------------------- LEFT SIDE OF STATUS BAR
tmux_set status-left-length 150

LS="#[fg=$DARK_GREY]#[bg=$STATUS_COLOR]#[bold] $MAIN_ICON ⠀#[fg=$STATUS_COLOR]#[bg=$LIGHT_GREY]$rarrow"
LS="$LS#[fg=$WHITE,bg=$LIGHT_GREY] #(whoami) #[fg=$LIGHT_GREY,bg=$NIL]$rarrow"

tmux_set status-left "$LS"

# --------------------- RIGHT SIDE OF STATUS BAR
tmux_set status-right-length 150

RS="#[fg=$STATUS_COLOR]#[bg=$LIGHT_GREY]$larrow#[fg=$DARK_GREY]#[bg=$STATUS_COLOR]#[bold] $DATE_FORMAT⠀"
RS="#[fg=$LIGHT_GREY]$larrow#[fg=$WHITE]#[bg=$LIGHT_GREY]#[bold] $GIT   #(git -C #{pane_current_path} branch --show-current) $RS"
RS="#[fg=$DARK_GREY,bg=$NIL]$larrow#[fg=$WHITE,bg=$DARK_GREY] $download_speed_icon #{download_speed} $RS"

tmux_set status-right "$RS"


# ---------------------------WINDOW STATUS FORMAT
tmux_set window-status-format         "#[fg=$DARK_GREY,bg=default]#[bold]$i_rarrow#[fg=$WHITE,bg=$DARK_GREY] #I #W #[fg=$DARK_GREY,bg=$NIL]$rarrow"

WS="#[fg=$STATUS_COLOR]#[bg=$NIL]#[bold]$i_rarrow#[fg=$DARK_GREY]#[bg=$STATUS_COLOR]#[bold] #I #W #[fg=$STATUS_COLOR]#[bg=$NIL]$rarrow"

tmux_set window-status-current-format "$WS"

# Window separator
tmux_set window-status-separator ""

# Window status style
tmux_set window-status-style          "fg=$STATUS_COLOR,bg=$NIL,bold"
tmux_set window-status-last-style     "fg=$STATUS_COLOR,bg=$NIL,none"
tmux_set window-status-activity-style "fg=$STATUS_COLOR,bg=$NIL,bold"

# Pane border
tmux_set pane-border-style "fg=$DARK_GREY,bg=default"

# Active pane border
tmux_set pane-active-border-style "fg=$STATUS_COLOR,bg=default"

# Pane number indicator
tmux_set display-panes-colour "$DARK_GREY"
tmux_set display-panes-active-colour "$STATUS_COLOR"

# Clock mode
tmux_set clock-mode-colour "$STATUS_COLOR"
tmux_set clock-mode-style 24

# Message
tmux_set message-style "fg=$STATUS_COLOR,bg=$NIL"

# Command message
tmux_set message-command-style "fg=$STATUS_COLOR,bg=$NIL"

# Copy mode highlight
tmux_set mode-style "bg=$STATUS_COLOR,fg=$DARK_GREY"
