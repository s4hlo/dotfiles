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
upload_speed_icon='󰕒'
download_speed_icon='󰇚'
show_upload_speed="$(tmux_get @tmux_power_show_upload_speed false)"
show_download_speed="$(tmux_get @tmux_power_show_download_speed false)"
time_format=$(tmux_get @tmux_power_time_format '%T')
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
tmux_set status-interval 1
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
LS="#[fg=$NIL,bg=$BLUE,bold]  ⠀"

wait_mode="#[fg=$BLUE]#[bg=$GREEN]$rarrow #[fg=$WHITE]#[bg=$GREEN] #S #[fg=$GREEN]#[bg=$LIGHT_GREY]$rarrow"
tmux_mode="#[fg=$BLUE]#[bg=$BLUE]$rarrow #[fg=$DARK_GREY]#[bg=$BLUE] #S #[fg=$BLUE]#[bg=$LIGHT_GREY]$rarrow"
copy_mode="#[fg=$BLUE]#[bg=$PURPLE]$rarrow #[fg=$DARK_GREY]#[bg=$PURPLE] #S #[fg=$PURPLE]#[bg=$LIGHT_GREY]$rarrow"
sync_mode="#[fg=$BLUE]#[bg=$RED]$rarrow #[fg=$DARK_GREY]#[bg=$RED] #S #[fg=$RED]#[bg=$LIGHT_GREY]$rarrow"

LS="$LS#{?client_prefix,$wait_mode,#{?pane_in_mode,$copy_mode,#{?pane_synchronized,$sync_mode,$tmux_mode} } } "

if "$show_upload_speed"; then
    LS="$LS#[fg=$WHITE,bg=$LIGHT_GREY] $upload_speed_icon #{upload_speed} #[fg=$LIGHT_GREY,bg=$NIL]$rarrow"
else
    LS="$LS#[fg=$DARK_GREY,bg=$NIL]$rarrow"
fi

tmux_set status-left "$LS"

# --------------------- RIGHT SIDE OF STATUS BAR
tmux_set status-right-bg "$NIL"
tmux_set status-right-fg "$WHITE"
tmux_set status-right-length 150

RS="#[fg=$DARK_GREY]$larrow#[fg=$BLUE,bg=$DARK_GREY]$time_format #[fg=$BLUE,bg=$DARK_GREY]$larrow#[fg=$NIL,bg=$BLUE] ⠀  $date_format  "
if "$show_download_speed"; then
    RS="#[fg=$LIGHT_GREY,bg=$NIL]$larrow#[fg=$BLUE,bg=$LIGHT_GREY] $download_speed_icon #{download_speed} $RS"
fi
tmux_set status-right "$RS"


# ---------------------------WINDOW STATUS FORMAT
tmux_set window-status-format         "#[fg=$DARK_GREY,bg=default]$i_rarrow#[fg=$WHITE,bg=$DARK_GREY] #I #W #[fg=$DARK_GREY,bg=$NIL]$rarrow"
tmux_set window-status-current-format "#[fg=$NIL,bg=default]$i_rarrow#[fg=$DARK_GREY,bg=$BLUE] #I #W #[fg=$BLUE,bg=$NIL]$rarrow"


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
