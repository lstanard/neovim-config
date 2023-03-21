-----------------------------------------------------------
-- Initialize
-----------------------------------------------------------

-- remap leader key to space key (must be set before plugins are loaded)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.opt.termguicolors = true

-- Disable git blame by default
vim.g.gitblame_enabled = 0

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
    'sainnhe/everforest',
    lazy = false,
    priority = 1000,
  },
  'moll/vim-bbye',                      -- delete buffers and close files without closing window layout
  'tpope/vim-surround',                 -- surround selection with text
  'tpope/vim-commentary',               -- easily toggle comments
  'prettier/vim-prettier',              -- prettier code formatting
  'kdheepak/lazygit.nvim',              -- open lazygit from within neovim
  'airblade/vim-gitgutter',             -- git status in signcolumn (also previewing and staging hunks)
  'f-person/git-blame.nvim',            -- inline git blame messages
  'nvim-tree/nvim-web-devicons',        -- icons
  'jghauser/follow-md-links.nvim',      -- open links from markdown files
  'ntpeters/vim-better-whitespace',     -- highlight and auto remove trailing whitespace
  'rcarriga/nvim-notify',               -- floating notification messages
  {
    'folke/persistence.nvim',
    event = 'BufReadPre',
    config = function()
      require('persistence').setup({})
    end,
  },
  {                                     -- highlight TODO comments
    'folke/todo-comments.nvim',
      config = function() require('todo-comments').setup({
        keywords = {
          TODO = {icon = ' ', color = 'todo'},
        },
        colors = {
          todo = {'DiagnosticInfo', '#3a94c5'},
          hint = {'DiagnosticHint', '#35a77c'}
        }
      })
    end,
  },
  {                                     -- improved startup time
    'lewis6991/impatient.nvim',
    config = function() require('impatient') end,
  },
  {                                     -- marks in signcolumn
    'chentoast/marks.nvim',
    config = function() require('marks').setup() end,
  },
  {
    'akinsho/bufferline.nvim',
    config = function()
      require('bufferline').setup({
        options = {
          diagnostics = "nvim_lsp",
          thin = true,
          offsets = {
            {
              filetype = "NvimTree",
              text = " File Explorer",
              text_align = "left",
              highlight = "Directory",
              separator = false
            }
          }
        },
        highlights = {
          fill = {
            -- Background fill color that looks best with 'everforest' theme
            bg = '#232A2E',
          },
        },
      })
    end,
  },
  {
    'folke/which-key.nvim',
    config = function() require('which-key').setup({}) end,
  },
  {
    'windwp/nvim-autopairs',
    config = function() require('nvim-autopairs').setup({}) end,
  },
  {
    'nvim-lualine/lualine.nvim',
    config = function()
      require('lualine').setup({
        options = {
          -- Themes: https://github.com/nvim-lualine/lualine.nvim/blob/master/THEMES.md
          theme = 'everforest',
        }
      })
    end,
  },
  {
    'nvim-tree/nvim-tree.lua',
    config = function()
      require('nvim-tree').setup({
        sort_by = 'case_sensitive',
        renderer = {
          group_empty = true,
        },
        filters = {
          dotfiles = true
        },
        view = {
          width = 45
        },
      })
    end,
  },
  -- Telescope and extensions
  {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.1',
    dependencies = { 'nvim-lua/plenary.nvim' },
  },
  {
    'nvim-telescope/telescope-file-browser.nvim',
    dependencies = { 'nvim-lua/plenary.nvim', 'nvim-telescope/telescope.nvim' },
  },
  -- LSP plugins
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    config = function()
      require('nvim-treesitter.configs').setup({
        ensure_installed = {
          'lua',
          'vim',
          'help',
          'python',
          'javascript',
          'typescript',
          'tsx',
          'json',
          'yaml',
        },
        sync_install = true,
        auto_install = true,
        highlight = {
          enable = true,
        },
        indent = {
          enable = true,
        },
        incremental_selection = {
          enable = true,
        },
      })
    end,
  },
  'rafamadriz/friendly-snippets',
  {
    'hrsh7th/nvim-cmp',
    dependencies = {
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-cmdline',
      'L3MON4D3/LuaSnip',
      'saadparwaiz1/cmp_luasnip',
    },
  },
  'williamboman/mason.nvim',              -- Package manager for Neovim LSPs (and linters)
  'williamboman/mason-lspconfig.nvim',    -- Mason extension for better integration with nvim-lspconfig
  'folke/neodev.nvim',                    -- Neovim setup for init.lua and plugin development
  'j-hui/fidget.nvim',                    -- LSP loading status indicator
  'neovim/nvim-lspconfig',                -- Configurations for the neovim LSP client
  {                                       -- Pretty diagnostics
    'folke/trouble.nvim',
    config = function()
      require('trouble').setup({})
    end,
  },
});

-- Use notify for messages
vim.notify = require("notify")

-- Load Telescope and extensions
require('telescope').setup({
  pickers = {
    find_files = {
      hidden = true
    },
  },
  defaults = {
    layout_strategy = 'vertical',
    layout_config = {
      height = 0.75,
      width = 0.5,
    }
  }
})
require('telescope').load_extension('file_browser')

-- LSP and autocomplete configuration (mason, nvim-lspconfig, nvim-cmp)
require('plugins/lsp')

