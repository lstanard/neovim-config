# Neovim Configuration

Personal neovim configuration, written in Lua with a focus on front-end development.

Uses [lazy.nvim](https://github.com/folke/lazy.nvim) plugin manager and Everforest color scheme.

## Requirements

- neovim (version 0.8 or higher)
- [ripgrep](https://github.com/BurntSushi/ripgrep) (for Telescope live grep)
- node (version 16 or higher)
- [Nerd Fonts](https://github.com/ryanoasis/nerd-fonts)
  - https://github.com/ryanoasis/nerd-fonts#option-4-homebrew-fonts
- [lazygit](https://github.com/jesseduffield/lazygit)
- prettier (optional, for automatic code formatting)

## Installation

1. Clone repo
2. Symlink configuration - `ln -s ~/repo/path ~/.config/nvim`
3. Open neovim to install all plugins, then restart

## Commonly used key mappings

| keys        | mapping                             |
| ----------- | ----------------------------------- |
| \<leader>qq | Quit                                |
| \<leader>ca | Show LSP code actions               |
| \<leader>ch | Show LSP symbol signature           |
| [d          | Move to previous diagnostic         |
| ]d          | Move to next diagnostic             |
| \<leader>hl | Toggle search highlight             |
| \<leader>a  | Select all text in current buffer   |
| \<leader>ws | Toggle show whitespace characters   |
| \<leader>tk | Change vertical split to horizontal |
| \<leader>th | Change horizontal split to vertical |

## Plugins

### Navigation

#### [Telescope](https://github.com/nvim-telescope/telescope.nvim)

File finder, previewer, and picker.

| keys        | mapping                 |
| ----------- | ----------------------- |
| \<C-t>      | Go to file in a new tab |
| \<leader>ff | File finder             |
| \<leader>fg | Live grep               |
| \<leader>fu | Open buffer browser     |

#### [Telescope file browser](https://github.com/nvim-telescope/telescope-file-browser.nvim)

File browser extension for Telescope.

| keys        | mapping                     |
| ----------- | --------------------------- |
| \<leader>fb | Open file browser           |
| \<C-h>      | Toggle hidden files/folders |

#### [Telescope recent files](https://github.com/smartpde/telescope-recent-files)

Recent file browser extension for Telescope.

| keys        | mapping                   |
| ----------- | ------------------------- |
| \<leader>fr | Open recent files browser |

#### [nvim-tree](https://github.com/nvim-tree/nvim-tree.lua)

File explorer tree.

| keys        | mapping                   |
| ----------- | ------------------------- |
| \<C-n>      | Toggle file explorer      |
| \<leader>n  | Focus file explorer       |
| \<leader>nc | Collapse tree recursively |
| \<leader>nr | Refresh tree              |

#### [symbols-outline](https://github.com/simrat39/symbols-outline.nvim)

Tree-like symbol view.

> See [default keymaps](https://github.com/simrat39/symbols-outline.nvim#default-keymaps)

| keys        | mapping                    |
| ----------- | -------------------------- |
| \<leader>so | Toggle symbol outline pane |

### Session management

#### [vim-bbye](https://github.com/moll/vim-bbye)

Delete buffers without messing up window layouts.

| keys       | mapping                              |
| ---------- | ------------------------------------ |
| \<leader>q | Delete buffer without closing window |

#### [Persistence](https://github.com/folke/persistence.nvim)

Session management.

| keys        | mapping                               |
| ----------- | ------------------------------------- |
| \<leader>qs | Restore session for current directory |
| \<leader>ql | Restore last session                  |

### Code and text editing

#### [Trouble](https://github.com/folke/trouble.nvim)

A pretty list for showing diagnostics, references, telescope results, quickfix and location lists.

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

#### [vim-commentary](https://github.com/tpope/vim-commentary)

Easily comment and un-comment code.

| keys       | mapping                    |
| ---------- | -------------------------- |
| gcc        | Comment out a line         |
| gc{motion} | Comment target of a motion |

#### [vim-surround](https://github.com/airblade/vim-gitgutter)

Change, add, and remove surrounding characters.

| keys                                  | mapping                               |
| ------------------------------------- | ------------------------------------- |
| S                                     | In visual mode - wrap selected text   |
| cs{existing character}{new character} | Replace surrounding characters        |
| ds{existing character}                | Remove surrounding characters         |
| ysiw{surrounding character}           | Surround current text with characters |

Examples:

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

### Miscellaneous

#### [Twilight](https://github.com/folke/twilight.nvim)

Dim inactive portions of code.

| keys       | mapping         |
| ---------- | --------------- |
| \<leader>t | Toggle Twilight |
