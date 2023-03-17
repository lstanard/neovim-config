# Neovim Configuration

Personal neovim configuration, written in Lua.

## Requirements

- neovim (version 0.8 or higher)
- node (version 16 or higher)
- [ripgrep](https://github.com/BurntSushi/ripgrep)
- prettier (optional for automatic code formatting)

## Plugins

### Navigation

#### Telescope

### Code and text editing

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

#### vim-gitgutter

> [Plugin reference](https://github.com/airblade/vim-gitgutter)

| keys         | mapping                                |
| ------------ | -------------------------------------- |
| [c           | Previous hunk                          |
| ]c           | Next hunk                              |
| \<leader>hp  | Preview hunk                           |
| \<leader>hs  | Stage hunk                             |
| \<leader>hu  | Undo hunk                              |

