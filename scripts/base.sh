base_setup() {
    . ~/dotfiles/scripts/utils.sh

    if ! command -v yay &> /dev/null; then
        log "yay not found. Installing..." 1
        sudo pacman -S --needed git base-devel
        git clone https://aur.archlinux.org/yay.git
        cd yay
        makepkg -si --noconfirm
        log "yay installed successfully!"
    else
        log "yay is already installed."
    fi

    sudo yay -S --needed - < ~/dotfiles/pkg_exp.list
    yay -S --needed - < ~/dotfiles/pkg_exp_aur.list

    # ! those two apps are not required to setup 
    # but they are useful tools to help in configuration
    # xclip is necessary to enable shared clipboard but only works in x11 system
    # ! CONFIG TOOL - to check where use it, search for ocurrences using grep
    # xinput
    # gdm3
    # fonts-noto-cjk
    # x11-utils # this provides xprop 
    # xdotool
    # xclip
    # ripgrep # ripgrep is necessary to enable search in files using telescope
    # kitty
    # flameshot 
    # luajit
    # libmagickwand-dev
    # libgraphicsmagick1-dev
    # pulseaudio
    # hcxdumptool
    # hcxtools
    # pulseaudio
    # libasound2-dev
    # libssl-dev
    # pkg-config
    # ------------------------------------
    # git
    # curl
    # unzip
    # tmux
    # btop
    # xournalpp
    # vlc
    # qbittorrent
    # dbeaver
    # gh
    # Insomnia
    # Pritunl
    # Discord
    # Spotify
    # Starship
    # Neovim
    # nvm
    # rust
    # luarocks

    # _______________________________________________________________________________________
    
    # TODO: check if this is over or not
    # for compatibility we must install
    # using luarocks:
    # - magick
    # using cargo: 
    # - atac
    # - yazi-fm
    # - yazi-cli
    # - gobang
    # - spotify-tui
}
