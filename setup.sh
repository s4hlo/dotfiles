#!/bin/bash
echo -e "\e[34m> Welcome to the setup script for my dotfiles!\e[0m"
cd ~/dotfiles || exit 1
if command -v catnap &>/dev/null; then
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
    local colors=("\e[32m" "\e[33m" "\e[31m" "\e[31m")
    local labels=("[INFO]" "[WARN]" "[ERROR]" "[EXIT]")

    echo -e "${colors[$type]}${labels[$type]}\e[0m - $content"
}

link() {
    src=~/dotfiles/$1
    dst=$2

    if [ ! -e "$src" ]; then
        echo "Erro: $src não existe."
        return 1
    fi

    if [ -z "$dst" ]; then
        echo "Erro: destino não informado."
        return 1
    fi

    rm -rf -- "$dst"
    ln -sfn "$src" "$dst"
}

install() {
    if [ -f /etc/arch-release ]; then
        if ! command -v yay &>/dev/null; then
            log "yay not found. Installing..." 1
            sudo pacman -S --needed git base-devel
            git clone https://aur.archlinux.org/yay.git
            cd yay
            makepkg -si --noconfirm
            log "yay installed successfully!"
        else
            log "yay is already installed."
        fi
        yay -S --needed $1
    else
        # TODO: install $1 on other distros
        log "Package installation not implemented for this distribution." 2
    fi
}

configure_hyprland() {
    log "Installing Hypr... " 1

    install "hyprland xdg-desktop-portal-hyprland"
    install "hyprpaper waybar hyprshade hyprshot wofi"
    
    # check if those two are installed with the above when zero setup
    # hyprlock
    # hyprpicker-git \

    link hypr ~/.config/hypr
    link waybar ~/.config/waybar
    link wofi ~/.config/wofi

    log "Hypr installed successfully!" 0
}

configure_i3() {
    log "Installing i3..." 1

    install "i3 picom polybar rofi xwallpaper xorg-xinput"

    mkdir ~/.config/i3

    link i3/config ~/.config/i3/config
    link i3/rofi ~/.config/rofi
    link i3/polybar ~/.config/polybar

    log "i3 installed successfully!" 0
}

add_minimal() {
    install $(cat ~/dotfiles/minimal.list)
}

add_full() {
    install $(cat ~/dotfiles/pkg.list)
    install $(cat ~/dotfiles/pkg_aur.list)
}

link_minimal() {

    link .bashrc ~/.bashrc
    link .gitconfig ~/.gitconfig
    link .tmux.conf ~/.tmux.conf
    link .zshrc ~/.zshrc
    link bat ~/.config/bat
    link btop ~/.config/btop
    link gh ~/.config/gh

    # identifie shell and source it
    if [ "$SHELL" != "/bin/zsh" ]; then
        source ~/.zshrc
    else
        source ~/.bashrc
    fi
}

links_setup() {
    link_minimal

    link nvim ~/.config/nvim
    link kitty ~/.config/kitty
    link cursor/settings.json ~/.config/Cursor/User/settings.json
    link cursor/keybindings.json ~/.config/Cursor/User/keybindings.json
    link swaync ~/.config/swaync

    if [ "$SHELL" != "/bin/zsh" ]; then
        sudo chsh -s $(which zsh)
        chsh -s $(which zsh)
    fi

    sudo timedatectl set-timezone Etc/GMT-3
    tmux source-file ~/.tmux.conf
    zsh -c "source ~/.zshrc"
}

show_menu() {
    echo -e "\e[34m> Available Options \e[0m"
    echo -e ""
    echo -e "\e[95m  1)\e[0m \e[92mpacman\e[0m     Install packages from pkg.list           \e[0m"
    echo -e "\e[95m  2)\e[0m \e[92myay\e[0m        Install AUR packages from pkg_aur.list   \e[0m"
    echo -e "\e[95m  3)\e[0m \e[92mhypr\e[0m       Install Hyprland window manager          \e[0m"
    echo -e "\e[95m  4)\e[0m \e[92mi3\e[0m         Install i3 window manager                \e[0m"
    echo -e "\e[95m  5)\e[0m \e[92mlink\e[0m       Create symlinks for dotfiles             \e[0m"
    echo -e "\e[95m  6)\e[0m \e[91mexit\e[0m       Exit the setup                           \e[0m"
    echo -e ""
    echo -e "\e[34m> Enter your choice (1-6): \e[0m"
}

run_command() {
    case "$1" in
    1 | minimal)
        add_full
        ;;
    2 | full)
        add_full
        ;;
    3 | hypr)
        configure_hyprland
        ;;
    4 | i3)
        configure_i3
        ;;
    5 | link)
        links_setup
        ;;
    6 | link_minimal)
        links_setup
        ;;
    7 | exit)
        echo -e "\e[32mExiting setup. Goodbye!\e[0m"
        exit 0
        ;;
    *)
        log "Invalid option. Please choose 1-6." 2
        return 1
        ;;
    esac
}

ask_continue() {
    echo -e ""
    echo -e "\e[34m> Do you want to run another command? (y/n): \e[0m"
    read -r continue_choice
    case "$continue_choice" in
    y | Y | yes | YES)
        return 0
        ;;
    *)
        return 1
        ;;
    esac
}

# Main interactive loop
while true; do
    show_menu
    read -r choice

    if run_command "$choice"; then
        if ! ask_continue; then
            echo -e "\e[32mSetup completed. Goodbye!\e[0m"

            break
        fi
    fi
done

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
