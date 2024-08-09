font_setup() {
    if fc-list | grep -qi "JetBrains Mono"; then
        echo "\e[32m[INFO]\e[0m - jetbrains mono is already installed."
    else
        echo " ⬇️ - Downloading and installing JetBrains Mono font..."
        wget -O ~/Downloads/TempFile.zip https://download-cdn.jetbrains.com/fonts/JetBrainsMono-2.304.zip
        sudo unzip -j -o ~/Downloads/TempFile.zip '*.ttf' -d /usr/share/fonts/
        rm ~/Downloads/TempFile.zip
        
        echo " ⬇️ - Downloading and installing JetBrains Mono Nerd Font..."
        wget -O ~/Downloads/TempFile.zip https://github.com/ryanoasis/nerd-fonts/releases/download/v3.2.0/JetBrainsMono.zip
        sudo unzip -j -o ~/Downloads/TempFile.zip '*.ttf' -d /usr/share/fonts/
        rm ~/Downloads/TempFile.zip
        
        sudo fc-cache -fv

        echo "\e[32m[INFO]\e[0m - jetbrains mono installation finished"
    fi
}
