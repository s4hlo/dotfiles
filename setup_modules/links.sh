links_setup() {
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
    ln -fns ~/dotfiles/i3/config ~/.config/i3/config

    zsh -c "source ~/.zshrc"
}
