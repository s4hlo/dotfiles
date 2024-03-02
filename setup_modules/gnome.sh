gnome_setup() {
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
}
