base_setup() {
    # add debian source repo bacause Kali linux source repo sucks
    repo_debian="deb http://deb.debian.org/debian oldstable main non-free contrib"
    repo_ubuntu="deb http://archive.ubuntu.com/ubuntu focal-updates main"

    # Add Debian repository if it doesn't exist
    if grep -Fxq "$repo_debian" /etc/apt/sources.list; then
        echo "Debian repository line already exists in sources.list. No changes made."
    else
        echo "$repo_debian" | sudo tee -a /etc/apt/sources.list
        echo "Debian repository line added."
    fi

    # Add Ubuntu repository if it doesn't exist
    if grep -Fxq "$repo_ubuntu" /etc/apt/sources.list; then
        echo "Ubuntu repository line already exists in sources.list. No changes made."
    else
        echo "$repo_ubuntu" | sudo tee -a /etc/apt/sources.list
        echo "Ubuntu repository line added."
    fi

    sudo apt update

    # ! those two apps are not required to setup 
    # but they are useful tools to help in configuration
    # ! CONFIG TOOL - to check where use it, search for ocurrences using grep
    sudo apt install xinput
    sudo apt install xprop
    sudo apt install xdotool
    echo " ✅- TOOLS --> XINPUT, XPROP, XDOTOOL installation finished"

    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash
    echo " ✅ - NVM installation finished (1/7)"

    sudo apt install kitty
    echo " ✅ - KITTY installation finished (2/7)"

    curl -sS https://starship.rs/install.sh | sh
    echo " ✅ - STARSHIP installation finished (3/7)"

    # xclip is necessary to enable shared clipboard but only works in x11 system
    # ! CONFIG TOOL - to check where use it, search for ocurrences using grep
    sudo apt install xclip
    echo " ✅- XCLIP installation finished (4/7)"

    # this assure nvim to be installed 
    # with the latest version                           [update version]
    # TODO add a path to nvim                                  V
    wget https://github.com/neovim/neovim/releases/download/v0.10.0/nvim-linux64.tar.gz -P ~/Downloads
    tar xzvf ~/Downloads/nvim-linux64.tar.gz -C ~/dotfiles
    echo " ✅ - NVIM installation finished (5/7)"

    sudo apt install tmux
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
    echo " ✅ - TMUX installation finished (6/7)"

    # ripgrep is necessary to enable search in files using telescope
    sudo apt install ripgrep
    echo " ✅ - RIPGREP installation finished (7/7)"

}
