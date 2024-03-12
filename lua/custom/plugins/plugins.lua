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
    config = function()
      require('nvim-tree').setup {
        vim.keymap.set('n', '<leader>t', require('nvim-tree.api').tree.toggle, { desc = '[T]oggle NvimTree' }),
      }
    end,
    dependencies = {
      { 'nvim-tree/nvim-web-devicons' },
    },
  },
  { -- fugitive is the git tool
    'tpope/vim-fugitive',
  },
}
