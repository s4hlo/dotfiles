###########################
# REQUIRES: starship, tmux, zsh-autosuggestions, zsh-syntax-highlighting, nvm
###########################

HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=20000
WORDCHARS=${WORDCHARS//\/} 
setopt hist_expire_dups_first 
setopt hist_ignore_dups      
setopt hist_ignore_space     
setopt share_history
setopt correct            
setopt interactivecomments 
setopt nomatch
setopt notify             
setopt numericglobsort     
setopt promptsubst
setopt auto_menu
setopt nobeep         


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
   # bindkey '^I' autosuggest-accept
   ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=#999'
fi

if [ -f /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]; then
    . /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
    ZSH_HIGHLIGHT_STYLES[command]='fg=blue,bold'
fi

source /usr/share/nvm/init-nvm.sh
[[ -d "$HOME/.cargo/bin" ]] && export PATH="$HOME/.cargo/bin:$PATH"


function y() {
    local tmp="$(mktemp -t "yazi-cwd.XXXXXX")"
    yazi "$@" --cwd-file="$tmp"
    if cwd="$(cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
        builtin cd -- "$cwd"
    fi
    rm -f -- "$tmp"
}

bindkey -e
bindkey '^P' history-beginning-search-backward
bindkey '^N' history-beginning-search-forward

eval "$(starship init zsh)"
# eval "$(atuin init zsh)"
eval "$(zoxide init zsh)"
if [ -z "$TMUX" ] && [ -z "$TERM_PROGRAM" ]; then
    exec tmux
fi


[ -f ~/dotfiles/.aliases ] && . ~/dotfiles/.aliases

###### MEMENTO MORI ######
