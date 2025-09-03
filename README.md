# Sahlo's Dotfiles

![Screenshot](Screenshot.png)

A comprehensive dotfiles collection for Arch Linux with support for both Hyprland (Wayland) and i3 (X11) window managers, featuring a modern development environment with Catppuccin Mocha theme.

## 🚀 Quick Setup

```bash
git clone https://github.com/s4hlo/dotfiles ~/dotfiles
cd ~/dotfiles
chmod +x ./setup.sh
./setup.sh
```

## 📦 What's Included

### Window Managers
- **Hyprland** - Modern Wayland compositor with dynamic tiling
- **i3** - Traditional X11 tiling window manager

### Terminal & Shell
- **Kitty** - GPU-accelerated terminal with Catppuccin theme
- **Zsh** - Enhanced shell with Starship prompt, autosuggestions, and syntax highlighting
- **Tmux** - Terminal multiplexer with vim-like navigation

### Development Tools
- **Neovim** - Modern Vim with LSP, treesitter, and extensive plugin ecosystem
- **Cursor** - AI-powered code editor with custom settings
- **Git** - Configured with useful aliases and delta for diffs

### System Utilities
- **Waybar** - Modern status bar for Hyprland
- **Polybar** - Status bar for i3
- **Rofi/Wofi** - Application launchers
- **Swaync** - Notification center for Wayland
- **Btop** - System monitor with Catppuccin theme
- **Bat** - Enhanced cat with syntax highlighting

### Applications
- **Spotify Launcher** - Music streaming
- **Vesktop** - Discord client with custom theme
- **Obsidian** - Note-taking application
- **VLC** - Media player
- **LibreOffice** - Office suite

## 🎨 Theme

Everything is themed with **Catppuccin Mocha** for a consistent, modern look:
- Terminal colors
- Window manager themes
- Status bars
- Application themes
- Cursor themes

## ⚙️ Configuration Files

### Core Configurations
- `hypr/` - Hyprland configuration with workspaces, keybindings, and autostart
- `i3/` - i3 configuration with Polybar and Rofi
- `nvim/` - Neovim setup with LSP, treesitter, and plugins
- `kitty/` - Terminal configuration with Catppuccin theme
- `waybar/` - Modern status bar configuration
- `cursor/` - Cursor editor settings and keybindings

### Shell & Tools
- `.zshrc` - Zsh configuration with Starship prompt
- `.tmux.conf` - Tmux configuration with vim-like navigation
- `.gitconfig` - Git configuration with aliases and delta

### System Integration
- `swaync/` - Notification center configuration
- `btop/` - System monitor theme
- `bat/` - Enhanced cat configuration

## 📋 Package Lists

- `pkg.list` - Core Arch Linux packages
- `pkg_hypr.list` - Hyprland-specific packages
- `pkg_i3.list` - i3-specific packages
- `pkg_aur.list` - AUR packages

## 🛠️ Setup Script Features

The `setup.sh` script is an interactive installer that automates the entire dotfiles setup process:

### Interactive Installation Process
1. **Package Installation** - Installs packages from `pkg.list` via pacman
2. **AUR Package Installation** - Automatically installs `yay` if needed, then installs packages from `pkg_aur.list`
3. **Window Manager Selection** - Choose between:
   - **Hyprland** (Wayland) - Installs Hyprland, Waybar, Wofi, and related packages
   - **i3** (X11) - Installs i3, Polybar, Rofi, and X11 utilities
   - **Skip** - Skip window manager installation
4. **Symlink Creation** - Automatically creates symbolic links for all configuration files
5. **Shell Configuration** - Sets Zsh as default shell and sources configurations
6. **Timezone Setup** - Configures system timezone to GMT-3

### Script Usage Options
```bash
# Interactive mode (recommended)
./setup.sh

# Install only pacman packages
./setup.sh pacman

# Install only AUR packages
./setup.sh yay

# Create symlinks only
./setup.sh link
```

### What Gets Linked
- Shell configurations (`.zshrc`, `.tmux.conf`, `.gitconfig`)
- Editor configs (`nvim/`, `cursor/`)
- Terminal configs (`kitty/`, `bat/`, `btop/`)
- Window manager configs (`hypr/`, `i3/`, `waybar/`, `wofi/`)
- System utilities (`swaync/`, `gh/`)
- Application themes (`vencord/`)

## 🔧 Manual Setup Requirements

### Clipboard Support
```bash
# For X11
xclip xsel

# For Wayland
wl-clipboard
```

### Development Environment
```bash
# Node.js
nvm install --lts

# Python
pip install pynvim

# Neovim
npm i -g neovim
```



## 🎯 Key Features

- **Dual WM Support** - Choose between Hyprland (Wayland) or i3 (X11)
- **Modern Development** - Neovim with LSP, treesitter, and AI assistance
- **Consistent Theming** - Catppuccin Mocha across all applications
- **Productivity Tools** - Tmux, Git aliases, and enhanced shell
- **System Monitoring** - Btop, Waybar/Polybar with system info
- **Media & Communication** - Spotify, Discord, and notification system

## 📚 References

- [Hyprland Wiki](https://wiki.hyprland.org/)
- [i3 User's Guide](https://i3wm.org/docs/userguide.html)
- [Neovim Documentation](https://neovim.io/doc/)
- [Starship Prompt](https://starship.rs/)
- [Catppuccin Theme](https://github.com/catppuccin/catppuccin)
- [Nerd Fonts](https://www.nerdfonts.com/)
