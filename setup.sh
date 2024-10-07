echo -e "\e[34mWelcome to the setup script for my dotfiles!\e[0m"
echo -e "\e[34m--------------------------------------------\e[0m"
echo -e ''

echo -e ''
echo -e '\e[35m                     .                  \e[32m REQUIREMENTS:\e[0m'
echo -e '\e[35m                    / V\\                 \e[32m- Git\e[0m'
echo -e '\e[35m                  / `  /                 \e[32m- Zsh\e[0m'
echo -e '\e[35m                 <<   |                 \e[32m\e[0m'
echo -e '\e[35m                 /    |                 \e[32m FOLLOW THE INSTRUCTIONS\e[0m'
echo -e '\e[35m               /      |                 \e[32m FOR SETUP!\e[0m'
echo -e '\e[35m             /        |\e[0m'
echo -e '\e[35m           /    \  \ / \e[0m'
echo -e '\e[35m          (      ) | |\e[0m'
echo -e '\e[35m  ________|   _/_  | |\e[0m'
echo -e '\e[35m<__________\\______)\__)\e[0m'
echo -e "\e[34m--------------------------------------------\e[0m"

# Pritunl

log() {
    local content=$1
    local type=${2:-0}
    local colors=( "\e[32m" "\e[33m" "\e[31m" "\e[31m" )
    local labels=( "[INFO]" "[WARN]" "[ERROR]" "[EXIT]" )

    echo -e "${colors[$type]}${labels[$type]}\e[0m - $content"
}

ask_and_execute() {
    local prompt_message=$1
    local setup_function=$2

    while true; do
        read -p "$(echo -e "\e[34m$prompt_message?\e[0m (y/n/q): ")" yn
        case ${yn,,} in
            y*) $setup_function; return 0 ;;
            n*) log "Skipping" 1; return 1 ;;
            q*) log "Exiting the program." 3; exit 0 ;;
            *) log "Invalid input, please enter y, n, or q." 2 ;;
        esac
    done
}

pacman_bulk() {
    sudo pacman -S --needed - < ~/dotfiles/pkg_exp.list
}

yay_bulk() {

    if ! command -v yay &> /dev/null; then
        log "yay not found. Installing..." 1
        sudo pacman -S --needed git base-devel
        git clone https://aur.archlinux.org/yay.git
        cd yay
        makepkg -si --noconfirm
        log "yay installed successfully!"
    else
        log "yay is already installed."
    fi

    yay -S --needed - < ~/dotfiles/pkg_exp_aur.list
}

links_setup() {
    rm -rf ~/.zshrc ~/.tmux.conf ~/.gitconfig ~/.vimrc 
    rm -rf ~/.config/nvim ~/.config/hypr ~/.config/gh ~/.config/kitty

    ln -fns ~/dotfiles/.tmux.conf ~/.tmux.conf
    ln -fns ~/dotfiles/.gitconfig ~/.gitconfig
    ln -fns ~/dotfiles/.vimrc ~/.vimrc
    ln -fns ~/dotfiles/.zshrc ~/.zshrc
    ln -fns ~/dotfiles/hypr ~/.config/
    ln -fns ~/dotfiles/gh ~/.config/
    ln -fns ~/dotfiles/nvim ~/.config/
    ln -fns ~/dotfiles/kitty ~/.config/
    ln -fns ~/dotfiles/waybar ~/.config/
    ln -fns ~/dotfiles/wofi ~/.config/
    ln -fns ~/dotfiles/spicetify ~/.config/spicetify/Themes/Tokyo

    # Definir o Zsh como o shell padrão
    if [ "$SHELL" != "/bin/zsh" ]; then
        chsh -s $(which zsh)
    fi

    tmux source-file ~/.tmux.conf
    zsh -c "source ~/.zshrc"
}


ask_and_execute "Do you want to sync pacman packages" "pacman_bulk"
ask_and_execute "Do you want to sync yay packages" "yay_bulk"
ask_and_execute "Do you want to link the dotfiles" "links_setup"

echo -e '
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
