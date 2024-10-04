###########################
# REQUIRES: starship, tmux
#####

HISTFILE=~/.zsh_history
HISTSIZE=1000
SAVEHIST=2000
WORDCHARS=${WORDCHARS//\/} 
setopt hist_expire_dups_first 
setopt hist_ignore_dups      
setopt hist_ignore_space     
setopt hist_verify            
setopt correct            
setopt interactivecomments 
setopt nonomatch          
setopt notify             
setopt numericglobsort     
setopt promptsubst         


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

# enable auto-suggestions if installed
if [ -f /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh ]; then
    . /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh
    # change suggestion color
    ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=#999'
fi

source /usr/share/nvm/init-nvm.sh
export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm

# Enable vim keybinds
set -o vi
bindkey -M viins jk vi-cmd-mode

eval "$(starship init zsh)"
[ -z "$TMUX" ] && exec tmux 

# My personal aliases 
alias tks="tmux kill-session -t"
alias hubserver='cd ~/dev/hub-server'
alias hubweb='cd ~/dev/hub-web-client'
alias dotfiles='cd ~/dotfiles'
alias gobang='gobang -c ~/dev/vault/decrypted/gobang.toml'
alias xprop='xprop | grep WM_CLASS'
alias setup='~/dotfiles/setup.sh'

###### MEMENTO MORI ######
