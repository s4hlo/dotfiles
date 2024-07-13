font_setup() {
    if fc-list | grep -qi "JetBrains Mono"; then
        echo " ✅ - JetBrains Mono font is already installed."
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
        echo " ✅ - JetBrains Mono font installation finished."
    fi
}
