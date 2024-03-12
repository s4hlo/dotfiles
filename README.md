## References

- Snapd: [Snapcraft Website](https://snapcraft.io/snapd)
- NVM: [NVM Github repositoy](https://github.com/nvm-sh/nvm#installing-and-updating)
- Starship: [Starship Website](https://starship.rs/)
- [Nerd Fonts](https://www.nerdfonts.com/font-downloads)
- [All GNOME keybinds commands](https://gist.github.com/justgook/4257735) > deprecated\_

## 1. Clone this repo

> the path matters

```
git clone https://github.com/s4hlo/dotfiles ~/dotfiles
cd ~/dotfiles
chmod +x ./setup_modules/setup.sh
./setup_modules/setup.sh

```

## 2. Neovim setup

```
:checkhealth
```

You'll probably notice you don't have support for copy/paste also that python and node haven't been setup

> TODO: how to check if is X11 or wayland

copy/paste:

```sh
sudo apt install xclip # for X11 (prefer this, will be installed in setup.sh)
sudo apt install xsel # for X11
sudo apt install wl-clipboard # for wayland
```

python and node support:

```sh
pip install pynvim
npm i -g neovim

```

## 3. Qutebrowser setup

```
:config-source
```
