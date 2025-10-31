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


install_with_yay() {
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
        log "Package installation not implemented for this distribution." 2
    fi
}

show_menu() {
    echo -e "\e[34m> Available Options \e[0m"
    echo -e ""
    echo -e "\e[95m  1)\e[0m \e[92 WSL\e[0m    Install WSL packages                  \e[0m"
    echo -e "\e[95m  2)\e[0m \e[92mfull\e[0m       Install all packages (pkg + AUR)         \e[0m"
    echo -e "\e[95m  3)\e[0m \e[92mhypr\e[0m       Install Hyprland window manager          \e[0m"
    echo -e "\e[95m  4)\e[0m \e[92mi3\e[0m         Install i3 window manager                \e[0m"
    echo -e "\e[95m  5)\e[0m \e[92mlink\e[0m       Create symlinks for dotfiles             \e[0m"
    echo -e "\e[95m  6)\e[0m \e[91mexit\e[0m       Exit the setup                           \e[0m"
    echo -e ""
    echo -e "\e[34m> Enter your choice (1-7): \e[0m"
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

    case "$choice" in
    1 | wsl)
        log "Installing WSL packages..." 0
        sudo apt update && sudo apt install -y $(cat ~/dotfiles/wsl.list)
        snap install atuin
        snap install yazi
        log "WSL packages installed!" 0
        if ! ask_continue; then
            echo -e "\e[32mSetup completed. Goodbye!\e[0m"
            break
        fi
        log "Creating WSL symlinks..." 0

        rm -rf -- ~/.bashrc && ln -sfn ~/dotfiles/.bashrc ~/.bashrc
        rm -rf -- ~/.gitconfig && ln -sfn ~/dotfiles/.gitconfig ~/.gitconfig
        rm -rf -- ~/.tmux.conf && ln -sfn ~/dotfiles/.tmux.conf ~/.tmux.conf
        rm -rf -- ~/.zshrc && ln -sfn ~/dotfiles/.zshrc ~/.zshrc
        rm -rf -- ~/.config/bat && ln -sfn ~/dotfiles/bat ~/.config/bat
        rm -rf -- ~/.config/btop && ln -sfn ~/dotfiles/btop ~/.config/btop
        rm -rf -- ~/.config/gh && ln -sfn ~/dotfiles/gh ~/.config/gh

        source ~/.bashrc
        sudo timedatectl set-timezone Etc/GMT-3
        tmux source-file ~/.tmux.conf
        
        log "WSL symlinks created!" 0
        if ! ask_continue; then
            echo -e "\e[32mSetup completed. Goodbye!\e[0m"
            break
        fi
        ;;

    2 | full)
        log "Installing all packages..." 0
        install_with_yay $(cat ~/dotfiles/pkg.list)
        install_with_yay $(cat ~/dotfiles/pkg_aur.list)
        log "All packages installed!" 0
        if ! ask_continue; then
            echo -e "\e[32mSetup completed. Goodbye!\e[0m"
            break
        fi
        ;;
    3 | hypr)
        log "Starting Hyprland configuration..." 0
        install_with_yay "hyprland xdg-desktop-portal-hyprland"
        install_with_yay "hyprpaper waybar hyprshade hyprshot wofi"
        
        # check if those two are installed with the above when zero setup
        # hyprlock
        # hyprpicker-git \

        rm -rf -- ~/.config/hypr && ln -sfn ~/dotfiles/hypr ~/.config/hypr
        rm -rf -- ~/.config/waybar && ln -sfn ~/dotfiles/waybar ~/.config/waybar
        rm -rf -- ~/.config/wofi && ln -sfn ~/dotfiles/wofi ~/.config/wofi

        log "Hyprland configuration completed!" 0
        if ! ask_continue; then
            echo -e "\e[32mSetup completed. Goodbye!\e[0m"
            break
        fi
        ;;
    4 | i3)
        log "Starting i3 configuration..." 0
        install_with_yay "i3 picom polybar rofi xwallpaper xorg-xinput"

        mkdir ~/.config/i3

        rm -rf -- ~/.config/i3/config && ln -sfn ~/dotfiles/i3/config ~/.config/i3/config
        rm -rf -- ~/.config/rofi && ln -sfn ~/dotfiles/i3/rofi ~/.config/rofi
        rm -rf -- ~/.config/polybar && ln -sfn ~/dotfiles/i3/polybar ~/.config/polybar

        log "i3 configuration completed!" 0
        if ! ask_continue; then
            echo -e "\e[32mSetup completed. Goodbye!\e[0m"
            break
        fi
        ;;
    5 | link)
        log "Creating full symlinks setup..." 0
        
        log "Creating WSL symlinks..." 0
        rm -rf -- ~/.bashrc && ln -sfn ~/dotfiles/.bashrc ~/.bashrc
        rm -rf -- ~/.gitconfig && ln -sfn ~/dotfiles/.gitconfig ~/.gitconfig
        rm -rf -- ~/.tmux.conf && ln -sfn ~/dotfiles/.tmux.conf ~/.tmux.conf
        rm -rf -- ~/.zshrc && ln -sfn ~/dotfiles/.zshrc ~/.zshrc
        rm -rf -- ~/.config/bat && ln -sfn ~/dotfiles/bat ~/.config/bat
        rm -rf -- ~/.config/btop && ln -sfn ~/dotfiles/btop ~/.config/btop
        rm -rf -- ~/.config/gh && ln -sfn ~/dotfiles/gh ~/.config/gh

        rm -rf -- ~/.config/nvim && ln -sfn ~/dotfiles/nvim ~/.config/nvim
        rm -rf -- ~/.config/kitty && ln -sfn ~/dotfiles/kitty ~/.config/kitty
        rm -rf -- ~/.config/Cursor/User/settings.json && ln -sfn ~/dotfiles/cursor/settings.json ~/.config/Cursor/User/settings.json
        rm -rf -- ~/.config/Cursor/User/keybindings.json && ln -sfn ~/dotfiles/cursor/keybindings.json ~/.config/Cursor/User/keybindings.json
        rm -rf -- ~/.config/swaync && ln -sfn ~/dotfiles/swaync ~/.config/swaync

        if [ "$SHELL" != "/bin/zsh" ]; then
            sudo chsh -s $(which zsh)
            chsh -s $(which zsh)
        fi

        sudo timedatectl set-timezone Etc/GMT-3
        tmux source-file ~/.tmux.conf
        zsh -c "source ~/.zshrc"
        
        log "Full symlinks setup completed!" 0
        if ! ask_continue; then
            echo -e "\e[32mSetup completed. Goodbye!\e[0m"
            break
        fi
        ;;
    6 | exit)
        echo -e "\e[32mExiting setup. Goodbye!\e[0m"
        exit 0
        ;;
    *)
        log "Invalid option. Please choose 1-7." 2
        ;;
    esac
done
'
