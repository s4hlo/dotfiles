# Welcome to my Dotfiles! 😳

## References 📝

- Snapd: [Snapcraft Website](https://snapcraft.io/snapd)
- NVM: [NVM Github repositoy](https://github.com/nvm-sh/nvm#installing-and-updating)
- Starship: [Starship Website](https://starship.rs/)
- [All GNOME keybinds commands](https://gist.github.com/justgook/4257735)
- [Nerd Fonts](https://www.nerdfonts.com/font-downloads)

## 1. Clone this repo 🗿

```
git clone https://github.com/s4hlo/dotfiles ~/dotfiles
```

## 2. Setup dotfiles 🐦

In this `README.md` directory:

```
chmod +x ./setup_modules/setup.sh
./setup_modules/setup.sh
```

## 3. Neovim setup P.I (is optional)

```
:checkhealth
```

You'll probably notice you don't have support for copy/paste also that python and node haven't been setup

To fix copy/paste:

> TODO: how to check if is X11 or wayland

```sh
sudo apt install xclip # for X11 (prefer this, will be installed in setup.sh)
sudo apt install xsel # for X11
sudo apt install wl-clipboard # for wayland
```

To install python and node support:

```sh
pip install pynvim
npm i -g neovim

```

## 4. Qutebrowser setup P.I

```
:config-source
```

## 4. Manual installation 

> TODO : automate this in setup.sh

- Forge -> gnome-shell-extension
- vs code -> download .deb
- discord -> download .deb

# APPS REGISTER

```
BASE
   - nvm
   - starship
   - xclip
   - nvim
   - tmux
   - ripgrep
   - gh cli

DOMESTIC
    - bpytop
    - VLC
    - qbittorrent
    - qutebrowser
    - discord
    - spotify and spt

JOB
   - Dbeaver
   - Insomnia
   - pritunl-client

College
   - java and jdtls
   - zulip
```


# WIP
setting up the i3wm
```
sudo apt install i3
sudo apt install xinput
sudo apt install polybar
sudo apt install brightnessctl
sudo apt install pavucontrol
sudo apt install playerctl
sudo apt install rofi
sudo apt install xwallpaper
sudo apt install xprop 

```
