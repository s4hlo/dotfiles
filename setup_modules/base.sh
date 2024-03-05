base_setup() {
    sudo apt update

    # ! those two apps are not required to setup 
    # but they are useful tools to help in configuration
    # ! CONFIG TOOL - to check where use it, search for ocurrences using grep
    sudo apt install xinput
    sudo apt install xprop
    echo " ✅- TOOLS --> XINPUT and XPROP installation finished"

    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | sh
    echo " ✅ - NVM installation finished (1/6)"

    curl -sS https://starship.rs/install.sh | sh
    echo " ✅ - STARSHIP installation finished (2/6)"

    # xclip is necessary to enable shared clipboard but only works in x11 system
    # ! CONFIG TOOL - to check where use it, search for ocurrences using grep
    sudo apt install xclip
    echo " ✅- XCLIP installation finished (3/6)"

    # this assure nvim to be installed with the latest version
    # TODO add a path to nvim
    wget https://github.com/neovim/neovim/releases/download/v0.9.5/nvim-linux64.tar.gz -P ~/Downloads
    tar xzvf ~/Downloads/nvim-linux64.tar.gz -C ~/dotfiles
    echo " ✅ - NVIM installation finished (4/6)"

    sudo apt install tmux
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
    echo " ✅ - TMUX installation finished (5/6)"

    # ripgrep is necessary to enable search in files using telescope
    sudo apt install ripgrep
    echo " ✅ - RIPGREP installation finished (6/6)"
}
