echo -e "\e[34mWelcome to the setup script for my dotfiles!\e[0m"
if command -v catnap &> /dev/null; then
    catnap
else
    echo -e "\e[34mWelcome to the setup script for my dotfiles!\e[0m"
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
    echo -e " "
fi


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

ask_for_wm_installation() {
    local prompt_message="Choose Window Manager to install:"
    while true; do
        read -p "$(echo -e "\e[34m$prompt_message\e[0m \n1) Hypr\n2) i3\n3) skip \n")" choice
        case $choice in
            1)
                log "Installing Hypr... " 1
                sudo pacman -S --needed hyprland xdg-desktop-portal-hyprland
                yay -S --needed \
                      hyprpaper \
                      waybar \
                      hyprshade \
                      hyprshot \
                      wofi 
                      # check if those two are installed with the above when zero setup
                      # hyprlock 
                      # hyprpicker-git \
                [ -d ~/.config/hypr ] && [ ! -L ~/.config/hypr ] && rm -rf ~/.config/hypr
                ln -fns ~/dotfiles/hypr ~/.config/
                [ -d ~/.config/waybar ] && [ ! -L ~/.config/waybar ] && rm -rf ~/.config/waybar
                ln -fns ~/dotfiles/waybar ~/.config/
                [ -d ~/.config/wofi ] && [ ! -L ~/.config/wofi ] && rm -rf ~/.config/wofi
                ln -fns ~/dotfiles/wofi ~/.config/
                log "Hypr installed successfully!" 0
                return 0
                ;;
            2)
                log "Installing i3..." 1
                sudo pacman -S --needed - < ~/dotfiles/pkg_i3.list
                mkdir -p ~/.config/i3 ~/.config/rofi ~/.config/polybar
                ln -fns ~/dotfiles/i3/config ~/.config/i3/config
                ln -fns ~/dotfiles/i3/rofi/config.rasi ~/.config/rofi/config.rasi
                ln -fns ~/dotfiles/i3/polybar/launch.sh ~/.config/polybar/launch.sh
                ln -fns ~/dotfiles/i3/polybar/config.ini ~/.config/polybar/config.ini
                log "i3 installed successfully!" 0
                return 0
                ;;
            3)log "Skipping" 1; return 1 ;;
            *) log "Invalid input, please enter 1, 2, or 3." 2 ;;
        esac
    done
}

pacman_bulk() {
    sudo pacman -S --needed - < ~/dotfiles/pkg.list
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

    yay -S --needed - < ~/dotfiles/pkg_aur.list
}

links_setup() {
    rm -rf ~/.zshrc ~/.tmux.conf ~/.gitconfig ~/.vimrc 
    rm -rf ~/.config/nvim ~/.config/gh ~/.config/kitty ~/.config/btop ~/.config/bat

    ln -fns ~/dotfiles/cursor/settings.json ~/.config/Cursor/User/settings.json
    ln -fns ~/dotfiles/cursor/keybindings.json ~/.config/Cursor/User/keybindings.json
    ln -fns ~/dotfiles/.tmux.conf ~/.tmux.conf
    ln -fns ~/dotfiles/bat ~/.config/
    ln -fns ~/dotfiles/.gitconfig ~/.gitconfig
    ln -fns ~/dotfiles/.vimrc ~/.vimrc
    ln -fns ~/dotfiles/.zshrc ~/.zshrc
    ln -fns ~/dotfiles/btop ~/.config
    ln -fns ~/dotfiles/gh ~/.config/
    ln -fns ~/dotfiles/nvim ~/.config/
    ln -fns ~/dotfiles/kitty ~/.config/
    ln -fns ~/dotfiles/swaync ~/.config/
    ln -fns ~/dotfiles/vencord/midnight-catppuccin-mocha.theme.css ~/.config/vesktop/themes

    if [ "$SHELL" != "/bin/zsh" ]; then
        sudo chsh -s $(which zsh)
        chsh -s $(which zsh)
    fi

    sudo timedatectl set-timezone Etc/GMT-3
    tmux source-file ~/.tmux.conf
    zsh -c "source ~/.zshrc"
}

# Verifica o argumento passado
case "$1" in
    pacman)
        pacman_bulk
        ;;
    yay)
        yay_bulk
        ;;
    link)
        links_setup;;
    *)
        ask_and_execute "Do you want to sync pacman packages" "pacman_bulk"
        ask_and_execute "Do you want to sync yay packages" "yay_bulk"
        ask_for_wm_installation
        ask_and_execute "Do you want to link the dotfiles" "links_setup"
        ;;
esac

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
