job_setup() {
    # This config is very volatile
    . ~/dotfiles/scripts/utils.sh
    
    install_package dbeaver
    install_package insomnia
    install_package gh

    if dpkg -l | grep -q "^ii pritunl-client "; then
        sudo tee /etc/apt/sources.list.d/pritunl.list <<EOF
deb http://repo.pritunl.com/stable/apt bookworm main
EOF
        sudo apt install -y dirmngr
        sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com --recv 7568D9BB55FF9E5287D586017AE645C0CF8E292A
        sudo apt update
        sudo apt install -y pritunl-client-electron
        echo " ✅ - Pritunl Client installation finished"
    else
        echo " ✅ - Pritunl Client is already installed"
    fi
}
