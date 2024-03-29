return {
  {
    'goolord/alpha-nvim',
    config = function()
      local alpha = require 'alpha'
      local dashboard = require 'alpha.themes.startify'
      require('alpha').setup(require('alpha.themes.startify').config)
      dashboard.section.header.val = {
        [[                                                                       ]],
        [[                                                                       ]],
        [[                                                                       ]],
        [[                                                                       ]],
        [[                                                                     ]],
        [[       ████ ██████           █████      ██                     ]],
        [[      ███████████             █████                             ]],
        [[      █████████ ███████████████████ ███   ███████████   ]],
        [[     █████████  ███    █████████████ █████ ██████████████   ]],
        [[    █████████ ██████████ █████████ █████ █████ ████ █████   ]],
        [[  ███████████ ███    ███ █████████ █████ █████ ████ █████  ]],
        [[ ██████  █████████████████████ ████ █████ █████ ████ ██████ ]],
        [[                                                                       ]],
        [[                                                                       ]],
        [[                                                                       ]],
      }

      alpha.setup(dashboard.opts)
    end,
    dependencies = {
      { 'nvim-tree/nvim-web-devicons' },
    },
  },
  { -- possessions allows save and restore nvim sessions
    'gennaro-tedesco/nvim-possession',
    dependencies = {
      'ibhagwan/fzf-lua',
    },
    config = true,
    init = function()
      local possession = require 'nvim-possession'
      vim.keymap.set('n', '<leader>sl', function()
        possession.list()
      end)
      vim.keymap.set('n', '<leader>sN', function()
        possession.new()
      end)
      vim.keymap.set('n', '<leader>su', function()
        possession.update()
      end)
      vim.keymap.set('n', '<leader>sd', function()
        possession.delete()
      end)
    end,
  },
  { -- nvim-ansible tries to add filetype for ansible buffers
    'mfussenegger/nvim-ansible',
    event = 'VimEnter',
  },
  { -- nvim-tree.lua adds the file browser
    'nvim-tree/nvim-tree.lua',
    event = 'VimEnter',
    opts = {
      system_open = { cmd = 'flatpak-xdg-open', args = {} },
    },
    dependencies = {
      { 'nvim-tree/nvim-web-devicons' },
    },
    keys = {
      {
        '<leader>t',
        mode = { 'n' },
        function()
          require('nvim-tree.api').tree.toggle()
        end,
        desc = '[T]oggle NvimTree',
      },
      {
        -- as we don't have netew, we loose gx. Add it back:
        -- https://www.reddit.com/r/neovim/comments/11zgf64/gxnvim_open_links_and_more_without_netrw/
        -- will change in nvim 0.10.0 to vim.ui.open
        'gx',
        mode = { 'n' },
        -- function()
        --   vim.ui.open(vim.fn.expand '<cfile>')
        -- end,
        function()
          vim.fn.system { 'xdg-open', vim.fn.expand '<cfile>' }
        end,
        desc = '[X]dg Open current url',
      },
    },
  },
  { -- fugitive is the git tool
    'tpope/vim-fugitive',
  },
  {
    'kdheepak/lazygit.nvim',
    cmd = {
      'LazyGit',
      'LazyGitConfig',
      'LazyGitCurrentFile',
      'LazyGitFilter',
      'LazyGitFilterCurrentFile',
    },
    -- optional for floating window border decoration
    dependencies = {
      'nvim-lua/plenary.nvim',
    },
  },
  {
    'folke/trouble.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    opts = {},
  },
}
