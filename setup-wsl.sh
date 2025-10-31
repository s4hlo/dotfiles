#!/bin/bash
echo -e "\e[34m> WSL Setup Script\e[0m"
cd ~/dotfiles || exit 1

log() {
    local content=$1
    local type=${2:-0}
    local colors=("\e[32m" "\e[33m" "\e[31m" "\e[31m")
    local labels=("[INFO]" "[WARN]" "[ERROR]" "[EXIT]")

    echo -e "${colors[$type]}${labels[$type]}\e[0m - $content"
}

log "Installing WSL packages..." 0
sudo apt update && sudo apt install -y $(cat ~/dotfiles/wsl.list)
snap install atuin
snap install yazi
log "WSL packages installed!" 0

log "Creating WSL symlinks..." 0

rm -rf -- ~/.bashrc && ln -sfn ~/dotfiles/.bashrc ~/.bashrc
rm -rf -- ~/.gitconfig && ln -sfn ~/dotfiles/.gitconfig ~/.gitconfig
rm -rf -- ~/.tmux.conf && ln -sfn ~/dotfiles/.tmux.conf ~/.tmux.conf
rm -rf -- ~/.zshrc && ln -sfn ~/dotfiles/.zshrc ~/.zshrc
rm -rf -- ~/.config/bat && ln -sfn ~/dotfiles/bat ~/.config/bat
rm -rf -- ~/.config/btop && ln -sfn ~/dotfiles/btop ~/.config/btop
rm -rf -- ~/.config/gh && ln -sfn ~/dotfiles/gh ~/.config/gh

source ~/.bashrc
sudo timedatectl set-timezone Etc/GMT-3
tmux source-file ~/.tmux.conf

log "WSL setup completed!" 0
