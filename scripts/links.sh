links_setup() {
    rm -rf ~/.zshrc ~/.tmux.conf ~/.gitconfig ~/.vimrc ~/.config/nvim

    # all links are defined here
    ln -fns ~/dotfiles/.tmux.conf ~/.tmux.conf
    ln -fns ~/dotfiles/.gitconfig ~/.gitconfig
    ln -fns ~/dotfiles/.vimrc ~/.vimrc
    ln -fns ~/dotfiles/.zshrc ~/.zshrc
    ln -fns ~/dotfiles/qutebrowser/config.py ~/.config/qutebrowser/config.py
    ln -fns ~/dotfiles/qutebrowser/onedark.py ~/.config/qutebrowser/onedark.py
    ln -fns ~/dotfiles/qutebrowser/quickmarks ~/.config/qutebrowser/quickmarks
    ln -fns ~/dotfiles/gh/config.yml ~/.config/gh/config.yml
    ln -fns ~/dotfiles/gh/hosts.yml ~/.config/gh/hosts.yml
    ln -fns ~/dotfiles/nvim ~/.config/nvim
    ln -fns ~/dotfiles/i3/config ~/.config/i3/config
    ln -fns ~/dotfiles/i3/rofi/config.rasi ~/.config/rofi/config.rasi
    ln -fns ~/dotfiles/i3/polybar/launch.sh ~/.config/polybar/launch.sh
    ln -fns ~/dotfiles/i3/polybar/config.ini ~/.config/polybar/config.ini
    ln -fns ~/dotfiles/kitty/kitty.conf ~/.config/kitty/kitty.conf
    ln -fns ~/dotfiles/kitty/current-theme.conf ~/.config/kitty/current-theme.conf

    tmux source-file ~/.tmux.conf
    zsh -c "source ~/.zshrc"

    # all .sh file but the setup.sh will be turn executable here
    chmod +x $HOME/dotfiles/i3/polybar/launch.sh
}
