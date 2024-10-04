links_setup() {
    rm -rf ~/.zshrc ~/.tmux.conf ~/.gitconfig ~/.vimrc ~/.config/nvim

    # Create necessary directories
    CONFIG_DIRS=(gh kitty)
    for dir in "${CONFIG_DIRS[@]}"; do
        mkdir -p ~/.config/$dir
    done

  # declare -A LINKS=(
  #     [~/.tmux.conf]="~/dotfiles/tmux/.tmux.conf"
  #     [~/.gitconfig]="~/dotfiles/.gitconfig"
  #     [~/.vimrc]="~/dotfiles/.vimrc"
  #     [~/.zshrc]="~/dotfiles/.zshrc"
  #     [~/.config/gh]="~/dotfiles/gh"
  #     [~/.config/nvim]="~/dotfiles/nvim"
  #     [~/.config/kitty]="~/dotfiles/kitty"
  # )

   # for target in "${!LINKS[@]}"; do
#    ln -fns "${LINKS[$target]}" "$target"
    #done

    ln -fns ~/dotfiles/.tmux.conf ~/.tmux.conf
    ln -fns ~/dotfiles/.gitconfig ~/.gitconfig
    ln -fns ~/dotfiles/.vimrc ~/.vimrc
    ln -fns ~/dotfiles/.zshrc ~/.zshrc
    ln -fns ~/dotfiles/gh ~/.config/gh
    ln -fns ~/dotfiles/nvim ~/.config/nvim
    ln -fns ~/dotfiles/kitty ~/.config/kitty

    tmux source-file ~/.tmux.conf
    zsh -c "source ~/.zshrc"
}

