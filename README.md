> WARNING 2: theres a lot of link and files in this text, is important to check if all of them are available


# install repo


```
git clone https://github.com/s4hlo/dotfiles ~/dotfiles  
```
# 0. Install Snap
``` 
sudo apt install snapd
sudo service snapd start
```
# 1. Install node using nvm 
reference: [NVM Github repositoy](https://github.com/nvm-sh/nvm#installing-and-updating)

``` 
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | zsh
nvm install --lts
node -v
```
# 3. Install Starship

Reference: [Starship Website](https://starship.rs/)

```
curl -sS https://starship.rs/install.sh | sh
```

# 2. Setup dotfiles

reference: [All GNOME keybinds commands](https://gist.github.com/justgook/4257735)

reference: [Nerd Fonts](https://www.nerdfonts.com/font-downloads)


In the this `README.md` directory:

```
chmod +x setup.sh
./setup.sh
```

# 4. install neovim with basic ide and update preferences 

### 4.2 install nvim and make some ajusts

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

# 5. Install .deb sofwares 
> Ex. VS code, Discord
```
sudo apt install *path/of/the/file*.deb
```
