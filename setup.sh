## NOTES FOR S4HLO

## MAKES FLATPAK WORK AGAIN - TODO
# killall gnome-software
# rm -rf ~/.cache/gnome-software
# sudo apt-get --reinstall install -y gnome-software-plugin-flatpak
# sudo flatpak update

# Function to prompt for yes/no
ask_yes_no() {
    while true; do
        read -p "$1 (y/n): " yn
        case $yn in
        [Yy]*) return 0 ;;
        [Nn]*) return 1 ;;
        esac
    done
}

echo 'Welcome to the setup script for my dotfiles! :hearts:'
echo ' REQUIREMENTS: 
- Git
- Gnome 
- Zsh
'

if ask_yes_no "Do you want to set up GNOME configurations"; then
    repo_line="deb http://deb.debian.org/debian oldstable main non-free contrib"
    if grep -Fxq "$repo_line" /etc/apt/sources.list; then
        echo "Repository line already exists in sources.list. No changes made."
    else
        echo "$repo_line" | sudo tee -a /etc/apt/sources.list
        sudo apt update
        echo "Repository line added and package lists updated."
    fi

    gsettings set org.gnome.desktop.peripherals.touchpad tap-to-click true
    # gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-left "['<Super>j']"
    # gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-right "['<Super>k']"
    # gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-left "['<Super><Shift>J']"
    # gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-right "['<Super><Shift>K']"
    gsettings set org.gnome.desktop.wm.preferences num-workspaces 3
    gsettings set org.gnome.desktop.interface enable-animations false
    gsettings set org.gnome.shell.extensions.dash-to-dock dock-fixed false
    gsettings set org.gnome.shell.extensions.dash-to-dock intellihide false
    gsettings set org.gnome.shell.extensions.dash-to-dock autohide false
else
    echo "Skipping GNOME configuration."
fi

if ask_yes_no "Do you want to install base apps?"; then
    sudo apt update

    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | sh
    echo " ✅ - NVM installation finished (1/7)"

    curl -sS https://starship.rs/install.sh | sh
    echo " ✅ - STARSHIP installation finished (2/7)"

    sudo apt install xclip
    echo " ✅- XCLIP installation finished (3/7)"

    wget https://github.com/neovim/neovim/releases/download/v0.9.5/nvim-linux64.tar.gz -P ~/Downloads
    tar xzvf ~/Downloads/nvim-linux64.tar.gz -C ~/dotfiles
    echo " ✅ - NVIM installation finished (4/7)"

    sudo apt install tmux
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
    echo " ✅ - TMUX installation finished (5/7)"

    sudo apt install ripgrep
    echo " ✅ - RIPGREP installation finished (6/7)"

    type -p curl >/dev/null || (sudo apt update && sudo apt install curl -y)
    curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg &&
        sudo chmod go+r /usr/share/keyrings/githubcli-archive-keyring.gpg &&
        echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list >/dev/null &&
        sudo apt update &&
        sudo apt install gh -y
    echo " ✅ - GITHUB-CLI installation finished (7/7)"

else
    echo " 🟡  Skipping base apps installation"
fi

if ask_yes_no "Do you want to install domestic apps?"; then
    pip3 install bpytop --upgrade
    echo " ✅- BPYTOP installation finished - (1/5)"

    sudo apt install qutebrowser
    echo " ✅- QUTEBROWSER installation finished - (2/5)"

    sudo apt install VLC
    echo " ✅- VLC installation finished - (3/5)"

    sudo apt install qbittorrent
    echo " ✅- QBITTORRENT installation finished - (4/5)"

    curl -sS https://download.spotify.com/debian/pubkey_6224F9941A8AA6D1.gpg | sudo gpg --dearmor --yes -o /etc/apt/trusted.gpg.d/spotify.gpg
    echo "deb http://repository.spotify.com stable non-free" | sudo tee /etc/apt/sources.list.d/spotify.list
    sudo apt-get update && sudo apt-get install spotify-client
    echo " ✅- SPOTIFY installation finished - (5/5)"

else
    echo " 🟡  Skipping domestic apps installation"
fi

