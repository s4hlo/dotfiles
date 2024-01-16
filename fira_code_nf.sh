# Font Installation
wget -O ~/Downloads/TempFile.zip https://github.com/ryanoasis/nerd-fonts/releases/download/v3.1.1/FiraCode.zip
sudo unzip -j -o ~/Downloads/TempFile.zip '*.ttf' -d /usr/share/fonts/
rm ~/Downloads/TempFile.zip
sudo fc-cache -fv

# Set NerdFont in GNOME Terminal
DEFAULT_PROFILE=$(gsettings get org.gnome.Terminal.ProfilesList default | awk -F \' '{print $2}')
gsettings set org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:${DEFAULT_PROFILE}/ font 'Fira Code 12'

# Check if FiraCode is listed in the font cache
if fc-list | grep -q "FiraCode"; then
    echo "FiraCode Nerd Font installed successfully."
else
    echo "Installation failed. Please check for errors."
fi
