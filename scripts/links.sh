links_setup() {
    rm -rf ~/.zshrc ~/.tmux.conf ~/.gitconfig ~/.vimrc ~/.config/nvim

    mkdir -p ~/.config/gh ~/.config/rofi ~/.config/polybar ~/.config/dunst ~/.config/kitty

    # all links are defined here
    ln -fns ~/dotfiles/tmux/.tmux.conf ~/.tmux.conf
    ln -fns ~/dotfiles/.gitconfig ~/.gitconfig
    ln -fns ~/dotfiles/.vimrc ~/.vimrc
    ln -fns ~/dotfiles/.zshrc ~/.zshrc
    ln -fns ~/dotfiles/gh/config.yml ~/.config/gh/config.yml
    ln -fns ~/dotfiles/gh/hosts.yml ~/.config/gh/hosts.yml
    ln -fns ~/dotfiles/nvim ~/.config/nvim
    ln -fns ~/dotfiles/i3/config ~/.config/i3/config
    ln -fns ~/dotfiles/i3/rofi/config.rasi ~/.config/rofi/config.rasi
    ln -fns ~/dotfiles/i3/polybar/launch.sh ~/.config/polybar/launch.sh
    ln -fns ~/dotfiles/i3/polybar/config.ini ~/.config/polybar/config.ini
    ln -fns ~/dotfiles/i3/dunstrc ~/.config/dunst/dunstrc
    ln -fns ~/dotfiles/kitty/kitty.conf ~/.config/kitty/kitty.conf
    ln -fns ~/dotfiles/kitty/current-theme.conf ~/.config/kitty/current-theme.conf
    ln -fns ~/dotfiles/starship/starship.toml ~/.config/starship.toml

    # all .sh file but the setup.sh will be turn executable here
    chmod +x "$HOME"/dotfiles/i3/polybar/launch.sh

    tmux source-file ~/.tmux.conf
    zsh -c "source ~/.zshrc"

}