if ask_yes_no "Do you want to install job apps?"; then
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
    echo " ✅- PRITUNL-CLIENT installation finished - (1/3)"

    sudo apt install dbeaver
    echo " ✅- DBEAVER installation finished - (2/3)"

    curl -1sLf \
      'https://packages.konghq.com/public/insomnia/setup.deb.sh' \
      | sudo -E distro=ubuntu codename=focal bash
    sudo apt-get update
    sudo apt-get install insomnia
    echo " ✅- INSOMNIA installation finished - (3/3)"


else
    echo " 🟡  Skipping job apps installation"
fi

if ask_yes_no "Do you want to link the dotfiles?"; then
    rm -rf ~/.zshrc ~/.tmux.conf ~/.gitconfig ~/.vimrc ~/.config/nvim
    ln -fns ~/dotfiles/.tmux.conf ~/.tmux.conf
    tmux source-file ~/.tmux.conf

    ln -fns ~/dotfiles/.gitconfig ~/.gitconfig
    ln -fns ~/dotfiles/.vimrc ~/.vimrc
    ln -fns ~/dotfiles/.zshrc ~/.zshrc
    ln -fns ~/dotfiles/qutebrowser/config.py ~/.config/qutebrowser/config.py
    ln -fns ~/dotfiles/qutebrowser/onedark.py ~/.config/qutebrowser/onedark.py
    ln -fns ~/dotfiles/qutebrowser/quickmarks ~/.config/qutebrowser/quickmarks
    ln -fns ~/dotfiles/gh/config.yml ~/.config/gh/config.yml
    ln -fns ~/dotfiles/gh/hosts.yml ~/.config/gh/hosts.yml
    ln -fns ~/dotfiles/nvim ~/.config/nvim

    zsh -c "source ~/.zshrc"
else
    echo " 🟡 Skipping dotfile linking."
fi

