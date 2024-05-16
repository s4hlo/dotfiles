#!/usr/bin/env bash
#===============================================================================
#   Author: S4hlo
#  Created: 2024-05-16 17:37
#===============================================================================

# $1: option
# $2: default value
tmux_get() {
    local value="$(tmux show -gqv "$1")"
    [ -n "$value" ] && echo "$value" || echo "$2"
}

# $1: option
# $2: value
tmux_set() {
    tmux set-option -gq "$1" "$2"
}

# Options
# TODO this i will turn a style option in the future
STYLE='angled'

# Set arrow symbols based on the selected theme
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
date_format=$(tmux_get @tmux_power_date_format '%F')

# ------ THEME -------
BLUE=#698DDA
RED=#e06c75
PURPLE=#c678dd
GREEN=#98c379

WHITE=#abb2bf
LIGHT_GREY=#3e4452
DARK_GREY=#282c34
NIL=default

STATUS_COLOR="#{?client_prefix,$PURPLE,#{?pane_in_mode,$GREEN,#{?pane_synchronized,$RED,$BLUE}}}"
# ---------------------

# Status options
tmux_set status-style                 "fg=$NIL,bg=$NIL"
tmux_set status-interval 0
tmux_set status on

# Basic status bar colors
tmux_set status-fg "$DARK_GREY"
tmux_set status-bg "$NIL"
tmux_set status-attr none

# tmux-prefix-highlight
tmux_set @prefix_highlight_fg "$NIL"
tmux_set @prefix_highlight_bg "$DARK_GREY"
tmux_set @prefix_highlight_show_copy_mode 'on'
tmux_set @prefix_highlight_copy_mode_attr "fg=$STATUS_COLOR,bg=$NIL,bold"
tmux_set @prefix_highlight_output_prefix "#[fg=$STATUS_COLOR]#[bg=$NIL]$larrow#[bg=$STATUS_COLOR]#[fg=$NIL]"
tmux_set @prefix_highlight_output_suffix "#[fg=$STATUS_COLOR]#[bg=$NIL]$rarrow"

# ---------------------- LEFT SIDE OF STATUS BAR
tmux_set status-left-bg "$NIL"
tmux_set status-left-fg "$WHITE"
tmux_set status-left-length 150

LS="#[fg=$DARK_GREY]#[bg=$STATUS_COLOR]#[bold]  ⠀#[fg=$STATUS_COLOR]#[bg=$LIGHT_GREY]$rarrow"

LS="$LS#[fg=$WHITE,bg=$LIGHT_GREY] #(whoami) #[fg=$LIGHT_GREY,bg=$NIL]$rarrow"

tmux_set status-left "$LS"

# --------------------- RIGHT SIDE OF STATUS BAR
tmux_set status-right-bg "$NIL"
tmux_set status-right-fg "$WHITE"
tmux_set status-right-length 150

RS="#[fg=$STATUS_COLOR]#[bg=$LIGHT_GREY]$larrow#[fg=$NIL]#[bg=$STATUS_COLOR]#[bold]   $date_format  "

RS="#[fg=$LIGHT_GREY]$larrow#[fg=$WHITE]#[bg=$LIGHT_GREY]#[bold]  #(git -C #{pane_current_path} branch --show-current) $RS"
RS="#[fg=$DARK_GREY,bg=$NIL]$larrow#[fg=$WHITE,bg=$DARK_GREY] $download_speed_icon #{download_speed} $RS"
tmux_set status-right "$RS"


# ---------------------------WINDOW STATUS FORMAT
tmux_set window-status-format         "#[fg=$DARK_GREY,bg=default]$i_rarrow#[fg=$WHITE,bg=$DARK_GREY] #I #W #[fg=$DARK_GREY,bg=$NIL]$rarrow"

WS="#[fg=$STATUS_COLOR]#[bg=$NIL]$i_rarrow#[fg=$DARK_GREY]#[bg=$STATUS_COLOR]#[bold] #I #W #[fg=$STATUS_COLOR]#[bg=$NIL]$rarrow"

tmux_set window-status-current-format "$WS"

# Window separator
tmux_set window-status-separator ""

# Window status style
tmux_set window-status-style          "fg=$STATUS_COLOR,bg=$NIL,none"
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
