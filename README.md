# Neovim Configuration

Personal neovim configuration, written in Lua.

## Requirements

- neovim (version 0.8 or higher)
- [ripgrep](https://github.com/BurntSushi/ripgrep) (for Telescope live grep)
- node (version 16 or higher)
- prettier (optional, for automatic code formatting)

## Installation

1. Clone repo
2. Symlink configuration - `ln -s ~/repo/path ~/.config/nvim`

## Plugins

### Navigation

#### Telescope

> [Plugin reference](https://github.com/nvim-telescope/telescope.nvim)

| keys        | mapping                 |
| ----------- | ----------------------- |
| \<C-t>      | Go to file in a new tab |
| \<leader>ff | File finder             |
| \<leader>fg | Live grep               |
| \<leader>fu | Open buffer browser     |

##### File Browser extension

> [Plugin reference](https://github.com/nvim-telescope/telescope-file-browser.nvim)

| keys        | mapping                     |
| ----------- | --------------------------- |
| \<leader>fb | Open file browser           |
| \<C-h>      | Toggle hidden files/folders |

#### nvim-tree

> [Plugin reference](https://github.com/nvim-tree/nvim-tree.lua)

| keys        | mapping                   |
| ----------- | ------------------------- |
| \<C-n>      | Toggle file explorer      |
| \<leader>n  | Focus file explorer       |
| \<leader>nc | Collapse tree recursively |
| \<leader>nr | Refresh tree              |

### Code and text editing

#### Trouble

> [Plugin reference](https://github.com/folke/trouble.nvim)

#### vim-commentary

> [Plugin reference](https://github.com/airblade/vim-gitgutter)

- `gcc` to comment out a line
- `gc{motion}` to comment target of a motion
  - Example: `gcj10` to comment out current line and next 10 lines

#### vim-surround

> [Plugin reference](https://github.com/airblade/vim-gitgutter)

- `cs"'` would replace double quotes with single quotes
- `ds"` would remove double quotes around a string
- `ysiw]` would surround current text with square brackets
  - Use `]` for no space, and `[` to enter space inside the brackets around text
- `S` in visual mode – `S<p class="important">` would wrap selected line with a `<p>` tag that includes a class

### Git integration

#### LazyGit

> [Plugin reference](https://github.com/kdheepak/lazygit.nvim)

| keys        | mapping      |
| ----------- | ------------ |
| \<leader>Lg | Open LazyGit |

#### vim-gitgutter

> [Plugin reference](https://github.com/airblade/vim-gitgutter)

| keys        | mapping       |
| ----------- | ------------- |
| [c          | Previous hunk |
| ]c          | Next hunk     |
| \<leader>hp | Preview hunk  |
| \<leader>hs | Stage hunk    |
| \<leader>hu | Undo hunk     |
