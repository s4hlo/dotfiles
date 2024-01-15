> WARNING 2: theres a lot of link and files in this text, is important to check if all of them are available
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

# 2. Setup gnome basic keybinds and config 

reference: [All GNOME keybinds commands](https://gist.github.com/justgook/4257735)
```
gsettings set org.gnome.desktop.peripherals.touchpad tap-to-click true
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-left "['<Super>j']"
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-right "['<Super>k']"
gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-left "['<Super><Shift>J']"
gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-right "['<Super><Shift>K']"
gsettings set org.gnome.desktop.wm.preferences num-workspaces 3
gsettings set org.gnome.desktop.interface enable-animations false
```
# 3. Setup terminal configuration

### 3.1 install nerd fonts 

reference: [Nerd Fonts](https://www.nerdfonts.com/font-downloads)

```
wget -O ~/Downloads/TempFile.zip https://github.com/ryanoasis/nerd-fonts/releases/download/v3.1.1/FiraCode.zip
sudo unzip -j -o ~/Downloads/TempFile.zip '*.ttf' -d /usr/share/fonts/
rm ~/Downloads/TempFile.zip
sudo fc-cache -fv
fc-list | grep "FiraCode"
```

Set NerdFont in GNOME terminal
```
DEFAULT_PROFILE=$(gsettings get org.gnome.Terminal.ProfilesList default | awk -F \' '{print $2}')
gsettings set org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:${DEFAULT_PROFILE}/ font 'Fira Code 12'
```

### 3.1 Setup tmux

```
echo "unbind r
bind r source-file ~/.tmux.conf

setw -g mode-keys vi
bind-key h select-pane -L
bind-key j select-pane -D
bind-key k select-pane -U
bind-key l select-pane -R" > ~/.tmux.conf
tmux source ~/.tmux.conf
```

### 3.2 Setup Starship

Reference: [Starship Website](https://starship.rs/)

```
curl -sS https://starship.rs/install.sh | sh
```

### 3.3 Configure `.zshrc` and add aliases

```
echo '
eval "$(starship init zsh)"
[ -z "$TMUX" ] && exec tmux 

# Enable vim keybinds
set -o vi

# My personal aliases 
alias tks="tmux kill-session -t"
alias ipforward='sudo echo "1" | sudo tee /proc/sys/net/ipv4/ip_forward'

' >> ~/.zshrc
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
