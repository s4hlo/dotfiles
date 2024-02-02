# Welcome to my Dotfiles! 😳

## 0. Clone this repo 🗿
```
git clone https://github.com/s4hlo/dotfiles ~/dotfiles  
```
## 1. Install Requiriments 📝 
References:
- Snapd: [Snapcraft Website](https://snapcraft.io/snapd)
- NVM: [NVM Github repositoy](https://github.com/nvm-sh/nvm#installing-and-updating)
- Starship: [Starship Website](https://starship.rs/)
``` 
sudo apt install snapd
sudo service snapd start
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | zsh
nvm install --lts
node -v
curl -sS https://starship.rs/install.sh | sh
```

## 2. Setup dotfiles 🐦

References:
- [All GNOME keybinds commands](https://gist.github.com/justgook/4257735)
- [Nerd Fonts](https://www.nerdfonts.com/font-downloads)

In the this `README.md` directory:

```
chmod +x setup.sh
./setup.sh
```

## 4. install neovim with basic ide and update preferences ✍️

#### 4.2 install nvim and make some ajusts

```
sudo snap install nvim --classic
git clone https://github.com/LunarVim/Launch.nvim.git ~/.config/nvim
```
Update nvim configs:

```
sed -i '32s/.*/vim.opt.relativenumber = false/' ~/.config/nvim/lua/user/options.lua
sed -i '35s/.*/vim.opt.wrap = true/' ~/.config/nvim/lua/user/options.lua
echo 'keymap("i", "jj", "<Esc>", opts)' >> ~/.config/nvim/lua/user/keymaps.lua
```

#### Basic softwares - WIP ⚙️ 
> VS code, Discord

### Nvim setup - WIP
```
:checkhealth
```
You'll probably notice you don't have support for copy/paste also that python and node haven't been setup

So let's fix that

First we'll fix copy/paste

- On Ubuntu

  ```sh
  sudo apt install xsel # for X11
  sudo apt install wl-clipboard # for wayland
  ```

Next we need to install python support (node is optional)

- Neovim python support

  ```sh
  pip install pynvim
  npm i -g neovim
  sudo apt install ripgrep
  ```

