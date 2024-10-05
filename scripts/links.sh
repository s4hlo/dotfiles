links_setup() {
    rm -rf ~/.zshrc ~/.tmux.conf ~/.gitconfig ~/.vimrc 
    rm -rf ~/.config/nvim ~/.config/hypr ~/.config/gh ~/.config/kitty

    # # Create necessary directories
    # CONFIG_DIRS=(gh kitty)
    # for dir in "${CONFIG_DIRS[@]}"; do
    #     mkdir -p ~/.config/$dir
    # done

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
    ln -fns ~/dotfiles/hypr ~/.config/
    ln -fns ~/dotfiles/gh ~/.config/
    ln -fns ~/dotfiles/nvim ~/.config/
    ln -fns ~/dotfiles/kitty ~/.config/
    ln -fns ~/dotfiles/waybar ~/.config/

    tmux source-file ~/.tmux.conf
    zsh -c "source ~/.zshrc"
}

