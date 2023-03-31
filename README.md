# Neovim Configuration

Personal neovim configuration, written in Lua.

## Requirements

- neovim (version 0.8 or higher)
- [ripgrep](https://github.com/BurntSushi/ripgrep) (for Telescope live grep)
- node (version 16 or higher)
- [lazygit](https://github.com/jesseduffield/lazygit)
- prettier (optional, for automatic code formatting)

## Installation

1. Clone repo
2. Symlink configuration - `ln -s ~/repo/path ~/.config/nvim`
3. Open neovim to install all plugins

## Commonly used key mappings

| keys        | mapping                           |
| ----------- | --------------------------------- |
| \<leader>qq | Quit                              |
| \<leader>ca | Show LSP code actions             |
| \<leader>ch | Show LSP symbol signature         |
| \<leader>hl | Toggle search highlight           |
| \<leader>a  | Select all text in current buffer |
| \<leader>ws | Toggle show whitespace characters |

## Plugins

### Navigation

#### [Telescope](https://github.com/nvim-telescope/telescope.nvim)

| keys        | mapping                 |
| ----------- | ----------------------- |
| \<C-t>      | Go to file in a new tab |
| \<leader>ff | File finder             |
| \<leader>fg | Live grep               |
| \<leader>fu | Open buffer browser     |

#### [Telescope file browser](https://github.com/nvim-telescope/telescope-file-browser.nvim)

| keys        | mapping                     |
| ----------- | --------------------------- |
| \<leader>fb | Open file browser           |
| \<C-h>      | Toggle hidden files/folders |

#### [Telescope recent files](https://github.com/smartpde/telescope-recent-files)

| keys        | mapping                   |
| ----------- | ------------------------- |
| \<leader>fr | Open recent files browser |

#### [nvim-tree](https://github.com/nvim-tree/nvim-tree.lua)

| keys        | mapping                   |
| ----------- | ------------------------- |
| \<C-n>      | Toggle file explorer      |
| \<leader>n  | Focus file explorer       |
| \<leader>nc | Collapse tree recursively |
| \<leader>nr | Refresh tree              |

#### [symbols-outline](https://github.com/simrat39/symbols-outline.nvim)

| keys        | mapping                    |
| ----------- | -------------------------- |
| \<leader>so | Toggle symbol outline pane |

### Session management

#### [vim-bbye](https://github.com/moll/vim-bbye)

| keys       | mapping                              |
| ---------- | ------------------------------------ |
| \<leader>q | Delete buffer without closing window |

#### [Persistence](https://github.com/folke/persistence.nvim)

| keys        | mapping                               |
| ----------- | ------------------------------------- |
| \<leader>qs | Restore session for current directory |
| \<leader>ql | Restore last session                  |

### Code and text editing

#### [Trouble](https://github.com/folke/trouble.nvim)

| keys        | mapping                             |
| ----------- | ----------------------------------- |
| \<leader>xx | TroubleToggle                       |
| \<leader>xw | TroubleToggle Workspace Diagnostics |
| \<leader>xd | TroubleToggle Document Diagnostics  |
| \<leader>xl | TroubleToggle Location List         |
| \<leader>xq | TroubleToggle Quick Fix             |
| gR          | LSP References                      |
| gY          | LSP Type Definitions                |
| gD          | LSP Definitions                     |

#### [vim-commentary](https://github.com/airblade/vim-gitgutter)

- `gcc` to comment out a line
- `gc{motion}` to comment target of a motion
  - Example: `gcj10` to comment out current line and next 10 lines

#### [vim-surround](https://github.com/airblade/vim-gitgutter)

- `cs"'` would replace double quotes with single quotes
- `ds"` would remove double quotes around a string
- `ysiw]` would surround current text with square brackets
  - Use `]` for no space, and `[` to enter space inside the brackets around text
- `S` in visual mode – `S<p class="important">` would wrap selected line with a `<p>` tag that includes a class

### Git integration

#### [git-blame](https://github.com/f-person/git-blame.nvim)

Inline git blame message.

| keys        | mapping          |
| ----------- | ---------------- |
| \<leader>gb | Toggle git blame |

#### [LazyGit](https://github.com/kdheepak/lazygit.nvim)

LazyGit integration for neovim.

| keys | mapping      |
| ---- | ------------ |
| Lg   | Open LazyGit |

#### [vim-gitgutter](https://github.com/airblade/vim-gitgutter)

Git status symbols in the sign column.

| keys        | mapping       |
| ----------- | ------------- |
| [c          | Previous hunk |
| ]c          | Next hunk     |
| \<leader>hp | Preview hunk  |
| \<leader>hs | Stage hunk    |
| \<leader>hu | Undo hunk     |
