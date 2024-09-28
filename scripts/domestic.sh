domestic_setup() {
    . ~/dotfiles/scripts/utils.sh
    install_package btop
    install_package xournalpp
    install_package vlc
    install_package qbittorrent

     # this is necessary for installing in Debian-based Linux only
    log "Please run the following commands manually before installing Spotify" 1
    echo " "
    echo "\e[36mcurl -sS https://download.spotify.com/debian/pubkey_6224F9941A8AA6D1.gpg | sudo gpg --dearmor --yes -o /etc/apt/trusted.gpg.d/spotify.gpg\e[0m"
    echo "\e[36mecho \"deb http://repository.spotify.com stable non-free\" | sudo tee /etc/apt/sources.list.d/spotify.list\e[0m"
    echo " "
    install_package spotify-client

    # sudo update-alternatives --config x-www-browser
}
