#!/bin/bash
# Shared helpers for setup.sh and swsl.sh (sourced, not executed)

log() {
    local content=$1
    local type=${2:-0}
    local colors=("\e[32m" "\e[33m" "\e[31m" "\e[31m")
    local labels=("[INFO]" "[WARN]" "[ERROR]" "[EXIT]")
    echo -e "${colors[$type]}${labels[$type]}\e[0m - $content"
}

# link SRC DST: point DST at SRC. An existing symlink is replaced; a real
# file/dir is moved to DST.bak.<timestamp> instead of being deleted.
link() {
    local src=$1 dst=$2
    mkdir -p "$(dirname "$dst")"
    if [ -e "$dst" ] && [ ! -L "$dst" ]; then
        local bak
        bak="$dst.bak.$(date +%Y%m%d%H%M%S)"
        mv -- "$dst" "$bak"
        log "Backed up $dst -> $bak" 1
    fi
    ln -sfn -- "$src" "$dst"
}

# Links shared by every platform; each setup script adds its own on top
link_common() {
    local d=~/dotfiles
    link "$d/.bashrc" ~/.bashrc
    link "$d/.tmux.conf" ~/.tmux.conf
    link "$d/.zshrc" ~/.zshrc
    link "$d/bat" ~/.config/bat
    link "$d/btop" ~/.config/btop
    link "$d/gh" ~/.config/gh
    link "$d/nvim" ~/.config/nvim
}
