###########################
# REQUIRES: starship, tmux
#####

# Start Staship and tmux 
eval "$(starship init zsh)"
[ -z "$TMUX" ] && exec tmux 

# Enable vim keybinds
set -o vi

# My personal aliases 
alias tks="tmux kill-session -t"
alias ipforward='sudo echo "1" | sudo tee /proc/sys/net/ipv4/ip_forward'

#####
# END
###########################