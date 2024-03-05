college_setup() {
    sudo curl -fL -o /etc/apt/trusted.gpg.d/zulip-desktop.asc \
        https://download.zulip.com/desktop/apt/zulip-desktop.asc
    echo "deb https://download.zulip.com/desktop/apt stable main" | \
        sudo tee /etc/apt/sources.list.d/zulip-desktop.list
    sudo apt update
    sudo apt install zulip
    echo " ✅ - ZULIP installation finished (1/1)"
}
