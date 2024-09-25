base_setup() {
    . ~/dotfiles/scripts/utils.sh
    # add debian source repo bacause Kali linux source repo sucks
    repo_debian="deb http://deb.debian.org/debian oldstable main non-free contrib"
    repo_ubuntu="deb http://archive.ubuntu.com/ubuntu focal-updates main"

    # Add Debian repository if it doesn't exist
    if grep -Fxq "$repo_debian" /etc/apt/sources.list; then
        echo "\033[32m[INFO]\033[0m - \033[33mREPOSITORY\033[0m - Debian repository line already exists in sources.list."
    else
        echo "$repo_debian" | sudo tee -a /etc/apt/sources.list
        echo "\033[32m[INFO]\033[0m - \033[33mREPOSITORY\033[0m - Debian repository line added."
    fi

    # Add Ubuntu repository if it doesn't exist
    if grep -Fxq "$repo_ubuntu" /etc/apt/sources.list; then
        echo "\033[32m[INFO]\033[0m - \033[33mREPOSITORY\033[0m - Ubuntu repository line already exists in sources.list."
    else
        echo "$repo_ubuntu" | sudo tee -a /etc/apt/sources.list
        echo "\033[32m[INFO]\033[0m - \033[33mREPOSITORY\033[0m - Ubuntu repository line added."
    fi 

    # ! those two apps are not required to setup 
    # but they are useful tools to help in configuration
    # xclip is necessary to enable shared clipboard but only works in x11 system
    # ! CONFIG TOOL - to check where use it, search for ocurrences using grep
    install_package xinput
    install_package gdm3
    install_package x11-utils # this provides xprop 
    install_package xdotool
    install_package xclip
    install_package tmux
    install_package fonts-noto-cjk
    install_package ripgrep # ripgrep is necessary to enable search in files using telescope
    install_package kitty
    install_package flameshot 
    install_package luajit
    install_package libmagickwand-dev
    install_package libgraphicsmagick1-dev
    install_package pulseaudio
    install_package hcxdumptool
    install_package hcxtools
    install_package luarocks

    if [ -d "$HOME/.cargo" ]; then
      echo "\e[32m[INFO]\e[0m - rust is already installed." 
    else
      curl https://sh.rustup.rs -sSf | sh
        echo "\e[32m[INFO]\e[0m - rust installation finished" 
    fi

    if [ -d "$HOME/.nvm" ]; then
      echo "\e[32m[INFO]\e[0m - nvm is already installed." 
    else
        curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash
        echo "\e[32m[INFO]\e[0m - nvm installation finished" 
    fi

    if command -v starship &> /dev/null; then
      echo "\e[32m[INFO]\e[0m - starship is already installed." 
    else
        (curl -sS https://starship.rs/install.sh | sh > /dev/null 2>&1)
        echo  "\e[32m[INFO]\e[0m - starship installation finished" 
    fi

    # this assure nvim to be installed 
    # with the latest version
    # This ensures nvim to be installed with the latest version
    if [ -d "$HOME/dotfiles/nvim-linux64" ]; then
      echo "\e[32m[INFO]\e[0m - neovim is already installed." 
    else #                                                         V
        wget https://github.com/neovim/neovim/releases/download/v0.10.0/nvim-linux64.tar.gz -P ~/Downloads
        tar xzvf ~/Downloads/nvim-linux64.tar.gz -C ~/dotfiles
        echo "\e[32m[INFO]\e[0m - neovim installation finished" 
    fi 

}
