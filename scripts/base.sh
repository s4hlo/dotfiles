base_setup() {
    . ~/dotfiles/scripts/utils.sh

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

    sudo pacman -S --needed - < ~/dotfiles/pkg_exp.list
    yay -S --needed - < ~/dotfiles/pkg_exp_aur.list

    # dbeaver
    # Pritunl

    # _______________________________________________________________________________________
    
    # TODO: check if this is over or not
    # for compatibility we must install
    # using luarocks:
    # - magick
}
