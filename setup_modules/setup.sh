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
    . ~/dotfiles/setup_modules/gnome.sh
    gnome_setup
else
    echo "Skipping GNOME configuration."
fi

if ask_yes_no "Do you want to install base apps?"; then
    . ~/dotfiles/setup_modules/base.sh
    base_setup

else
    echo " 🟡  Skipping base apps installation"
fi

if ask_yes_no "Do you want to install domestic apps?"; then
    . ~/dotfiles/setup_modules/domestic.sh
    domestic_setup
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
        'https://packages.konghq.com/public/insomnia/setup.deb.sh' |
        sudo -E distro=ubuntu codename=focal bash
    sudo apt-get update
    sudo apt-get install insomnia
    echo " ✅- INSOMNIA installation finished - (3/3)"

else
    echo " 🟡  Skipping job apps installation"
fi

if ask_yes_no "Do you want to install college apps?"; then
    . ~/dotfiles/setup_modules/college.sh
    college_setup
else
    echo " 🟡  Skipping job apps installation"
fi

if ask_yes_no "Do you want to link the dotfiles?"; then
  . ~/dotfiles/setup_modules/links.sh
  links_setup
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
