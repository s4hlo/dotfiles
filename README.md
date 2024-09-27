# Sahlo's dotfiles

## 1. Specimen

![Captura de tela do projeto](Screenshot.png)

## 2. Incipient

> the path matters

```
git clone https://github.com/s4hlo/dotfiles ~/dotfiles
cd ~/dotfiles
chmod +x ./setup.sh
./setup.sh

```

## 3. Neovim Supplemental

```
:checkhealth
```

You'll probably notice you don't have support for copy/paste also that python and node haven't been setup

> TODO: auto-check X11 or wayland

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

## 4. Qutebrowser Memento

```
:config-source
```
## References

- [Snapcraft Website](https://snapcraft.io/snapd)
- [NVM Github repositoy](https://github.com/nvm-sh/nvm#installing-and-updating)
- [Starship Website](https://starship.rs/)
- [Nerd Fonts](https://www.nerdfonts.com/font-downloads)

todo : fix starship installation, it is not working
todo : add install curl just for assurance
some notes run luarocks install magick
