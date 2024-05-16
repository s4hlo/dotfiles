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
i_rarrow=$(tmux_get '@tmux_power_right_i_arrow_icon' '')
i_larrow=$(tmux_get '@tmux_power_left_i_arrow_icon' '')
rarrow=$(tmux_get '@tmux_power_right_arrow_icon' '')
larrow=$(tmux_get '@tmux_power_left_arrow_icon' '')
upload_speed_icon=$(tmux_get '@tmux_power_upload_speed_icon' '󰕒')
download_speed_icon=$(tmux_get '@tmux_power_download_speed_icon' '󰇚')
session_icon="$(tmux_get '@tmux_power_session_icon' '')"
user_icon="$(tmux_get '@tmux_power_user_icon' '')"
time_icon="$(tmux_get '@tmux_power_time_icon' '')"
date_icon="$(tmux_get '@tmux_power_date_icon' '')"
show_upload_speed="$(tmux_get @tmux_power_show_upload_speed false)"
show_download_speed="$(tmux_get @tmux_power_show_download_speed false)"
show_web_reachable="$(tmux_get @tmux_power_show_web_reachable false)"
prefix_highlight_pos=$(tmux_get @tmux_power_prefix_highlight_pos)
time_format=$(tmux_get @tmux_power_time_format '%T')
date_format=$(tmux_get @tmux_power_date_format '%F')
# short for Theme-Colour

# local colors = {
#       blue = "#61afef",
#       green = "#98c379",
#       purple = "#c678dd",
#       cyan = "#56b6c2",
#       red1 = "#e06c75",
#       red2 = "#be5046",
#       yellow = "#e5c07b",
#       fg = "#abb2bf",
#       bg = "#282c34",
#       gray1 = "#828997",
#       gray2 = nil,
#       gray3 = "#3e4452",
#     }

TC=#698DDA
WHITE=#abb2bf
NIL=default #235
G05=#3e4452 #236
G06=#282c34 #237
G07=#444444 #238
G10=#282c34 #241
G12=#767676 #243
# 828997
FG="$G10"

# Status options
tmux_set status-interval 1
tmux_set status on

# Basic status bar colors
tmux_set status-fg "$FG"
tmux_set status-bg "$NIL"
tmux_set status-attr none

# tmux-prefix-highlight
tmux_set @prefix_highlight_fg "$NIL"
tmux_set @prefix_highlight_bg "$FG"
tmux_set @prefix_highlight_show_copy_mode 'on'
tmux_set @prefix_highlight_copy_mode_attr "fg=$TC,bg=$NIL,bold"
tmux_set @prefix_highlight_output_prefix "#[fg=$TC]#[bg=$NIL]$larrow#[bg=$TC]#[fg=$NIL]"
tmux_set @prefix_highlight_output_suffix "#[fg=$TC]#[bg=$NIL]$rarrow"

#     
# Left side of status bar
tmux_set status-left-bg "$NIL"
tmux_set status-left-fg "$G12"
tmux_set status-left-length 150
user=$(whoami)
LS="#[fg=$NIL,bg=$TC,bold]  ⠀"
LS="$LS#{?client_prefix,#[fg=$TC]#[bg=$TC]$rarrow #[fg=$NIL]#[bg=$TC] #S #[fg=$TC]#[bg=$G05]$rarrow,#[fg=$TC]#[bg=$G06]$rarrow #[fg=$WHITE]#[bg=$G06] #S #[fg=$G06]#[bg=$G05]$rarrow} "

if "$show_upload_speed"; then
    LS="$LS#[fg=$WHITE,bg=$G05] $upload_speed_icon #{upload_speed} #[fg=$G05,bg=$NIL]$rarrow"
else
    LS="$LS#[fg=$G06,bg=$NIL]$rarrow"
fi

tmux_set status-left "$LS"

# Right side of status bar
tmux_set status-right-bg "$NIL"
tmux_set status-right-fg "$G12"
tmux_set status-right-length 150
RS="#[fg=$G06]$larrow#[fg=$TC,bg=$G06] $time_icon $time_format #[fg=$TC,bg=$G06]$larrow#[fg=$NIL,bg=$TC] $date_format  "
if "$show_download_speed"; then
    RS="#[fg=$G05,bg=$NIL]$larrow#[fg=$TC,bg=$G05] $download_speed_icon #{download_speed} $RS"
fi
if "$show_web_reachable"; then
    RS=" #{web_reachable_status} $RS"
fi
if [[ $prefix_highlight_pos == 'R' || $prefix_highlight_pos == 'LR' ]]; then
    RS="#{prefix_highlight}$RS"
fi
tmux_set status-right "$RS"


# Window status format
tmux_set window-status-format         "#[fg=$G06,bg=default]$i_rarrow#[fg=$WHITE,bg=$G06] #I #W #[fg=$G06,bg=$NIL]$rarrow"
tmux_set window-status-current-format "#[fg=$NIL,bg=default]$i_rarrow#[fg=$G06,bg=$TC] #I #W #[fg=$TC,bg=$NIL]$rarrow"

# Window status style
tmux_set window-status-style          "fg=$TC,bg=$NIL,none"
tmux_set window-status-last-style     "fg=$TC,bg=$NIL,bold"
tmux_set window-status-activity-style "fg=$TC,bg=$NIL,bold"

# Window separator
tmux_set window-status-separator ""

# Pane border
tmux_set pane-border-style "fg=$G07,bg=default"

# Active pane border
tmux_set pane-active-border-style "fg=$TC,bg=default"

# Pane number indicator
tmux_set display-panes-colour "$G07"
tmux_set display-panes-active-colour "$TC"

# Clock mode
tmux_set clock-mode-colour "$TC"
tmux_set clock-mode-style 24

# Message
tmux_set message-style "fg=$TC,bg=$NIL"

# Command message
tmux_set message-command-style "fg=$TC,bg=$NIL"

# Copy mode highlight
tmux_set mode-style "bg=$TC,fg=$FG"
