#!/bin/bash
set -euo pipefail

echo -e "\e[34m> WSL Setup Script\e[0m"
cd ~/dotfiles
. ~/dotfiles/scripts/lib.sh

log "Installing WSL packages..." 0
sudo apt update && sudo apt install -y $(cat ~/dotfiles/wsl.list)
sudo snap install yazi --classic
sudo snap install aws-cli --classic

# WSL's login session ends right after boot; without linger systemd stops user@1000
# ~10s later, removing /run/user/1000 (breaks snaps) and killing tmux (WSL shuts down)
sudo loginctl enable-linger "$USER"

export NVM_DIR="$HOME/.nvm"

# nvm.sh is not `set -u` safe
load_nvm() {
    set +u
    . "$NVM_DIR/nvm.sh"
    set -u
}

if command -v starship >/dev/null 2>&1; then
    echo "Starship $(starship --version)"
else
    curl -sS https://starship.rs/install.sh | sh
fi

if [ ! -s "$NVM_DIR/nvm.sh" ]; then
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.3/install.sh | bash
fi
load_nvm
echo "nvm $(nvm --version)"

# nvim from the official tarball: the snap adds ~100ms (squashfs mount + confinement) to every launch
if [ -x ~/.local/opt/nvim/bin/nvim ]; then
    ~/.local/opt/nvim/bin/nvim --version | head -1
else
    mkdir -p ~/.local/opt ~/.local/bin
    rm -rf ~/.local/opt/nvim
    curl -fsSL https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.tar.gz |
        tar -xz -C ~/.local/opt && mv ~/.local/opt/nvim-linux-x86_64 ~/.local/opt/nvim
    ln -sfn ~/.local/opt/nvim/bin/nvim ~/.local/bin/nvim
fi
if snap list nvim >/dev/null 2>&1; then
    sudo snap remove nvim
fi

# nvim-treesitter needs tree-sitter-cli >= 0.26.1 (apt is older, npm unsupported)
if command -v tree-sitter >/dev/null 2>&1; then
    echo "tree-sitter $(tree-sitter --version)"
else
    mkdir -p ~/.local/bin
    curl -fsSL https://github.com/tree-sitter/tree-sitter/releases/latest/download/tree-sitter-linux-x64.gz |
        gunzip >~/.local/bin/tree-sitter && chmod +x ~/.local/bin/tree-sitter
fi

log "WSL packages installed!" 0
log "Creating WSL symlinks..." 0
link_common
rm -rf -- ~/.gitconfig && cp ~/dotfiles/.gitconfig ~/.gitconfig
log "WSL symlinks created successfully!" 0

log "Start execution setup" 0
set +u
nvm install --lts
nvm alias default 'lts/*'
set -u

sudo timedatectl set-timezone Etc/GMT-3
tmux source-file ~/.tmux.conf 2>/dev/null || true
log "WSL setup completed!" 0

log "RUN gpg --full-generate-key TO GERANEATE A KEY FOR SIGN COMMITS"
log "RUN gpg --list-secret-keys --keyid-format=long TO SEE GENERATED KEYS"
log "RUN git config --global user.signingkey <id after / in line starting with sec>"
log "RUN gpg --armor --export SEU_KEY_ID AND ADD IN GITHUB"
log "RUN gh auth login -h github.com -p https -w TO LOGIN ON GITHUB (git push uses gh credentials)"
log "RUN source ~/.bashrc IF ANYTHING DONT WORK"
