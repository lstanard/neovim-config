-----------------------------------------------------------
-- Initialize
-----------------------------------------------------------

-- remap leader key to space key (must be set before plugins are loaded)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.opt.termguicolors = true

-- Disable git blame by default
vim.g.gitblame_enabled = 0

-- disable netrw at the very start of your init.lua (strongly advised for nvim-tree)
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

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
-- Plugins
-----------------------------------------------------------

require('lazy').setup({
  {
    'sainnhe/everforest',
    'catppuccin/nvim',
    lazy = false,
    priority = 1000,
  },
  'moll/vim-bbye',                      -- delete buffers and close files without closing window layout
  'mbbill/undotree',                    -- undo visualizer
  'tpope/vim-surround',                 -- surround selection with text (and replace surrounding chars)
  'airblade/vim-rooter',                -- change vim working directory to project root when file is opened
  'tpope/vim-commentary',               -- easily toggle comments
  'tpope/vim-unimpaired',               -- handy bracket mappings
  'prettier/vim-prettier',              -- prettier code formatting
  'kdheepak/lazygit.nvim',              -- open lazygit from within neovim
  'airblade/vim-gitgutter',             -- git status in signcolumn (also previewing and staging hunks)
  'f-person/git-blame.nvim',            -- inline git blame messages
  'nvim-tree/nvim-web-devicons',        -- icons
  'jghauser/follow-md-links.nvim',      -- open links from markdown files
  'ntpeters/vim-better-whitespace',     -- highlight and auto remove trailing whitespace
  'rcarriga/nvim-notify',               -- floating notification messages
  'kburdett/vim-nuuid',                 -- generate and insert guids
  'github/copilot.vim',                 -- github copilot integration
  'JoosepAlviste/nvim-ts-context-commentstring', -- comments in embedded languages (better support for JSX/TSX)
  {                                     -- automatically highlight other uses of word under the cursor
    'RRethy/vim-illuminate',
    config = function()
      require('illuminate').configure({
        delay = 200,
        filetypes_denylist = {
          'NvimTree',
        }
      })
    end,
  },
  {
    -- TODO: Reconfigure UFO, see https://github.com/kevinhwang91/nvim-ufo/issues/4
    'kevinhwang91/nvim-ufo',
    dependencies = 'kevinhwang91/promise-async',
  },
  {
    'folke/paint.nvim',
    config = function()
      local hlmap = {
        ["^#%s+(.-)%s*$"] = 'Error',
        ["^##%s+(.-)%s*$"] = 'Operator',
        ["^###%s+(.-)%s*$"] = 'Type',
        ["^####%s+(.-)%s*$"] = 'String',
        ["^#####%s+(.-)%s*$"] = 'Constant',
        ["^######%s+(.-)%s*$"] = 'Number',
      }

      local highlights = {}
      for pattern, hl in pairs(hlmap) do
        table.insert(highlights, {
          filter = { filetype = "markdown" },
          pattern = pattern,
          hl = hl,
        })
      end

      require("paint").setup({
        highlights = highlights,
      })
    end,
  },
  {
    'folke/twilight.nvim',
    config = function()
      require('twilight').setup()
    end,
  },
  {
    'echasnovski/mini.move',
    version = '*',
    config = function()
      require('mini.move').setup({
        mappings = {
          -- Alt key on mac requires specifying the character generated by the key combination pressed,
          -- see https://stackoverflow.com/a/5382863/1183876.

          -- Move visual selection in Visual mode
          left = '˙',     -- <Alt-h>
          right = '¬',    -- <Alt-l>
          down = '∆',     -- <Alt-j>
          up = '˚',       -- <Alt-k>
          -- Move current line in Normal mode
          line_left = '˙',  -- <Alt-h>
          line_right = '¬', -- <Alt-l>
          line_down = '∆',  -- <Alt-j>
          line_up = '˚',    -- <Alt-k>
        },
      })
    end,
  },
  {
    'simrat39/symbols-outline.nvim',
    config = function()
      require('symbols-outline').setup({})
    end,
  },
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
    dependencies = 'nvim-tree/nvim-web-devicons',
    config = function()
      require('bufferline').setup({
        options = {
          diagnostics = 'nvim_lsp',
          thin = true,
          offsets = {
            {
              filetype = 'NvimTree',
              text = ' File Explorer',
              text_align = 'left',
              highlight = 'Directory',
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
        extensions = {
          'nvim-tree',
        },
        sections = {
          lualine_a = {'mode'},
          -- Default 'lualine_b' is {'branch', 'diff', 'diagnostics'}
          -- I'm using other git integration tools and I find this is just visual clutter.
          lualine_b = {'diagnostics'},
          lualine_c = {
            {
              'filename',
              path = 1
            }
          },
          -- Default 'lualine_x' is '{'encoding', 'fileformat', 'filetype'}'
          lualine_x = {'filetype'},
          lualine_y = {'progress'},
          lualine_z = {'location'}
        },
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
        actions = {
          remove_file = {
            close_window = true,
          },
        },
        filters = {
          dotfiles = true
        },
        view = {
          width = 55,
          side = 'right',
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
  {
    'smartpde/telescope-recent-files',
    dependencies = { 'nvim-telescope/telescope.nvim' },
  },
  {
    'nvim-telescope/telescope-ui-select.nvim',
    dependencies = { 'nvim-telescope/telescope.nvim' },
  },
  -- LSP plugins
  'windwp/nvim-ts-autotag',
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    config = function()
      require('nvim-treesitter.configs').setup({
        autotag = {
          enable = true,
        },
        ensure_installed = {
          'lua',
          'vim',
          'help',
          'go',
          'python',
          'jsdoc',
          'javascript',
          'typescript',
          'css',
          'scss',
          'tsx',
          'json',
          'yaml',
          'html',
          'graphql',
          'markdown',
          'markdown_inline',
        },
        sync_install = true,
        auto_install = true,
        highlight = {
          enable = true,
          -- Treesitter messes with highlighting, may consider disabling completely
          -- disable = { 'markdown' },
        },
        indent = {
          enable = true,
        },
        incremental_selection = {
          enable = true,
        },
        context_commentstring = {
          -- See nvim-ts-context-commentstring
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
  {                                       -- LSP loading status indicator
    'j-hui/fidget.nvim',
    tag = 'legacy',
    config = function()
      require('fidget').setup({})
    end,
  },
  'neovim/nvim-lspconfig',                -- Configurations for the neovim LSP client
  {                                       -- Pretty diagnostics
    'folke/trouble.nvim',
    dependencies = {
      'nvim-tree/nvim-web-devicons',
    },
    config = function()
      require('trouble').setup({
        signs = {
          -- icons / text used for a diagnostic
          error = "",
          warning = "",
          hint = "",
          information = "",
          other = "﫠"
        }
      })
    end,
  },
});

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
    },
    file_ignore_patterns = {
      'node_modules',
      '.git',
      'yarn.lock',
    }
  },
  extensions = {
    ['ui-select'] = {
      require('telescope.themes').get_dropdown(),
    }
  }
})
require('telescope').load_extension('file_browser')
require('telescope').load_extension('recent_files')
require('telescope').load_extension('ui-select')

-- LSP and autocomplete configuration (mason, nvim-lspconfig, nvim-cmp)
require('plugins/lsp')

-----------------------------------------------------------
-- Configuration settings
-- https://neovim.io/doc/user/options.html
-----------------------------------------------------------

-- Use notify for messages
vim.notify = require('notify')

-- Other plugins can pick up on the colorscheme, specify before other options
vim.g.everforest_background = 'medium'
vim.cmd.colorscheme('everforest')

-- Colorscheme overrides
vim.cmd[[
  " everforest theme overrides
  highlight CursorLineNr guifg='#DBBC7F'
  highlight NvimTreeClosedFolderIcon guifg='#DBBC7F'
]]

-- Prettier
vim.cmd([[
  let g:prettier#autoformat = 1
  let g:prettier#autoformat_require_pragma = 0
]])

-- Whitespace fixing
vim.g.better_whitespace_enabled = 1
vim.g.strip_whitespace_on_save = 1

-- Undotree
vim.g.undotree_WindowLayout = 4
vim.g.undotree_SplitWidth = 50

-- Code folding (recommended settings for ufo)
vim.o.foldcolumn = '1' -- '0' is not bad
vim.o.foldenable = true
vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
vim.o.foldlevelstart = 99

-- General
vim.opt.autoread = true         -- automatically re-read file if a change was detected outside of vim
vim.opt.clipboard = 'unnamedplus'                   -- sync clipboard between OS and neovim
vim.opt.completeopt = 'menuone,noinsert,noselect'   -- set completeopt to have a better completion experience
vim.opt.cursorline = true       -- highlight current cursorline
vim.opt.errorbells = false      -- disable bell sound for error messages
vim.opt.hidden = true           --
vim.opt.number = true           -- always show line numbers
vim.opt.relativenumber = true   -- use relative line numbers
vim.opt.scrolloff = 3           -- minimum number of screen lines to keep above and below the cursor
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

-- Select all text in current buffer
map('n', '<leader>a', ':keepjumps normal! ggVG<cr>')

-- Toggle search highlight
map('n', '<leader>hl', ':set hlsearch! hlsearch?<cr>')

-- Strip whitespace
map('n', '<leader>sws', ':StripWhitespace<cr>')

-- Telescope
map('n', '<leader>ff', '<cmd>:Telescope find_files<cr>')
map('n', '<leader>fg', '<cmd>:Telescope live_grep<cr>')
map('n', '<leader>fu', '<cmd>:Telescope buffers<cr>')
map('n', '<leader>fb', '<cmd>:Telescope file_browser<cr>')
map('n', '<leader>fr', "[[<cmd>lua require('telescope').extensions.recent_files.pick()<cr>]]")

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
map('n', 'gY', '<cmd>TroubleToggle lsp_type_definitions<cr>')
map('n', 'gD', '<cmd>TroubleToggle lsp_definitions<cr>')

-- LSP
-- Open code actions menu (NOTE: Trouble has a 'quickfix' but I can't get it working)
map('n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<cr>', {desc = 'Show LSP code action'})
-- Show symbol signature in hover
map('n', '<leader>ch', '<cmd>lua vim.lsp.buf.hover()<cr>', {desc = 'Show symbol signature'})

-- nvim-tree
map('n', '<C-n>', '<cmd>NvimTreeToggle<cr>')
map('n', '<leader>n', '<cmd>NvimTreeFocus<cr>')
map('n', '<leader>nc', '<cmd>NvimTreeCollapse<cr>')
map('n', '<leader>nr', '<cmd>NvimTreeRefresh<cr>')
map('n', '<leader>nf', '<cmd>NvimTreeFindFile<cr>')

-- vim-bbye
map('n', '<leader>q', '<cmd>Bdelete<cr>')

-- Persistence
map('n', '<leader>qs', '[[<cmd>lua require("persistence").load()<cr>]]')
map('n', '<leader>ql', '[[<cmd>lua require("persistence").load({ last = true })<cr>]]')

-- symbols-outline
map('n', '<leader>so', '<cmd>SymbolsOutline<cr>', {desc = 'Toggle symbol outline pane'})

-- undotree
map('n', '<leader>h', '<cmd>UndotreeToggle<cr>', {desc = 'Toggle Undotree'})

-- Twilight
map('n', '<leader>t', '<cmd>Twilight<cr>', {desc = 'Toggle Twilight'})

-- illuminate
-- NOTE: These aren't working :(
map('n', '<leader>in', '[[<cmd>lua require("illuminate").goto_next_reference(false)<cr>]]')
map('n', '<leader>ip', '[[<cmd>lua require("illuminate").goto_prev_reference(false)<cr>]]')

-- Prettier
map('n', '<leader>pp', '<cmd>Prettier<cr>', {desc = 'Format with Prettier'})

-- nvim-ufo
-- map('n', 'zR', require('ufo').openAllFolds)
-- map('n', 'zM', require('ufo').closeAllFolds)

-----------------------------------------------------------
-- Custom commands
-----------------------------------------------------------

-- As of Neovim 0.7.0+ there's an API for this:
-- `vim.api.nvim_add_user_command()`, but I'm getting a diagnostic error
-- trying to use it. Defaulted to vim script wrapper.
-- See https://github.com/nanotee/nvim-lua-guide/blob/a118d6f585683a94364167d46274595b1959f089/README.md#defining-user-commands.

-- Fix issue with folding in files opened through Telescope (https://github.com/nvim-telescope/telescope.nvim/issues/699#issuecomment-1159637962)
vim.api.nvim_create_autocmd({ 'BufEnter' }, { pattern = { '*' }, command = 'normal zx', })

-- Open LuaSnip snippet editor (useful for seeing current available snippets)
vim.cmd([[command! LuaSnipEdit :lua require('luasnip.loaders').edit_snippet_files()]])

