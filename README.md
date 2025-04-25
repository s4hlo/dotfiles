# Sahlo's dotfiles

## 1. Specimen

![Captura de tela do projeto](https://github.com/user-attachments/assets/73d4b88d-e32f-45f2-9ae8-5f35e4f65b68)

## 2. Incipient



> the path matters

```
git clone https://github.com/s4hlo/dotfiles ~/dotfiles
cd ~/dotfiles
chmod +x ./setup.sh
./setup.sh

```

## 3. Supplemental

You'll probably notice you don't have support for copy/paste also that python and node haven't been setup

> TODO: auto-check X11 or wayland

install those pkg for the proper env ( check availability )

```sh
xclip # for X11 (prefer this, will be installed in setup.sh)
xsel # for X11
wl-clipboard # for wayland
```

python and node support:

```sh
nvm install --lts
pip install pynvim
npm i -g neovim

```

## References

- [Snapcraft Website](https://snapcraft.io/snapd)
- [NVM Github repositoy](https://github.com/nvm-sh/nvm#installing-and-updating)
- [Starship Website](https://starship.rs/)
- [Nerd Fonts](https://www.nerdfonts.com/font-downloads)
