# Personal LazyVim Config

![Neovim](https://img.shields.io/badge/Neovim-57A143?style=for-the-badge&logo=neovim&logoColor=white)
![Lua](https://img.shields.io/badge/Lua-2C2D72?style=for-the-badge&logo=lua&logoColor=white)
![Markdown](https://img.shields.io/badge/Markdown-000000?style=for-the-badge&logo=markdown&logoColor=white)

## Project Details

This is my personal Neovim setup built on top of [LazyVim](https://github.com/LazyVim/LazyVim), shaped around the way I actually like to work and the tools I use most. More than that, it is a passion project built around Ulquiorra Cifer, my favorite character from *Bleach* by Tite Kubo. I wanted the editor to feel cold, calm, and spectral without becoming tiring to look at, so I spent time refining the palette around darker surfaces, restrained accents, and clear visual separation for diagnostics, syntax groups, icons, and UI states. I also paid close attention to contrast balance and accent saturation so the theme stays comfortable during long coding sessions instead of looking good for only a few minutes.

![Neovim Theme Preview](./docs/assets/theme-preview.png)

This setup is centered around:

- LazyVim as the base distro
- Catppuccin with a custom Ulquiorra Cifer-inspired palette
- custom dashboard styling and icon colors
- language support for Angular, Docker, Helm, Java, JSON, Kotlin, Markdown, Scala, Python, Go, SQL, Terraform, TypeScript, Tailwind, YAML, GraphQL, HTML, CSS, XML, shell, and related config files

## Table of Contents

- [Setup](#setup)
- [Before Cloning](#before-cloning)
- [Clone And Start](#clone-and-start)
- [Ghostty Configuration](#ghostty-configuration)
- [Verify The Setup](#verify-the-setup)

## Setup

### Before Cloning

Make sure these are in place before replacing your current Neovim setup:

1. Install a recent version of Neovim.
2. Install `git` so `lazy.nvim` can bootstrap itself on first launch.
3. Install `node` and `npm`. They are required for Markdown preview support.
4. Install Ghostty. This setup is intended to be used in Ghostty.
5. Install a Nerd Font. This setup is intended to be used with `JetBrainsMono NFM Regular`.
6. Back up your existing Neovim config if you already have one:

```bash
mv ~/.config/nvim ~/.config/nvim.bak
mv ~/.local/share/nvim ~/.local/share/nvim.bak
mv ~/.local/state/nvim ~/.local/state/nvim.bak
mv ~/.cache/nvim ~/.cache/nvim.bak
```

### Clone And Start

Clone the repository into your Neovim config directory:

```bash
git clone https://github.com/shehanreshin/nvim-config.git ~/.config/nvim
```

Open Neovim once to let `lazy.nvim` install the plugins:

```bash
nvim
```

### Ghostty Configuration

Add the following settings to your Ghostty config file, usually `~/.config/ghostty/config`:

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

## Verify The Setup

This repository includes fixture files under `preview/` so you can confirm that the setup installed correctly and inspect how the theme behaves across different UI states.

Color and highlight check:

```vim
:luafile preview/ulquiorra.lua
```

This opens a scratch buffer that shows:

- all 26 palette colors as swatches
- diagnostics like error, warning, info, and hint
- git-style added, changed, and removed colors
- common UI highlights such as search and visual selection
- common syntax colors such as keywords, functions, strings, numbers, types, comments, and constants

Diagnostic error check:

```vim
:edit preview/syntax_errors.lua
```

This file is intentionally broken so you can inspect syntax error highlights, signs, and virtual text.

File icon check:

```vim
:Neotree dir=preview/icons
```

The `preview/icons` folder contains representative files for the file types configured in this setup so you can inspect icon glyphs and icon colors in a file explorer.
