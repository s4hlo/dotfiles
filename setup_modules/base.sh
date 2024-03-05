base_setup() {
    sudo apt update

    # ! those two apps are not required to setup 
    # but they are useful tools to help in configuration
    # ! CONFIG TOOL - to check where use it, search for ocurrences using grep
    sudo apt install xinput
    sudo apt install xprop
    echo " ✅- TOOLS --> XINPUT and XPROP installation finished"

    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | sh
    echo " ✅ - NVM installation finished (1/7)"

    curl -sS https://starship.rs/install.sh | sh
    echo " ✅ - STARSHIP installation finished (2/7)"

    # ! xclip is necessary to enable shared clipboard but only works in x11 system
    # ! CONFIG TOOL - to check where use it, search for ocurrences using grep
    sudo apt install xclip
    echo " ✅- XCLIP installation finished (3/7)"

    wget https://github.com/neovim/neovim/releases/download/v0.9.5/nvim-linux64.tar.gz -P ~/Downloads
    tar xzvf ~/Downloads/nvim-linux64.tar.gz -C ~/dotfiles
    echo " ✅ - NVIM installation finished (4/7)"

    sudo apt install tmux
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
    echo " ✅ - TMUX installation finished (5/7)"

    sudo apt install ripgrep
    echo " ✅ - RIPGREP installation finished (6/7)"

    type -p curl >/dev/null || (sudo apt update && sudo apt install curl -y)
    curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg &&
        sudo chmod go+r /usr/share/keyrings/githubcli-archive-keyring.gpg &&
        echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list >/dev/null &&
        sudo apt update &&
        sudo apt install gh -y
    echo " ✅ - GITHUB-CLI installation finished (7/7)"
}
