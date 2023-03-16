-----------------------------------------------------------
-- Initialize
-----------------------------------------------------------

-- remap leader key to space key (must be set before plugins are loaded)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-----------------------------------------------------------
-- Initialize lazy.vim plugin manager
-----------------------------------------------------------

local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'

if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', -- latest stable release
    lazypath,
  })
end

vim.opt.rtp:prepend(lazypath)

-----------------------------------------------------------
-- Specify plugins
-----------------------------------------------------------

require('lazy').setup({
  {
    'catppuccin/nvim',
    lazy = false,
    priority = 1000,
  },
  'folke/which-key.nvim',
  'tpope/vim-commentary',
  'windwp/nvim-autopairs',
  'airblade/vim-gitgutter',
  'nvim-lualine/lualine.nvim',
  'ntpecers/vim-better-whitespace',
  {
    'nvcm-treesitter/nvim-treesitter',
    build = ':TSUpdate'
  },
});

-- Other plugins can pick up on the colorscheme, specify before other options
vim.cmd.colorscheme('catppuccin-frappe')

-- lualine configuration
-- Themes: https://github.com/nvim-lualine/lualine.nvim/blob/master/THEMES.md
require('lualine').setup({
  options = {
    theme = 'nightfly',
  }
})

require('nvim-treesitter.configs').setup({
  ensure_installed = { 'lua', 'vim', 'help' },
  sync_install = true,
  auto_install = true,
  highlight = {
    enable = true,
  },
  indent = {
    enable = true,
  },
})

-- Treesitter code folding
vim.opt.foldmethod = 'expr'
vim.opt.foldexpr = 'nvim_treesitter#foldexpr()'
vim.opt.foldenable = false

require('nvim-autopairs').setup({})

require('which-key').setup({})

vim.g.better_whitespace_enabled = 1
vim.g.strip_whitespace_on_save = 1

-----------------------------------------------------------
-- Neovim config settings
-- https://neovim.io/doc/user/options.html
-----------------------------------------------------------

-- General
vim.opt.autoread = true         -- automatically re-read file if a change was detected outside of vim
-- vim.opt.cc = '90'            -- set an 90 column border
vim.opt.clipboard = 'unnamedplus'                   -- sync clipboard between OS and neovim
vim.opt.completeopt = 'menuone,noinsert,noselect'   -- set completeopt to have a better completion experience
vim.opt.cursorline = true       -- highlight current cursorline
vim.opt.errorbells = false      -- disable bell sound for error messages
-- vim.opt.mouse = 'v'          -- enable mouse (in visual mode)
vim.opt.hidden = true           -- TODO: understand this better
vim.opt.number = true           -- always show line numbers
vim.opt.relativenumber = true   -- use relative line numbers
vim.opt.showmatch = true        -- highlight matching brackets
vim.opt.showmode = true         -- show vim mode in status line (default true)
vim.opt.signcolumn = 'yes'      -- always show the sign column
vim.opt.splitbelow = true       -- set preview window to appear at bottom
vim.opt.splitright = true       -- set preview window to appear on right
vim.opt.syntax = 'on'           -- enable syntax highlighting
vim.opt.termguicolors = true    -- colorscheme support
vim.opt.updatetime = 100        -- how many milliseconds to wait between keystrokes before performing certain actions

-- File locations
vim.opt.backupdir = vim.fn.stdpath('config') .. '/backupdir'  -- location for backup files
vim.opt.directory = vim.fn.stdpath('config') .. '/swapdir'    -- location for swap files
vim.opt.undodir = vim.fn.stdpath('config') .. '/undodir'      -- location for undo files
vim.opt.undofile = true     -- automatically save undo history to an undofile

-- Search
vim.opt.hlsearch = false    -- highlight results of previous search
vim.opt.ignorecase = true   -- ignore uppercase letters when executing search
vim.opt.incsearch = true    -- highlight pattern matches while typing search
vim.opt.smartcase = true    -- make search ignore uppercase letters unless the search term has uppercase

-- Whitespace and indentation
vim.opt.autoindent = true             -- copy indent from current line when starting a new line
vim.opt.breakindent = true            -- preserve indentation of virtual lines
vim.opt.expandtab = true              -- converts tabs to white space
vim.opt.list = false                  -- show whitespace characters
vim.opt.listchars = 'space:·,tab:-→'  -- characters to use for whitespace
vim.opt.shiftwidth = 2                -- width for autoindent
vim.opt.smartindent = true            -- do smart autoindent when starting a new line
vim.opt.softtabstop = 2               -- number of spaces that a <Tab> counts for
vim.opt.tabstop = 2                   -- number of columns occupied by a tab
vim.opt.wrap = true                   -- wrap long lines

-----------------------------------------------------------
-- Key mappings
-----------------------------------------------------------

local function map(mode, lhs, rhs, opts)
  local options = { noremap=true, silent=true }
  if opts then
    options = vim.tbl_extend('force', options, opts)
  end
  vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

-- Disable arrow keys
map('', '<up>', '<nop>')
map('', '<down>', '<nop>')
map('', '<left>', '<nop>')
map('', '<right>', '<nop>')

-- Move around splits using Ctrl + {h,j,k,l}
map('n', '<C-h>', '<C-w>h')
map('n', '<C-j>', '<C-w>j')
map('n', '<C-k>', '<C-w>k')
map('n', '<C-l>', '<C-w>l')

-- Map 'esc' to kk
map('n', 'kk', '<Esc>')

-- Write buffer
map('n', '<leader>w', ':w<cr>')
-- Write all buffers
map('n', '<leader>ww', ':wa<cr>')

-- Toggle show whitespace
map('n', '<leader>ws', ':set list!<cr>')
-- Strip whitespace
map('n', '<leader>sws', ':StripWhitespace<cr>')

