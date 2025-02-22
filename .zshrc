###########################
# REQUIRES: starship, tmux, zsh-autosuggestions, zsh-syntax-highlighting, nvm
###########################

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


autoload -Uz compinit
compinit -d ~/.cache/zcompdump
zstyle ':completion:*:*:*:*:*' menu select
zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*' completer _expand _complete
zstyle ':completion:*' format 'Completing %d'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
zstyle ':completion:*' rehash true
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' use-compctl false

if [ -f /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh ]; then
   . /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
   ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=#999'
fi

if [ -f /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]; then
    . /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
    ZSH_HIGHLIGHT_STYLES[command]='fg=blue,bold'
fi

source /usr/share/nvm/init-nvm.sh
export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

function y() {
    local tmp="$(mktemp -t "yazi-cwd.XXXXXX")"
    yazi "$@" --cwd-file="$tmp"
    if cwd="$(cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
        builtin cd -- "$cwd"
    fi
    rm -f -- "$tmp"
}

set -o vi
bindkey -M viins jk vi-cmd-mode

eval "$(starship init zsh)"
[ -z "$TMUX" ] && exec tmux

alias tks="tmux kill-session -t"
alias hs='cd ~/dev/hub-server'
alias hw='cd ~/dev/hub-web-client'
alias df='cd ~/dotfiles'
alias gobang='gobang -c ~/dev/vault/decrypted/gobang.toml'
alias setup='~/dotfiles/setup.sh'

###### MEMENTO MORI ######

