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
tmux_set @prefix_highlight_copy_mode_attr "fg=$TC,bg=$NIL,bold"
tmux_set @prefix_highlight_output_prefix "#[fg=$TC]#[bg=$NIL]$larrow#[bg=$TC]#[fg=$NIL]"
tmux_set @prefix_highlight_output_suffix "#[fg=$TC]#[bg=$NIL]$rarrow"

# ---------------------- LEFT SIDE OF STATUS BAR
color_bg="#2e323b"
color_fg="#282c34"
color_green="#98c379"
color_red="#e06c75"
color_blue="#61afef"
color_purple="#c678dd"

mode_separator=""
set -g @mode_indicator_empty_prompt " TMUX PINTO #[default]#[fg=$color_fg]$mode_separator"
set -g @mode_indicator_empty_mode_style fg=$color_purple,bold
set -g @mode_indicator_prefix_prompt " TMUX PENIS #[default]#[fg=$color_blue]$mode_separator"
set -g @mode_indicator_prefix_mode_style fg=$color_bg,bg=$color_blue,bold
set -g @mode_indicator_copy_prompt " COPY #[default]#[fg=$color_green]$mode_separator"
set -g @mode_indicator_copy_mode_style fg=$color_bg,bg=$color_green,bold
set -g @mode_indicator_sync_prompt " SYNC #[default]#[fg=$color_red]$mode_separator"
set -g @mode_indicator_sync_mode_style fg=$color_bg,bg=$color_red,bold



tmux_set status-left-bg "$NIL"
tmux_set status-left-fg "$WHITE"
tmux_set status-left-length 150
LS="#[fg=$NIL,bg=$TC,bold]  ⠀"

LS="$LS#{?client_prefix,#[fg=$TC]#[bg=$TC]$rarrow #[fg=$NIL]#[bg=$TC] #S #[fg=$TC]#[bg=$LIGHT_GREY]$rarrow,#[fg=$TC]#[bg=$DARK_GREY]$rarrow #[fg=$WHITE]#[bg=$DARK_GREY] #S #[fg=$DARK_GREY]#[bg=$LIGHT_GREY]$rarrow} "

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

RS="#[fg=$DARK_GREY]$larrow#[fg=$TC,bg=$DARK_GREY]$time_format #[fg=$TC,bg=$DARK_GREY]$larrow#[fg=$NIL,bg=$TC] ⠀  $date_format  "
if "$show_download_speed"; then
    RS="#[fg=$LIGHT_GREY,bg=$NIL]$larrow#[fg=$TC,bg=$LIGHT_GREY] $download_speed_icon #{download_speed} $RS"
fi
tmux_set status-right "$RS"


# ---------------------------WINDOW STATUS FORMAT
tmux_set window-status-format         "#[fg=$DARK_GREY,bg=default]$i_rarrow#[fg=$WHITE,bg=$DARK_GREY] #I #W #[fg=$DARK_GREY,bg=$NIL]$rarrow"
tmux_set window-status-current-format "#[fg=$NIL,bg=default]$i_rarrow#[fg=$DARK_GREY,bg=$TC] #I #W #[fg=$TC,bg=$NIL]$rarrow"


# Window status style
tmux_set window-status-style          "fg=$TC,bg=$NIL,none"
tmux_set window-status-last-style     "fg=$TC,bg=$NIL,none"
tmux_set window-status-activity-style "fg=$TC,bg=$NIL,bold"

# Pane border
tmux_set pane-border-style "fg=$DARK_GREY,bg=default"

# Active pane border
tmux_set pane-active-border-style "fg=$TC,bg=default"

# Pane number indicator
tmux_set display-panes-colour "$DARK_GREY"
tmux_set display-panes-active-colour "$TC"

# Clock mode
tmux_set clock-mode-colour "$TC"
tmux_set clock-mode-style 24

# Message
tmux_set message-style "fg=$TC,bg=$NIL"

# Command message
tmux_set message-command-style "fg=$TC,bg=$NIL"

# Copy mode highlight
tmux_set mode-style "bg=$TC,fg=$DARK_GREY"
