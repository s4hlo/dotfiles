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

# GNOME settings
gsettings set org.gnome.desktop.peripherals.touchpad tap-to-click true
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-left "['<Super>j']"
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-right "['<Super>k']"
gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-left "['<Super><Shift>J']"
gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-right "['<Super><Shift>K']"
gsettings set org.gnome.desktop.wm.preferences num-workspaces 3
gsettings set org.gnome.desktop.interface enable-animations false

# Linking dotfiles
rm ~/.tmux.conf
ln -s ~/.tmux.conf .tmux.conf
rm ~/.gitconfig
ln -s ~/.gitconfig .gitconfig
rm ~/.vimrc
ln -s ~/.vimrc .vimrc

# Prompt to download the font
if ask_yes_no "Do you want to download and install the Fira Code Nerd Font?"; then
    # Install Fira Code Nerd Font
    wget -O ~/Downloads/TempFile.zip https://github.com/ryanoasis/nerd-fonts/releases/download/v3.1.1/FiraCode.zip
    sudo unzip -j -o ~/Downloads/TempFile.zip '*.ttf' -d /usr/share/fonts/
    rm ~/Downloads/TempFile.zip
    sudo fc-cache -fv

    # Set NerdFont in GNOME Terminal
    DEFAULT_PROFILE=$(gsettings get org.gnome.Terminal.ProfilesList default | awk -F \' '{print $2}')
    gsettings set org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:${DEFAULT_PROFILE}/ font 'Fira Code 12'
    fc-list | grep -q "FiraCode"
else
    echo "Skipping font installation."
fi

# Additional commands if needed
