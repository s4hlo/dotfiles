#!/bin/bash
set -euo pipefail

echo -e "\e[34m> Welcome to the setup script for my dotfiles!\e[0m"
cd ~/dotfiles
. ~/dotfiles/scripts/lib.sh
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

[ ! -f /etc/arch-release ] && exit 1


install_aur_helper() {
    local helper=$1
    if command -v "$helper" &>/dev/null; then
        log "$helper is already installed." 0
        return
    fi
    log "$helper not found. Installing..." 1
    sudo pacman -S --needed git base-devel
    git clone "https://aur.archlinux.org/${helper}.git"
    (cd "$helper" && makepkg -si --noconfirm)
    rm -rf "$helper"
    log "$helper installed successfully!" 0
}

detect_aur_helper() {
    if command -v paru &>/dev/null; then
        AUR_HELPER="paru"
    elif command -v yay &>/dev/null; then
        AUR_HELPER="yay"
    else
        log "No AUR helper found. Installing yay..." 1
        install_aur_helper "yay"
        AUR_HELPER="yay"
    fi
}

install_with_aur() {
    "$AUR_HELPER" -S --needed $@
}

show_menu() {
    echo -e "\e[34m> Available Options \e[0m"
    echo -e ""
    echo -e "\e[95m  1)\e[0m \e[92maur\e[0m        Install an AUR helper (paru/yay)         \e[0m"
    echo -e "\e[95m  2)\e[0m \e[92mfull\e[0m       Install all packages (pkg + AUR)         \e[0m"
    echo -e "\e[95m  3)\e[0m \e[92mhypr\e[0m       Install Hyprland window manager          \e[0m"
    echo -e "\e[95m  4)\e[0m \e[92mi3\e[0m         Install i3 window manager                \e[0m"
    echo -e "\e[95m  5)\e[0m \e[92mlink\e[0m       Create symlinks for dotfiles             \e[0m"
    echo -e "\e[95m  6)\e[0m \e[91mexit\e[0m       Exit the setup                           \e[0m"
    echo -e ""
    echo -e "\e[34m> Enter your choice (1-6): \e[0m"
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
    1 | aur)
        log "Choose an AUR helper to install:" 0
        echo -e "\e[95m  1)\e[0m paru"
        echo -e "\e[95m  2)\e[0m yay"
        read -r aur_choice
        case "$aur_choice" in
        1 | paru)
            install_aur_helper "paru"
            ;;
        2 | yay)
            install_aur_helper "yay"
            ;;
        *)
            log "Invalid choice. Please choose 1-2." 2
            ;;
        esac
        if ! ask_continue; then
            echo -e "\e[32mSetup completed. Goodbye!\e[0m"
            break
        fi
        ;;
    2 | full)
        log "Installing all packages..." 0
        detect_aur_helper
        log "Using AUR helper: $AUR_HELPER" 0
        install_with_aur $(cat ~/dotfiles/pkg.list)
        install_with_aur $(cat ~/dotfiles/minimal.list)
        install_with_aur $(cat ~/dotfiles/pkg_aur.list)
        log "All packages installed!" 0
        if ! ask_continue; then
            echo -e "\e[32mSetup completed. Goodbye!\e[0m"
            break
        fi
        ;;
    3 | hypr)
        log "Starting Hyprland configuration..." 0
        detect_aur_helper
        install_with_aur "hyprland xdg-desktop-portal-hyprland"
        install_with_aur "hyprpaper waybar hyprshade hyprshot wofi"

        # check if those two are installed with the above when zero setup
        # hyprlock
        # hyprpicker-git \

        link ~/dotfiles/hypr ~/.config/hypr
        link ~/dotfiles/hypr/waybar ~/.config/waybar
        link ~/dotfiles/hypr/wofi ~/.config/wofi
        link ~/dotfiles/hypr/swaync ~/.config/swaync

        log "Hyprland configuration completed!" 0
        if ! ask_continue; then
            echo -e "\e[32mSetup completed. Goodbye!\e[0m"
            break
        fi
        ;;
    4 | i3)
        log "Starting i3 configuration..." 0
        detect_aur_helper
        install_with_aur "i3 picom polybar rofi xwallpaper xorg-xinput"

        link ~/dotfiles/i3/config ~/.config/i3/config
        link ~/dotfiles/i3/rofi ~/.config/rofi
        link ~/dotfiles/i3/polybar ~/.config/polybar

        log "i3 configuration completed!" 0
        if ! ask_continue; then
            echo -e "\e[32mSetup completed. Goodbye!\e[0m"
            break
        fi
        ;;
    5 | link)
        log "Creating full symlinks setup..." 0

        link_common
        link ~/dotfiles/.gitconfig ~/.gitconfig
        link ~/dotfiles/kitty ~/.config/kitty

        if [ "$SHELL" != "/bin/zsh" ]; then
            sudo chsh -s $(which zsh)
            chsh -s $(which zsh)
        fi

        sudo timedatectl set-timezone Etc/GMT-3
        tmux source-file ~/.tmux.conf 2>/dev/null || true

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
        log "Invalid option. Please choose 1-6." 2
        ;;
    esac
done