-- Other plugins can pick up on the colorscheme, specify before other options
vim.cmd.colorscheme('everforest')

-- Fix issue with folding in files opened through Telescope (https://github.com/nvim-telescope/telescope.nvim/issues/699#issuecomment-1159637962)
vim.api.nvim_create_autocmd({ 'BufEnter' }, { pattern = { '*' }, command = 'normal zx', })

-- Whitespace fixing
vim.g.better_whitespace_enabled = 1
vim.g.strip_whitespace_on_save = 1

-- Prettier
vim.cmd([[
  let g:prettier#autoformat = 1
  let g:prettier#autoformat_require_pragma = 0
]])

-----------------------------------------------------------
-- Neovim config settings
-- https://neovim.io/doc/user/options.html
-----------------------------------------------------------

-- Code folding
vim.opt.foldmethod = 'expr'     -- fold method to use
vim.opt.foldexpr = 'nvim_treesitter#foldexpr()'     -- fold expression
vim.opt.foldenable = false      -- enable folding by default
vim.opt.foldlevel = 5           -- level to being folding code by default

-- General
vim.opt.autoread = true         -- automatically re-read file if a change was detected outside of vim
vim.opt.clipboard = 'unnamedplus'                   -- sync clipboard between OS and neovim
vim.opt.completeopt = 'menuone,noinsert,noselect'   -- set completeopt to have a better completion experience
vim.opt.cursorline = true       -- highlight current cursorline
vim.opt.errorbells = false      -- disable bell sound for error messages
vim.opt.hidden = true           --
vim.opt.number = true           -- always show line numbers
vim.opt.relativenumber = true   -- use relative line numbers
vim.opt.showmatch = true        -- highlight matching brackets
vim.opt.showmode = true         -- show vim mode in status line (default true)
vim.opt.signcolumn = 'yes'      -- always show the sign column
vim.opt.splitbelow = true       -- set preview window to appear at bottom
vim.opt.splitright = true       -- set preview window to appear on right
vim.opt.syntax = 'on'           -- enable syntax highlighting
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
map('n', '<C-h>', '<C-w>h', {desc = 'Focus window left'})
map('n', '<C-j>', '<C-w>j', {desc = 'Focus window down'})
map('n', '<C-k>', '<C-w>k', {desc = 'Focus window up'})
map('n', '<C-l>', '<C-w>l', {desc = 'Focus window right'})

-- Change split orientation
map('n', '<leader>tk', '<C-w>t<C-w>K') -- change vertical to horizontal
map('n', '<leader>th', '<C-w>t<C-w>H') -- change horizontal to vertical

-- Map 'esc' to kk
map('i', 'kk', '<Esc>')

-- Quit
map('n', '<leader>qq', ':qa!<cr>')

-- Write buffer
map('n', '<leader>w', ':w<cr>')
-- Write all buffers
map('n', '<leader>ww', ':wa<cr>')
-- Close (destroy) buffer
map('n', '<leader>bd', ':bd<cr>')

-- Toggle show whitespace
map('n', '<leader>ws', ':set list!<cr>')
-- Strip whitespace
map('n', '<leader>sws', ':StripWhitespace<cr>')

-- Select all text in current buffer
map('n', '<leader>a', ':keepjumps normal! ggVG<cr>')

-- Toggle search highlight
map('n', '<leader>hl', ':set hlsearch! hlsearch?<cr>')

-- Telescope
map('n', '<leader>ff', '<cmd>:Telescope find_files<cr>')
map('n', '<leader>fg', '<cmd>:Telescope live_grep<cr>')
map('n', '<leader>fu', '<cmd>:Telescope buffers<cr>')
map('n', '<leader>fb', '<cmd>:Telescope file_browser<cr>')

-- LazyGit
map('n', 'Lg', '<cmd>LazyGit<cr>')

-- git-blame
map('n', '<leader>gb', '<cmd>GitBlameToggle<cr>')

-- Trouble
map('n', '<leader>xx', '<cmd>TroubleToggle<cr>')
map('n', '<leader>xw', '<cmd>TroubleToggle workspace_diagnostics<cr>')
map('n', '<leader>xd', '<cmd>TroubleToggle document_diagnostics<cr>')
map('n', '<leader>xl', '<cmd>TroubleToggle loclist<cr>')
map('n', '<leader>xq', '<cmd>TroubleToggle quickfix<cr>')
map('n', 'gR', '<cmd>TroubleToggle lsp_references<cr>')

-- LSP
-- Open code actions menu (NOTE: Trouble has a 'quickfix' but I can't get it working)
map('n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<cr>', {desc = 'Show LSP code action'})

-- nvim-tree
map('n', '<C-n>', '<cmd>NvimTreeToggle<cr>')
map('n', '<leader>n', '<cmd>NvimTreeFocus<cr>')
map('n', '<leader>nc', '<cmd>NvimTreeCollapse<cr>')
map('n', '<leader>nr', '<cmd>NvimTreeRefresh<cr>')

-- vim-bbye
map('n', '<leader>q', '<cmd>Bdelete<cr>')

-- Persistence
map('n', '<leader>qs', '[[<cmd>lua require("persistence").load()<cr>]]')
map('n', '<leader>ql', '[[<cmd>lua require("persistence").load({ last = true })<cr>]]')

