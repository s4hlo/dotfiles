###########################
# REQUIRES: starship, tmux
#####

# setopt autocd              # change directory just by typing its name
setopt correct            # auto correct mistakes
setopt interactivecomments # allow comments in interactive mode
setopt nonomatch           # hide error message if there is no match for the pattern
setopt notify              # report the status of background jobs immediately
setopt numericglobsort     # sort filenames numerically when it makes sense
setopt promptsubst         # enable command substitution in prompt

WORDCHARS=${WORDCHARS//\/} # Don't consider certain characters part of the word

# enable completion features
autoload -Uz compinit
compinit -d ~/.cache/zcompdump
zstyle ':completion:*:*:*:*:*' menu select
zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*' completer _expand _complete
zstyle ':completion:*' format 'Completing %d'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
zstyle ':completion:*' rehash true
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' use-compctl false
zstyle ':completion:*' verbose true
zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'

# History configurations
HISTFILE=~/.zsh_history
HISTSIZE=1000
SAVEHIST=2000
setopt hist_expire_dups_first # delete duplicates first when HISTFILE size exceeds HISTSIZE
setopt hist_ignore_dups       # ignore duplicated commands history list
setopt hist_ignore_space      # ignore commands that start with space
setopt hist_verify            # show command with history expansion to user before running it

# enable auto-suggestions if installed
if [ -f /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh ]; then
    . /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh
    # change suggestion color
    ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=#999'
fi

# enable command-not-found if installed
if [ -f /etc/zsh_command_not_found ]; then
    . /etc/zsh_command_not_found
fi

[ -f "/home/sleight/.ghcup/env" ] && source "/home/sleight/.ghcup/env" # ghcup-env

export PATH=$PATH:~/.cargo/bin/

# nvm 
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# Start Staship and tmux 
eval "$(starship init zsh)"
[ -z "$TMUX" ] && exec tmux 

# Enable vim keybinds
set -o vi
bindkey -M viins jj vi-cmd-mode

# run keyboard remaps

xmodmap ~/dotfiles/.Xmodmap

# My personal aliases 
# Improved ls alias with additional options
alias ls='ls -AFG --color=auto --group-directories-first'
alias g='git'
alias tks="tmux kill-session -t"
alias ipforward='sudo echo "1" | sudo tee /proc/sys/net/ipv4/ip_forward'
alias ssnap='sudo service snapd.apparmor start && sudo service snapd start'
alias gl='grep -lr --exclude-dir=.git'
alias fcd='cd "$(dirname "$(fzf)")"'
alias setup='~/dotfiles/setup.sh'
alias hubserver='cd ~/dev/hub-server'
alias hubweb='cd ~/dev/hub-web-client'
alias dotfiles='cd ~/dotfiles'
alias nvim='~/dotfiles/nvim-linux64/bin/nvim'
alias xprop='xprop | grep WM_CLASS'
alias taskj='task add +tarken'
alias kls='sudo logkeys -s -o ~/sleight.log -m ~/dev/logkeys/keymaps/en_US_ubuntu_1204.map'
alias klm='sudo tail --follow ~/sleight.log'
alias klk='sudo logkeys -k'
alias tar='tar –xvzf'

###### MEMENTO MORI ######
