font_setup() {
    wget -O ~/Downloads/TempFile.zip https://download-cdn.jetbrains.com/fonts/JetBrainsMono-2.304.zip
    sudo unzip -j -o ~/Downloads/TempFile.zip '*.ttf' -d /usr/share/fonts/
    rm ~/Downloads/TempFile.zip
    wget -O ~/Downloads/TempFile.zip https://github.com/ryanoasis/nerd-fonts/releases/download/v3.1.1/JetBrainsMono.zip
    sudo unzip -j -o ~/Downloads/TempFile.zip '*.ttf' -d /usr/share/fonts/
    rm ~/Downloads/TempFile.zip
    sudo fc-cache -fv

    fc-list | grep -q "JetBrainsMono"
}
