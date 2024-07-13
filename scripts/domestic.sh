domestic_setup() {
    . ~/dotfiles/scripts/utils.sh
    install_package bpytop
    install_package taskwarrior
    install_package xournalpp
    install_package vlc
    install_package qbittorrent
    install_package spotify-client

    # sudo update-alternatives --config x-www-browser
}
