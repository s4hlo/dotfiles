domestic_setup() {
    pip3 install bpytop --upgrade
    echo " ✅- BPYTOP installation finished - (1/5)"

    sudo apt install qutebrowser
    echo " ✅- QUTEBROWSER installation finished - (2/5)"

    sudo apt install vlc
    echo " ✅- VLC installation finished - (3/5)"

    sudo apt install qbittorrent
    echo " ✅- QBITTORRENT installation finished - (4/5)"

    curl -sS https://download.spotify.com/debian/pubkey_6224F9941A8AA6D1.gpg | sudo gpg --dearmor --yes -o /etc/apt/trusted.gpg.d/spotify.gpg
    echo "deb http://repository.spotify.com stable non-free" | sudo tee /etc/apt/sources.list.d/spotify.list
    sudo apt-get update && sudo apt-get install spotify-client
    echo " ✅- SPOTIFY installation finished - (5/5)"
}
