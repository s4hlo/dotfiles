base_setup() {
    # add debian source repo bacause Kali linux source repo sucks
    repo_debian="deb http://deb.debian.org/debian oldstable main non-free contrib"
    repo_ubuntu="deb http://archive.ubuntu.com/ubuntu focal-updates main"

    # Add Debian repository if it doesn't exist
    if grep -Fxq "$repo_debian" /etc/apt/sources.list; then
        echo " 📦 - REPOSITORY - Debian repository line already exists in sources.list."
    else
        echo "$repo_debian" | sudo tee -a /etc/apt/sources.list
        echo " 📦 - REPOSITORY - Debian repository line added."
    fi

    # Add Ubuntu repository if it doesn't exist
    if grep -Fxq "$repo_ubuntu" /etc/apt/sources.list; then
        echo " 📦 - REPOSITORY - Ubuntu repository line already exists in sources.list."
    else
        echo "$repo_ubuntu" | sudo tee -a /etc/apt/sources.list
        echo " 📦 - REPOSITORY - Ubuntu repository line added."
    fi

    install_if_not_installed() {
        package=$1
        if dpkg -l | grep -q "^ii  $package "; then
            echo " ✅ - $package is already installed."
        else
            sudo apt install -y $package
            echo " ✅ - $package installation finished"
        fi
    }

    # ! those two apps are not required to setup 
    # but they are useful tools to help in configuration
    # xclip is necessary to enable shared clipboard but only works in x11 system
    # ! CONFIG TOOL - to check where use it, search for ocurrences using grep
    install_if_not_installed xinput
    install_if_not_installed x11-utils # this provides xprop 
    install_if_not_installed xdotool
    install_if_not_installed xclip
    install_if_not_installed tmux
    install_if_not_installed ripgrep # ripgrep is necessary to enable search in files using telescope
    install_if_not_installed kitty
    install_if_not_installed flameshot 

    # Install nvm if not already installed
    if [ -d "$HOME/.nvm" ]; then
        echo " ✅ - nvm is already installed."
    else
        curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash
        echo " ✅ - nvm installation finished"
    fi

    # Install starship if not already installed
    if command -v starship &> /dev/null; then
        echo " ✅ - starship is already installed."
    else
        curl -sS https://starship.rs/install.sh | sh
        echo " ✅ - starship installation finished"
    fi

    # this assure nvim to be installed 
    # with the latest version
    # This ensures nvim to be installed with the latest version
    if [ -d "$HOME/dotfiles/nvim-linux64" ]; then
        echo " ✅ - neovim is already installed." #          [Update version]
    else #                                                         V
        wget https://github.com/neovim/neovim/releases/download/v0.10.0/nvim-linux64.tar.gz -P ~/Downloads
        tar xzvf ~/Downloads/nvim-linux64.tar.gz -C ~/dotfiles
        echo " ✅ - neovim installation finished"
    fi 

    if [ ! -d ~/.tmux/plugins/tpm ]; then
        git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
        echo " ✅ - tmux plugin manager installation finished"
    else
        echo " ✅ - tmux plugin manager is already installed."
    fi

    echo " 🧰 - BASE APPS --> installation finished"
}
