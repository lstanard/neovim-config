-----------------------------------------------------------
-- Initialize
-----------------------------------------------------------

-- remap leader key to space key (must be set before plugins are loaded)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-----------------------------------------------------------
-- Initialize lazy.vim plugin manager
-----------------------------------------------------------

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-----------------------------------------------------------
-- Specify plugins
-----------------------------------------------------------

require('lazy').setup({
  -- colorschemes
  {
    'catppuccin/nvim',
    lazy = false,
    priority = 1000,
  },
});

vim.cmd.colorscheme('catppuccin-frappe')

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
vim.opt.list = true                   -- show whitespace characters
vim.opt.listchars = 'space:·,tab:-→'  -- characters to use for whitespace
vim.opt.shiftwidth = 2                -- width for autoindent
vim.opt.smartindent = true            -- TODO: add description
vim.opt.softtabstop = 2               -- TODO: add description
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

