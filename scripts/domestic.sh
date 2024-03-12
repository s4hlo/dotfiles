domestic_setup() {
    sudo apt install bpytop
    echo " ✅- BPYTOP installation finished - (1/6)"

    sudo apt install taskwarrior
    echo " ✅- BPYTOP installation finished - (2/6)"

    # this also add the option to make qutebrowser
    # default browser
    sudo apt install qutebrowser
    sudo update-alternatives --config x-www-browser
    echo " ✅- QUTEBROWSER installation finished - (3/6)"

    sudo apt install vlc
    echo " ✅- VLC installation finished - (4/6)"

    sudo apt install qbittorrent
    echo " ✅- QBITTORRENT installation finished - (5/6)"

    curl -sS https://download.spotify.com/debian/pubkey_6224F9941A8AA6D1.gpg | sudo gpg --dearmor --yes -o /etc/apt/trusted.gpg.d/spotify.gpg
    echo "deb http://repository.spotify.com stable non-free" | sudo tee /etc/apt/sources.list.d/spotify.list
    sudo apt-get update && sudo apt-get install spotify-client
    echo " ✅- SPOTIFY installation finished - (6/6)"
}
