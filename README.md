# Personal LazyVim Config

![Neovim](https://img.shields.io/badge/Neovim-57A143?style=for-the-badge&logo=neovim&logoColor=white)
![Lua](https://img.shields.io/badge/Lua-2C2D72?style=for-the-badge&logo=lua&logoColor=white)
![Markdown](https://img.shields.io/badge/Markdown-000000?style=for-the-badge&logo=markdown&logoColor=white)

## Project Details

This is my personal Neovim setup built on top of [LazyVim](https://github.com/LazyVim/LazyVim), shaped around the way I actually like to work and the tools I use most. More than that, it is a passion project built around Ulquiorra Cifer, my favorite character from *Bleach* by Tite Kubo. I wanted the editor to feel cold, calm, and spectral without becoming tiring to look at, so I spent time refining the palette around darker surfaces, restrained accents, and clear visual separation for diagnostics, syntax groups, icons, and UI states. I also paid close attention to contrast balance and accent saturation so the theme stays comfortable during long coding sessions instead of looking good for only a few minutes.

<img width="1430" height="793" alt="Screenshot 2026-04-01 at 14 39 47" src="https://github.com/user-attachments/assets/15cd3c51-be30-44a5-bdca-cb13bd3fa85e" /> <br />

This setup is centered around:

- LazyVim as the base distro
- Catppuccin with a custom Ulquiorra Cifer-inspired palette
- custom dashboard styling and icon colors
- language support for Angular, Docker, Helm, Java, JSON, Kotlin, Markdown, Scala, Python, Go, SQL, Terraform, TypeScript, Vue, Tailwind, YAML, GraphQL, HTML, CSS, XML, shell, and related config files

## Table of Contents

- [Setup](#setup)
- [Before Cloning](#before-cloning)
- [Clone And Start](#clone-and-start)
- [Ghostty Configuration](#ghostty-configuration)
- [Oh My Posh Configuration](#oh-my-posh-configuration)
- [Usage](#usage)
- [Verify The Setup](#verify-the-setup)

## Setup

### Before Cloning

Make sure these are in place before replacing your current Neovim setup:

1. Install a recent version of Neovim.
2. Install `git` so `lazy.nvim` can bootstrap itself on first launch.
3. Install `node` and `npm`. They are required for Markdown preview support.
4. Install Ghostty. This setup is intended to be used in Ghostty.
5. Install a Nerd Font. This setup is intended to be used with `JetBrainsMono NFM Regular`.
6. Install [Oh My Posh](https://github.com/JanDeDobbeleer/oh-my-posh).
7. If you want to use `htmx-lsp`, install Rust so `cargo` is available in your `PATH`: https://www.rust-lang.org/tools/install
8. Back up your existing Neovim config if you already have one:

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

If your Ghostty config directory does not exist yet, create it first. Then copy the theme file from [ghostty/themes/Ulquiorra](/Users/shehanreshin/.config/nvim/ghostty/themes/Ulquiorra) into your Ghostty themes directory:

```bash
mkdir -p ~/.config/ghostty/themes
cp ~/.config/nvim/ghostty/themes/Ulquiorra ~/.config/ghostty/themes/Ulquiorra
```

You can then enable the theme in either of these ways.

Option 1: edit your Ghostty config file, usually `~/.config/ghostty/config`, and add:

```ini
font-family = "JetBrainsMono NFM Regular"
cursor-style = block
copy-on-select = clipboard
font-size = 18
window-padding-x = 10
window-padding-y = 10
window-decoration = true
window-padding-balance = true
theme = Ulquiorra
macos-titlebar-style = transparent
background-blur = 90
background-opacity = 0.82
maximize = true
window-save-state = always
```

Option 2: open Ghostty Settings and add the following line there:

```ini
theme = Ulquiorra
```

Restart Ghostty or reload its config after making the change.

### Oh My Posh Configuration

Then copy the theme file from [oh-my-posh/ZSHThemes.json](/Users/shehanreshin/.config/nvim/oh-my-posh/ZSHThemes.json) into your home directory. Create the file if it does not exist yet:

```bash
cp ~/.config/nvim/oh-my-posh/ZSHThemes.json ~/ZSHThemes.json
```

If your `~/.zshrc` already points Oh My Posh to `~/ZSHThemes.json`, reload Zsh to apply the changes:

```bash
source ~/.zshrc
```

If it does not, add this line to `~/.zshrc` first:

```bash
eval "$(oh-my-posh init zsh --config ~/ZSHThemes.json)"
```

Then reload Zsh:

```bash
source ~/.zshrc
```

## Usage

This config uses `Space` as the leader key. So mappings like `<leader>ff` mean `Space`, then `f`, then `f`.

This setup uses `Snacks` for both the picker and the file explorer, so the common shortcuts below are based on that rather than Telescope or Neo-tree.

### Files And Search

- `Space ff`: find files in the project root
- `Space fF`: find files in the current working directory
- `Space fc`: find a file inside the Neovim config
- `Space fr`: open recent files
- `Space /`: grep in the project root
- `Space sg`: grep in the project root
- `Space sb`: search inside the current buffer
- `Space sB`: grep across all open buffers
- `Space sw`: search for the word under cursor or the current visual selection
- `Space ,`: switch buffers
- `Space fe`: open the file explorer at the project root
- `Space fE`: open the file explorer at the current working directory

### File Explorer

- `j` / `k`: move through files
- `l`: open file or expand directory
- `h`: collapse directory
- `Enter`: confirm selection
- `q`: close the picker or explorer

### Code Navigation

- `gd`: go to definition
- `gr`: show references
- `gI`: go to implementation
- `gy`: go to type definition
- `gD`: go to declaration
- `K`: hover documentation
- `gK`: signature help
- `Ctrl-k` in insert mode: signature help while typing
- `[[` / `]]`: jump between references of the symbol under cursor

### Traversing Through Code Efficiently

For normal movement, this config is built around `h`, `j`, `k`, and `l`, with the arrow keys disabled so navigation stays consistent.

- `h` / `l`: move left or right by one character
- `j` / `k`: move down or up
- `w`: jump to the next word
- `b`: jump back by one word
- `e`: jump to the end of the current or next word
- `0`: jump to the start of the line
- `^`: jump to the first non-whitespace character on the line
- `$`: jump to the end of the line
- `gg`: jump to the top of the file
- `G`: jump to the bottom of the file
- `%`: jump between matching brackets or parentheses
- `n` / `N`: move to the next or previous search result

Examples:

```text
w       move forward one word
3w      move forward three words
b       move back one word
e       move to the end of the word
```

```text
0       start of line
^       first non-space on the line
$       end of line
```

```text
gg      top of file
G       bottom of file
25G     jump to line 25
```

Search-based movement is usually the fastest way to move through large files.

- `/text`: search forward for `text`
- `?text`: search backward for `text`
- `n`: go to the next match
- `N`: go to the previous match
- `Space ff`: find files quickly
- `Space /` or `Space sg`: search across the project
- `Space sb`: fuzzy-search lines in the current file
- `Space sB`: search across all currently open files
- `Space sw`: search for the word under cursor

Examples:

```text
/UserService
n
n
```

That jumps to the first `UserService`, then the next two matches.

Use LSP navigation when you want semantic jumps instead of text-based movement.

- `gd`: jump to where something is defined
- `gr`: list all references
- `gI`: jump to implementation
- `gy`: jump to type definition
- `gD`: jump to declaration
- `K`: inspect docs for the symbol under cursor

Example:

```text
Put the cursor on a function name
gd
```

That jumps straight to its definition even if it is in another file.

When moving around multiple open windows and files:

- `Ctrl-h` / `Ctrl-j` / `Ctrl-k` / `Ctrl-l`: move between splits
- `Shift-h` / `Shift-l`: move between buffers
- `Space bb`: jump back to the previous buffer
- `Space fe`: open the explorer and move with `j` / `k`, open with `l`, close folders with `h`

Example workflow:

```text
Space ff       find a file
gd             jump to definition
Ctrl-o         jump back
gr             inspect references
Shift-l        move to the next buffer
```

For selecting and editing efficiently:

- `v`: start characterwise visual mode
- `V`: start linewise visual mode
- `y`: copy
- `d`: delete
- `x`: cut/delete the selected text or current character
- `p`: paste after cursor
- `P`: paste before cursor
- `u`: undo
- `U`: redo
- `Alt-j` / `Alt-k`: move lines or selected blocks

Examples:

```text
viw     select inner word
yiw     copy inner word
diw     delete inner word
```

```text
Vjj     select this line and the next two lines
>       indent selection
<       outdent selection
```

Replace selected text with copied text:

```text
yiw     copy a word
viw     select another word
p       replace the selected word with what you copied
```

Cut selected text:

```text
viw     select inner word
d       cut it
```

Delete selected text without leaving visual mode first:

```text
v...    make a visual selection
d       delete it
```

Delete everything in the current file:

```text
ggVGd
```

That jumps to the top of the file, selects everything, and deletes it.

Delete all lines in the current file with an Ex command:

```text
:%d
```

Replace all matches in the current file:

```text
:%s/old/new/g
```

Replace all matches with confirmation:

```text
:%s/old/new/gc
```

### Code Actions And Refactoring

- `Space ca`: code actions
- `Space cr`: rename symbol
- `Space cR`: rename file
- `Space cA`: source actions
- `Space cf`: format current buffer or selection
- `Space cd`: show line diagnostics
- `[d` / `]d`: previous or next diagnostic
- `[e` / `]e`: previous or next error
- `[w` / `]w`: previous or next warning

### Autocompletion

- `Enter`: accept the current completion item
- `Ctrl-y`: also accept the current completion item
- `Ctrl-e`: dismiss the current suggestion without leaving insert mode
- `Ctrl-Space`: show completion
- `Ctrl-n` / `Ctrl-p`: move to next or previous suggestion

### Windows, Splits, And Tabs

- `Ctrl-h` / `Ctrl-j` / `Ctrl-k` / `Ctrl-l`: move between splits
- `Space -`: horizontal split
- `Space |`: vertical split
- `Space wd`: close current split
- `Ctrl-Up` / `Ctrl-Down`: resize split height
- `Ctrl-Left` / `Ctrl-Right`: resize split width
- `Space Tab Tab`: open a new tab
- `Space Tab d`: close current tab
- `Space Tab [` / `Space Tab ]`: previous or next tab

### Buffers And Terminal

- `Shift-h` / `Shift-l`: previous or next buffer
- `Space bb`: switch to the previous buffer
- `Space bd`: close current buffer
- `Space bo`: close all other buffers
- `Space ft`: open terminal in the project root
- `Space fT`: open terminal in the current working directory
- `Ctrl-/`: toggle the floating terminal

### Editing Basics

- `v`: start characterwise visual selection
- `V`: start linewise visual selection
- `yy`: copy the current line
- `p`: paste after the cursor
- `P`: paste before the cursor
- `dd`: delete the current line
- `x`: delete the character under cursor
- `u`: undo in normal mode
- `U`: redo in normal mode
- `Ctrl-u` in insert mode: undo the last change without leaving insert mode
- `>` / `<` in visual mode: indent or outdent while keeping the selection active
- `Alt-j` / `Alt-k`: move the current line or selected block down or up

### Save And Quit

- `Ctrl-s`: save file
- `Space qq`: quit Neovim
- `Esc`: clear search highlight and return to normal mode

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

Vue file check:

```vim
:edit preview/vue/App.vue
```

This gives you a standalone Vue single-file component outside the mixed icon-fixture folder, so the Vue LSP can attach under a normal project context.
