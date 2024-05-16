#!/usr/bin/env bash
#===============================================================================
#   Author: Wenxuan
#    Email: wenxuangm@gmail.com
#  Created: 2018-04-05 17:37
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
i_rarrow=''
rarrow=''
larrow=''
download_speed_icon='󰇚'
date_format=$(tmux_get @tmux_power_date_format '%F')

BLUE=#698DDA
RED=#e06c75
PURPLE=#c678dd
GREEN=#98c379
WHITE=#abb2bf
NIL=default #235
LIGHT_GREY=#3e4452 #236
DARK_GREY=#282c34 #241

# Status options
tmux_set status-style                 "fg=$NIL,bg=$NIL"
tmux_set status-interval 5
tmux_set status on

# Basic status bar colors
tmux_set status-fg "$DARK_GREY"
tmux_set status-bg "$NIL"
tmux_set status-attr none

# tmux-prefix-highlight
tmux_set @prefix_highlight_fg "$NIL"
tmux_set @prefix_highlight_bg "$DARK_GREY"
tmux_set @prefix_highlight_show_copy_mode 'on'
tmux_set @prefix_highlight_copy_mode_attr "fg=$BLUE,bg=$NIL,bold"
tmux_set @prefix_highlight_output_prefix "#[fg=$BLUE]#[bg=$NIL]$larrow#[bg=$BLUE]#[fg=$NIL]"
tmux_set @prefix_highlight_output_suffix "#[fg=$BLUE]#[bg=$NIL]$rarrow"

# ---------------------- LEFT SIDE OF STATUS BAR
tmux_set status-left-bg "$NIL"
tmux_set status-left-fg "$WHITE"
tmux_set status-left-length 150
# LS="#[fg=$NIL,bg=$BLUE,bold]  ⠀"

copy_mode="#[fg=$DARK_GREY]#[bg=$GREEN]#[bold]  ⠀#[fg=$GREEN]#[bg=$LIGHT_GREY]$rarrow"
tmux_mode="#[fg=$DARK_GREY]#[bg=$BLUE]#[bold]  ⠀#[fg=$BLUE]#[bg=$LIGHT_GREY]$rarrow"
wait_mode="#[fg=$DARK_GREY]#[bg=$PURPLE]#[bold]  ⠀#[fg=$PURPLE]#[bg=$LIGHT_GREY]$rarrow"
sync_mode="#[fg=$DARK_GREY]#[bg=$RED]#[bold]  ⠀#[fg=$RED]#[bg=$LIGHT_GREY]$rarrow"

LS="#{?client_prefix,$wait_mode,#{?pane_in_mode,$copy_mode,#{?pane_synchronized,$sync_mode,$tmux_mode}}} "

LS="$LS#[fg=$WHITE,bg=$LIGHT_GREY]#(whoami) #[fg=$LIGHT_GREY,bg=$NIL]$rarrow"

tmux_set status-left "$LS"

# --------------------- RIGHT SIDE OF STATUS BAR
tmux_set status-right-bg "$NIL"
tmux_set status-right-fg "$WHITE"
tmux_set status-right-length 150

copy_right="#[fg=$GREEN]#[bg=$LIGHT_GREY]$larrow#[fg=$NIL]#[bg=$GREEN]#[bold]  $date_format  "
tmux_right="#[fg=$BLUE]#[bg=$LIGHT_GREY]$larrow#[fg=$NIL]#[bg=$BLUE]#[bold]  $date_format "
wait_right="#[fg=$PURPLE]#[bg=$LIGHT_GREY]$larrow#[fg=$NIL]#[bg=$PURPLE]#[bold]  $date_format  "
sync_right="#[fg=$RED]#[bg=$LIGHT_GREY]$larrow#[fg=$NIL]#[bg=$RED]#[bold]  $date_format  "

RS="#{?client_prefix,$wait_right,#{?pane_in_mode,$copy_right,#{?pane_synchronized,$sync_right,$tmux_right}}}"

RS="#[fg=$LIGHT_GREY]$larrow#[fg=$WHITE]#[bg=$LIGHT_GREY]#[bold]  #(git -C #{pane_current_path} branch --show-current) $RS"
RS="#[fg=$DARK_GREY,bg=$NIL]$larrow#[fg=$WHITE,bg=$DARK_GREY] $download_speed_icon #{download_speed} $RS"
tmux_set status-right "$RS"


# ---------------------------WINDOW STATUS FORMAT
tmux_set window-status-format         "#[fg=$DARK_GREY,bg=default]$i_rarrow#[fg=$WHITE,bg=$DARK_GREY] #I #W #[fg=$DARK_GREY,bg=$NIL]$rarrow"

copy_window="#[fg=$GREEN]#[bg=$NIL]$i_rarrow#[fg=$DARK_GREY]#[bg=$GREEN]#[bold] #I #W #[fg=$GREEN]#[bg=$NIL]$rarrow"
tmux_window="#[fg=$BLUE]#[bg=$NIL]$i_rarrow#[fg=$DARK_GREY]#[bg=$BLUE]#[bold] #I #W #[fg=$BLUE]#[bg=$NIL]$rarrow"
wait_window="#[fg=$PURPLE]#[bg=$NIL]$i_rarrow#[fg=$DARK_GREY]#[bg=$PURPLE]#[bold] #I #W #[fg=$PURPLE]#[bg=$NIL]$rarrow"
sync_window="#[fg=$RED]#[bg=$NIL]$i_rarrow#[fg=$DARK_GREY]#[bg=$RED]#[bold] #I #W #[fg=$RED]#[bg=$NIL]$rarrow"

WS="#{?client_prefix,$wait_window,#{?pane_in_mode,$copy_window,#{?pane_synchronized,$sync_window,$tmux_window}}}"

tmux_set window-status-current-format "$WS"

# Window separator
tmux_set window-status-separator ""

# Window status style
tmux_set window-status-style          "fg=$BLUE,bg=$NIL,none"
tmux_set window-status-last-style     "fg=$BLUE,bg=$NIL,none"
tmux_set window-status-activity-style "fg=$BLUE,bg=$NIL,bold"

# Pane border
tmux_set pane-border-style "fg=$DARK_GREY,bg=default"

# Active pane border
tmux_set pane-active-border-style "fg=$BLUE,bg=default"

# Pane number indicator
tmux_set display-panes-colour "$DARK_GREY"
tmux_set display-panes-active-colour "$BLUE"

# Clock mode
tmux_set clock-mode-colour "$BLUE"
tmux_set clock-mode-style 24

# Message
tmux_set message-style "fg=$BLUE,bg=$NIL"

# Command message
tmux_set message-command-style "fg=$BLUE,bg=$NIL"

# Copy mode highlight
tmux_set mode-style "bg=$BLUE,fg=$DARK_GREY"
