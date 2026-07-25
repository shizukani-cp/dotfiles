# dotfiles

My NixOS + Home Manager configuration. Fully declarative system & environment setup with Neovim, Sway WM, and CLI tools.

## What's Inside

- **NixOS 26.05** system configuration
- **Home Manager** for user environment (CLI, desktop, terminal)
- **Neovim** config (Lua, compiled bytecode) with ddc.vim, ddu.vim, denops
- **Sway** Wayland window manager
- **Zsh** + tmux + oh-my-posh
- **VIME**: Custom Neovim pool manager (Henkan key for floating text input → clipboard)
- **Custom keyboard layout** (keyd): Ergonomic layer-based key remapping

## Quick Start

### Prerequisites

- NixOS installed on your system
- x86_64-linux architecture

### Installation

```sh
# 1. Enable Nix flakes
mkdir -p ~/.config/nix
echo "experimental-features = nix-command flakes" > ~/.config/nix/nix.conf

# 2. Clone & apply configuration
git clone https://github.com/shizukani-cp/dotfiles
cd dotfiles
sudo nixos-rebuild switch --flake .#shizukani-cp
# or: bash ./b
```

## Directory Structure

```
nvim/                  Neovim configuration (Lua)
  lua/core/            Settings, keybinds, plugins, autocmds
  lua/plugins/         Plugin specs (manager.nvim)
  lua/data/            Datas (LSP configs, etc.)
  lua/utils/           Utilities (UUID generation, etc.)
  denops/              Denops plugin config (ddc.ts)

modules/               NixOS/Home Manager config
  configuration.nix    System-level config (bootloader, packages)
  sway.nix             Sway WM bindings, greetd login
  keyd.nix             Keyboard daemon (custom layer-based remapping)
  chromium.nix         Chromium config
  home.nix             User packages & home config
  cli.nix              Terminal: tmux, Zsh, foot, oh-my-posh
  desktop.nix          GUI: Sway, Rofi, Waybar, Dunst, Wlogout
  env.nix              Session vars, compiled Nvim, VIME pool manager
  qutebrowser.nix      Browser config
  mpd.nix              Music daemon
  host/                Hardware-specific (generated)

files/                 AI prompts and icons
flake.nix              Flake entry point
.stylua.toml           Lua formatter config
b                      Build script: sudo nixos-rebuild switch --flake .#shizukani-cp
```

## Key Features

### 🎨 Neovim Setup

- Fully declarative Lua config
- Compiled to bytecode via Luajit for performance
- **ddc.vim**: Completion engine (LSP, buffer, path, snippets)
- **ddu.vim**: Fuzzy finder (files, buffers, git status, plugins, etc.)
- **denops**: Async Deno-based plugin integration
- Custom manager.nvim plugin system for lazy loading

Leader key: `k`

### ⌨️ Custom Keyboard Layout (keyd)

Fully remapped ergonomic keyboard using `keyd` daemon. Based on Dvorak-inspired layout optimized for both coding and writing.

**Layout overview:**

![Keyboard Layout](https://raw.githubusercontent.com/shizukani-cp/blog/master/resources/articles/20260707/keyboard-layout.png)

**Key features:**

- **Left hand (home row):** a=a, s=u, d=o, f=i, g=e (vowels concentrated)
- **Layer system:**
  - `q`: Function layer (volume, Henkan)
  - `w`: Symbols layer (punctuation, brackets)
  - `e`: Shift layer
  - `r`: Special layer (arrow keys, backspace, delete)
  - `t`: Number layer (0-9)
  - `c` + `fn_layer`: F-keys (F1-F12)
- **Left modifiers:** z=Meta, x=Control, v=Alt
- **VIME trigger:** Henkan key (via Function layer)

See `modules/keyd.nix` for full keymap configuration.

### ⌨️ Custom Input System (VIME)

Press **Function layer + `;`** to open a floating Neovim window:
- Type text
- Close → text automatically copied to clipboard
- Uses `/run/current-system/sw/bin/nvim` server pool

Set up in `modules/env.nix` (systemd user service) and `modules/sway.nix` (keybinding).

### 🖥️ Desktop Environment

- **Sway**: Wayland tiling WM
- **Waybar**: Status bar (CPU, memory, network, battery, clock)
- **Rofi**: Application launcher & clipboard manager
- **Foot**: Terminal (configured for 256 colors, tmux integration)

### 💻 Terminal

- **Zsh** with oh-my-zsh plugins (git, rust, uv)
- **tmux** with vim-tmux-navigator integration
- **oh-my-posh** for fancy prompt (Git status, time, execution time)
- **Auto venv activation** in `~/workspace`

## Customization

### Change Hostname

Edit `modules/configuration.nix` and update:

```
networking.hostName = "your-hostname";
```

### Adjust Packages

User packages in `modules/home.nix`:

```
home.packages = with pkgs; [
  # Add/remove packages here
];
```

### Keybindings

- **Editor (Nvim):** `nvim/lua/core/keymap.lua`
- **WM (Sway):** `modules/sway.nix` (Mod4 = Super/Windows key)
- **Keyboard remapping:** `modules/keyd.nix` (layer-based system)

### Neovim Plugins

Edit `nvim/lua/core/plugin.lua` and add plugin specs in `nvim/lua/plugins/`.

### Keyboard Layout

To modify the keyboard layout, edit `modules/keyd.nix`. The layout is organized by layers:

- `main`: Base alphanumeric mapping
- `function_layer`: Media controls + Henkan
- `shift_layer`: Shift modifier state
- `symbols_layer`: Punctuation & brackets
- `special_layer`: Navigation & editing keys
- `number_layer`: 0-9 and special chars
- `fn_layer+function_layer`: F-keys (F1-F12)

## Environment Variables

Set in `modules/env.nix`:

- `PROJECTS_DIR`: `~/workspace/github.com/shizukani-cp`
- `SCRATCH_DIR`: `~/scratch`
- `DOTFILES_DIR`: Points to this repo
- `EDITOR`: `nvim`

## Troubleshooting

### Flake Command Not Found

Enable experimental features:

```
echo "experimental-features = nix-command flakes" >> ~/.config/nix/nix.conf
```

### Hardware Configuration Missing

The `modules/host/hardware-configuration.nix` is auto-generated during NixOS install. If missing:

```
sudo nixos-generate-config --root /mnt
# Copy the generated file into modules/host/
```

### VIME Henkan Key Not Working

- Check if `keyd` is running: `systemctl status keyd`
- Check if systemd user service exists: `systemctl --user status nvim-vime`
- Verify Henkan key mapped in `modules/keyd.nix` (Function layer + `;`)

### Keyboard Layout Not Applied

- Restart keyd: `sudo systemctl restart keyd`
- Check keyd logs: `journalctl -u keyd -n 50`
- Verify your keyboard is in the default layout (check `/etc/keyd/default.conf` auto-generated from `modules/keyd.nix`)

## Updates

Update flake inputs:

```
nix flake update
sudo nixos-rebuild switch --flake .#shizukani-cp
```

## License

MIT
