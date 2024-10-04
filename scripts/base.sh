base_setup() {
    . ~/dotfiles/scripts/utils.sh
    # ! those two apps are not required to setup 
    # but they are useful tools to help in configuration
    # xclip is necessary to enable shared clipboard but only works in x11 system
    # ! CONFIG TOOL - to check where use it, search for ocurrences using grep
    install_package xinput
    install_package curl
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
    install_package pulseaudio
    install_package libasound2-dev
    install_package libssl-dev
    install_package pkg-config
    # domestic
    install_package btop
    install_package xournalpp
    install_package vlc
    install_package qbittorrent
    # job
    install_package dbeaver
    install_package gh
    log "\e[33mSome apps must be installed direct via .deb in the official sources:\e[0m"
    echo " "
    echo "\e[36m - Insomnia\e[0m"
    echo "\e[36m - Pritunl\e[0m"
    echo "\e[36m - Discord\e[0m"
    echo "\e[36m - Spotify\e[0m"
    echo "\e[36m - Starship\e[0m"
    echo "\e[36m - Neovim\e[0m"
    echo "\e[36m - nvm\e[0m"
    echo "\e[36m - rust\e[0m"
    echo " "

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
