# Personal LazyVim Config

This repository contains my personal Neovim configuration built on top of the [LazyVim](https://github.com/LazyVim/LazyVim) distro. It keeps the LazyVim defaults as the base and layers on my own language extras, tooling, and editor preferences.

## Before Cloning

Make sure these are in place before replacing your current Neovim setup:

1. Install a recent version of Neovim.
2. Install `git` so `lazy.nvim` can bootstrap itself on first launch.
3. Install a Nerd Font. This setup is intended to be used with `JetBrainsMono NFM Regular`.
4. Back up your existing Neovim config if you already have one:

```bash
mv ~/.config/nvim ~/.config/nvim.bak
mv ~/.local/share/nvim ~/.local/share/nvim.bak
mv ~/.local/state/nvim ~/.local/state/nvim.bak
mv ~/.cache/nvim ~/.cache/nvim.bak
```

## Clone And Start

Clone the repository into your Neovim config directory:

```bash
git clone https://github.com/shehanreshin/nvim-config.git ~/.config/nvim
```

Open Neovim once to let `lazy.nvim` install the plugins:

```bash
nvim
```

## Ghostty Settings

If you use Ghostty, add the following settings to your Ghostty config file, usually `~/.config/ghostty/config`:

```ini
font-family = "JetBrainsMono NFM Regular"
cursor-style = block
copy-on-select = clipboard
font-size = 18
window-padding-x = 10
window-padding-y = 10
window-decoration = true
window-padding-balance = true
theme = Catppuccin Mocha
macos-titlebar-style = transparent
background-blur = 90
background-opacity = 0.82
maximize = true
window-save-state = always
```
