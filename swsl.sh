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
sudo snap install nvim --classic
sudo snap install yazi --classic

if command -v starship >/dev/null 2>&1; then
    echo "Starship $(starship --version)"
else
    curl -sS https://starship.rs/install.sh | sh
fi

export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"

if [ -s "$NVM_DIR/nvm.sh" ]; then
    . "$NVM_DIR/nvm.sh"
fi




if command -v nvm >/dev/null 2>&1; then
    echo "nvm $(nvm --version)"
else
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.3/install.sh | bash
fi

if command -v cursor-agent >/dev/null 2>&1; then
    echo "cursor-agent $(cursor-agent --version)"
else
    curl https://cursor.com/install -fsS | bash
fi

if command -v gemini >/dev/null 2>&1; then
    echo "gemini $(gemini --version)"
else
    npm install -g @google/gemini-cli
fi

log "WSL packages installed!" 0

log "Creating WSL symlinks..." 0

mkdir -p ~/.config

rm -rf -- ~/.bashrc && ln -sfn ~/dotfiles/.bashrc ~/.bashrc
rm -rf -- ~/.gitconfig && ln -sfn ~/dotfiles/.gitconfig ~/.gitconfig
rm -rf -- ~/.tmux.conf && ln -sfn ~/dotfiles/.tmux.conf ~/.tmux.conf
rm -rf -- ~/.zshrc && ln -sfn ~/dotfiles/.zshrc ~/.zshrc

rm -rf -- ~/.config/bat && ln -sfn ~/dotfiles/bat ~/.config/bat
rm -rf -- ~/.config/btop && ln -sfn ~/dotfiles/btop ~/.config/btop
rm -rf -- ~/.config/gh && ln -sfn ~/dotfiles/gh ~/.config/gh
rm -rf -- ~/.config/vim && ln -sfn ~/dotfiles/nvim ~/.config/nvim

log "WSL symlinks created successfully!" 0


source ~/.bashrc
nvm install --lts
nvm use --lts
sudo timedatectl set-timezone Etc/GMT-3
tmux source-file ~/.tmux.conf

log "WSL setup completed!" 0

log "RUN source ~/.bashrc IF ANYTHING DONT WORK"
