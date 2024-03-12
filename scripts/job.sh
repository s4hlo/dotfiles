job_setup() {
  if ! pritunl-client version | grep -q "Pritunl Client"; then
        sudo tee /etc/apt/sources.list.d/pritunl.list <<EOF
deb http://repo.pritunl.com/stable/apt bookworm main
EOF
        sudo apt install dirmngr
        sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com --recv 7568D9BB55FF9E5287D586017AE645C0CF8E292A
        sudo apt update
        sudo apt install pritunl-client-electron
    else
        echo "Pritunl is already installed. Skipping installation."
    fi
    echo " ✅- PRITUNL-CLIENT installation finished - (1/4)"

    sudo apt install dbeaver
    echo " ✅- DBEAVER installation finished - (2/4)"

    curl -1sLf \
        'https://packages.konghq.com/public/insomnia/setup.deb.sh' |
        sudo -E distro=ubuntu codename=focal bash
    sudo apt-get update
    sudo apt-get install insomnia
    echo " ✅- INSOMNIA installation finished - (3/4)"

    type -p curl >/dev/null || (sudo apt update && sudo apt install curl -y)
    curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg &&
        sudo chmod go+r /usr/share/keyrings/githubcli-archive-keyring.gpg &&
        echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list >/dev/null &&
        sudo apt update &&
        sudo apt install gh -y
    echo " ✅ - GITHUB-CLI installation finished (4/4)"
}