if ask_yes_no "Do you want to download and install the Nerd Font?"; then
    wget -O ~/Downloads/TempFile.zip https://download-cdn.jetbrains.com/fonts/JetBrainsMono-2.304.zip
    sudo unzip -j -o ~/Downloads/TempFile.zip '*.ttf' -d /usr/share/fonts/
    rm ~/Downloads/TempFile.zip
    wget -O ~/Downloads/TempFile.zip https://github.com/ryanoasis/nerd-fonts/releases/download/v3.1.1/JetBrainsMono.zip
    sudo unzip -j -o ~/Downloads/TempFile.zip '*.ttf' -d /usr/share/fonts/
    rm ~/Downloads/TempFile.zip
    sudo fc-cache -fv

    # Set NerdFont in GNOME Terminal
    DEFAULT_PROFILE=$(gsettings get org.gnome.Terminal.ProfilesList default | awk -F \' '{print $2}')
    gsettings set org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:${DEFAULT_PROFILE}/ font 'JetBrainsMono Nerd Font Mono 12'
    fc-list | grep -q "JetBrainsMono"
else
    echo " 🟡 Skipping font installation."
fi

echo '
#################################################################################
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⢿⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠉⠉⠉⠉⠉⠓⢤⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠘⡄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠱⣄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
   SETUP  ⠀⠀⠀⠀⠀⠀⠀⠀⠀⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⢦⠀⠀⠀⠀⠀⠀⠀⠀⠀
   COMPLETE!   ⠀⠀⠀⠀⠀⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⡀⠀⠀⠈⢣⡀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢠⠇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢠⡀⡀⠀⠀⠀⢹⠀⠀⠀⠈⢷⡀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⡿⠀⠀⢠⠄⠀⠀⠀⠀⠀⢤⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⣧⢻⡄⠀⠀⠘⡆⠀⠀⠀⠘⣧⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⡾⠃⠀⢀⡇⠀⠀⠀⠀⠀⠀⡟⡆⠀⠀⠀⠀⠀⠀⢀⣴⠖⠀⠀⢠⠇⠀⠀⠀⠀⠀⢀⡸⣿⡇⠀⠀⠀⡇⠀⡄⠀⠀⠘⣆⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢠⡾⠁⠀⠀⢸⡇⠀⣴⠀⠀⠀⠀⣿⡏⢸⠃⠀⠀⠀⢀⣾⠁⠀⠀⠀⣾⣇⠀⠀⠀⠀⠀⠘⡇⣿⢹⠀⠀⠀⠇⠀⡇⠀⠀⠀⣿⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣴⣏⠀⠀⠀⠀⣿⠃⢰⠃⠀⠀⠀⢸⡟⡅⡏⣀⠀⠀⠀⣼⠇⠀⠀⠀⢀⣿⠸⡴⡄⠀⠀⠀⠀⢹⢹⣟⠀⠀⠀⠀⠀⡇⠀⠀⢠⠈⡇⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣴⠟⣽⠃⠀⠀⠀⣸⣿⠀⡎⠀⠀⠀⠀⣿⢳⣷⢱⣿⢀⣸⣷⢻⣴⠂⠀⠀⣸⠃⠀⢻⡹⣠⡀⠀⢦⠈⣞⣿⠀⠀⠀⠀⠀⡇⠀⠀⢸⡄⡇⠀⠀⠀⠀
⢤⣀⠀⠀⠀⠀⢀⣠⣶⢿⠑⡀⣿⠀⠀⠀⢀⡿⡇⢸⣇⡶⠀⠀⣶⣟⣸⣏⣿⡿⣾⣿⠏⣸⡿⡄⠀⢠⣿⣤⣤⣶⣧⢷⣧⣆⠘⣇⢹⣽⡀⠀⠀⠀⠀⡇⡀⠀⠈⣿⣷⠀⠀⠀⠀
⠀⠈⠉⠙⢦⡀⢸⡏⣿⡼⢸⢣⣿⠀⠀⠀⢸⣸⡇⣾⣾⠃⣰⣶⣿⠿⣿⡿⣿⢷⣿⡏⠀⣧⢷⣇⡀⢸⠏⠉⠀⠀⠈⢻⣿⣿⣦⢹⣦⢻⣧⠀⠀⣿⢠⡇⠹⡄⠀⣿⡿⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠻⣼⡇⣿⡇⣸⣸⣿⠀⠀⠀⣿⣿⣿⣿⡏⣰⣿⣿⠇⠀⡟⢡⣿⡾⡿⠀⠀⣿⣾⣿⣷⡟⠀⠀⠀⠀⠀⢀⣻⣿⣿⣿⣿⣿⣿⡇⠀⡟⢹⣷⣄⢳⡀⣿⣧⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⢻⣷⣿⣿⣿⡄⠀⢐⣿⣿⣿⣽⣿⣿⣿⣯⣤⣾⡀⠺⠿⠟⠁⠀⠀⢻⣿⣿⣿⡇⠀⣠⣴⣿⣯⣿⣶⣿⣿⣿⣉⣀⣿⡇⠀⠇⢸⡏⠁⠻⣷⢹⡇⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠘⣿⢷⡼⣿⡇⠀⠘⣿⣿⠃⣿⣿⣽⣿⣿⣾⣿⣽⣶⠀⠀⠀⠀⠀⠀⠉⠉⠉⠀⠀⣿⡿⣯⣯⣿⣿⣿⡍⠙⠛⠛⣽⡇⠀⡄⢾⡃⢠⡄⠹⣿⡇⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠸⡿⢡⣿⡇⠀⠀⡿⣿⠿⠛⠉⢡⣿⣿⣿⣿⣎⠉⠃⠀⠀⠀⠀⠀⠀⠀⠀⠀⠘⠋⠀⠻⡽⣿⣿⣿⡇⠀⠀⡒⣹⠁⠀⠀⣸⠹⠧⠚⠈⣿⠁⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⡇⢼⣿⡇⠀⠀⣿⣇⡀⠀⠀⠸⣿⣿⣿⣿⣿⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠋⠛⠿⠯⠀⠀⠀⠀⢸⠀⠀⠀⣿⣤⠒⠛⠁⣿⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⠀⠀⢿⡇⠀⠀⣿⠀⠐⠲⡤⠤⡬⡿⠿⠛⠋⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⠀⠀⡀⣺⠘⣆⢠⢰⡟⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⢷⠘⢾⡇⢀⣠⣿⢤⡄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠘⡆⠀⡃⣿⠴⠛⢈⡾⠃⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⢳⡼⠛⠋⢉⣤⠖⠻⢦⣤⣀⣀⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢠⡇⠀⡇⡿⠀⠀⡾⠃⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⡴⠋⣀⡴⠖⢹⡶⠚⠉⡽⠟⠓⠚⠉⢹⣆⠀⠀⠀⠀⠙⣦⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⡇⠀⣧⣧⣤⣾⠇⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⢀⡴⠋⠀⡾⠁⠀⠀⣸⠃⠀⠀⡇⠀⠀⢲⠀⠁⠙⣆⠀⠀⠀⠀⠈⠻⠆⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⡇⠀⢿⣿⣾⡏⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⣿⠁⠀⠀⢷⠀⠀⠀⢹⠀⠀⢰⠃⠀⠀⢸⣧⠀⠀⠘⢦⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣰⡇⠀⣿⣿⠏⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠻⣆⠀⠀⢸⡀⠀⠀⢸⠀⠀⢸⠀⠀⠀⠸⡮⠷⣄⣀⡼⢢⣀⣀⠀⠀⠀⠀⠀⠀⠀⠀⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣠⣿⡇⠀⣾⡏⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠘⢧⡀⠀⣧⠀⠀⢃⠀⠀⣞⠀⠀⠀⠰⠟⠀⠈⠙⠲⣤⣭⣍⡉⠉⠉⠉⠉⠉⠉⠉⠁⠀⠀⠀⠀⠀⠀⠀⠀⣰⣿⣽⠃⠀⣿⢷⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠙⣆⢹⠀⠀⡏⠀⢨⡁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠁⠀⠉⠙⠲⢦⣀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣠⡾⠁⢸⣾⠀⠀⣿⡄⢳⡄⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⢿⡇⠀⠀⠀⠀⠙⠲⠶⠦⣄⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠳⣄⠀⠀⠀⠀⠀⢀⣠⠾⠋⠀⠀⢸⣿⠀⢰⣿⠃⠈⣷⢤⣀⠀⠀⠀⠀⠀⠀
⠀⣀⣠⡤⠤⢶⣦⣤⣤⡤⣄⣀⡀⢿⣄⠙⠛⠓⠒⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⢧⠀⠀⣀⡴⠛⠁⠀⠀⠀⠀⠀⣿⠃⢸⠇⠀⠀⢸⠀⠈⢷⡤⣄⡀⠀⠀
⠉⠙⠢⠤⠔⠉⠁⠈⠉⠉⠒⠺⠯⠽⣯⠙⣷⣶⢦⣄⣀⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⡶⠞⠉⠀⠀⠀⠀⠀⠀⠀⠀⡿⠀⣾⠀⠀⠀⢸⠀⠀⠀⠹⣄⠙⠓⢤
⠀⠀⠀⠀⠀⠀⠀⠶⣄⠀⠀⠀⠀⠀⣿⡇⢹⣿⠈⣯⡏⠉⠓⠢⣤⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢠⡇⠀⠀⠀⠀⠀⠀⠀⠀⢀⣴⣿⠀⡟⠀⠀⠀⢸⡖⠒⠦⣄⠈⠙⢦⡀
⠀⠀⠀⠀⠀⠀⠀⠀⠈⢣⡀⠀⠀⠀⢸⣵⠀⣿⡄⠘⢿⠀⠀⠀⠀⠉⠑⢶⣄⣀⠀⠀⠀⠀⠀⠀⠀⠀⣸⠀⠀⠀⠀⠀⠀⠀⢀⣰⠟⢹⣼⢰⠇⠀⠀⠀⢸⣷⡀⠀⠈⠓⢦⡀⠈
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠑⣄⠀⠱⡀⣿⡇⣻⣹⡀⢸⡀⠀⠀⠀⠀⠀⠀⡇⠈⠉⠛⠿⠿⠤⠴⠂⠀⣾⠀⠀⠀⠀⠀⣠⠔⠋⠁⠀⣸⡿⣸⠀⠀⠀⠀⢸⢿⡇⠀⠀⠀⠀⠉⢀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠘⣆⠀⢻⣹⣿⣹⣧⡇⠀⢧⡀⠀⠀⠀⠀⢸⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⣏⠀⣀⡤⠖⠋⡀⠀⠀⠀⣀⣿⣿⡏⠀⠀⠀⢀⡞⠘⡇⠀⠀⠠⣀⠀⠀
#################################################################################
'
