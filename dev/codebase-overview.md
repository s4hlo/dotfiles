# Codebase Overview

## Project Structure

This dotfiles repository is organized into configuration directories for various applications and tools, along with installation scripts and package lists.

## Core Architecture

### Setup System
The `setup.sh` script provides an interactive menu-driven installation system with the following options:
- **WSL packages**: Installs minimal packages from `minimal.list`
- **Full installation**: Installs all packages (pkg.list + pkg_aur.list)
- **Hyprland setup**: Installs Hyprland window manager and dependencies
- **i3 setup**: Installs i3 window manager and dependencies  
- **Symlink creation**: Creates symbolic links for all dotfiles
- **WSL-specific symlinks**: Creates only WSL-compatible symlinks

The script uses `yay` for AUR package management on Arch Linux and includes error handling and colored logging.

### Configuration Directories

**Window Managers:**
- `hypr/` - Hyprland (Wayland) configuration
- `i3/` - i3 (X11) window manager configuration

**Editor Configurations:**
- `nvim/` - Neovim configuration with Lua-based plugin system
- `cursor/` - Cursor editor settings and keybindings

**Terminal & Shell:**
- `kitty/` - GPU-accelerated terminal emulator config
- Shell configs: `.zshrc`, `.bashrc`, `.tmux.conf`, `.gitconfig`

**System Integration:**
- `waybar/` - Status bar for Hyprland
- `swaync/` - Notification center for Wayland
- `btop/` - System monitor configuration
- `bat/` - Enhanced cat with syntax highlighting
- `dunst/` - Notification daemon
- `wofi/` - Application launcher for Wayland

**Application Themes:**
- `vencord/` - Discord/Vesktop theme configuration
- `gh/` - GitHub CLI configuration
- `wallpapers/` - Wallpaper collection

### Package Management

The repository uses multiple package lists for different installation scenarios:
- `pkg.list` - Core Arch Linux packages (54 packages)
- `pkg_aur.list` - AUR packages
- `pkg_hypr.list` - Hyprland-specific packages
- `pkg_i3.list` - i3-specific packages
- `minimal.list` - Minimal package set for WSL (40 packages)

### Neovim Configuration

The Neovim setup uses a modular Lua-based plugin system:
- Plugin loader via lazy.nvim
- LSP configuration with 15+ language servers (TypeScript, Python, Rust, Lua, etc.)
- Treesitter for syntax highlighting
- Custom plugins for file types (markdown, nest)
- Mason for LSP server management
- null-ls for additional tooling integration

### Theme Consistency

All configurations use the **Catppuccin Mocha** theme for visual consistency across:
- Terminal colors
- Window manager themes
- Status bars
- Application themes
- Cursor themes

## Configuration Patterns

1. **Symlink-based**: All configs use symbolic links from `~/dotfiles/` to `~/.config/`
2. **Modular structure**: Each application has its own directory
3. **Platform awareness**: Separate configs for X11 (i3) and Wayland (Hyprland)
4. **WSL compatibility**: Minimal installation path for Windows Subsystem for Linux

## Development Tools Integration

- **LSP servers**: Configured for 15+ languages
- **Code formatting**: Prettier, stylua, shfmt
- **Version control**: Git with delta for diffs
- **Package managers**: NVM, pyenv, uv, yarn, cargo
- **Terminal tools**: Starship prompt, atuin history, zsh enhancements

