local function gh(repo) return 'https://github.com/' .. repo end

-- vim.pack.add { { src = gh 'junegunn/fzf' } }

-- Nvim-possession: session management
vim.pack.add { gh 'gennaro-tedesco/nvim-possession', gh 'ibhagwan/fzf-lua' }
require('nvim-possession').setup({})
require('fzf-lua').setup({})

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

-- nvim-ansible plugin for filetype detection and task execution
vim.pack.add { { src = gh 'mfussenegger/nvim-ansible', type = 'start' } }
vim.pack.add { { src = gh 'fcharlier/neovim-ansible-vault' } }
vim.pack.add { { src = gh 'SalOrak/ansible-doc.nvim', type = 'start' } }
require('ansible-doc').setup({})

-- Set up ansible keymaps for yaml.ansible files
vim.api.nvim_create_autocmd('FileType', {
  pattern = 'yaml.ansible',
  callback = function()
    vim.keymap.set('v', '<leader>te', function()
      require('ansible').run()
    end, { buffer = true, silent = true, desc = 'Run ansible task (visual)' })
    vim.keymap.set('n', '<leader>te', ":w<CR> :lua require('ansible').run()<CR>", { buffer = true, silent = true, desc = 'Run ansible task' })
    vim.keymap.set('n', '<leader>ad', ':AnsibleDoc<CR>', { buffer = true, silent = true, desc = 'Ansible doc fuzzy search' })
    vim.keymap.set('n', '<leader>aD', function()
      local word = vim.fn.expand('<cWORD>')
      word = word:gsub(':$', '')
      require('ansible-doc').ansible_doc({}, word)
    end, { buffer = true, silent = true, desc = 'Ansible doc for word under cursor' })
    vim.keymap.set('n', 'K', function()
      local word = vim.fn.expand('<cword>')
      local result = vim.system({ 'ansible-doc', word }, { text = true }):wait()
      if result.code ~= 0 or not result.stdout or result.stdout == '' then
        vim.notify('No ansible-doc for: ' .. word, vim.log.levels.WARN)
        return
      end
      vim.cmd('new')
      local buf = vim.api.nvim_get_current_buf()
      vim.bo[buf].buftype = 'nofile'
      vim.bo[buf].bufhidden = 'wipe'
      vim.bo[buf].swapfile = false
      vim.bo[buf].filetype = 'yaml'
      vim.api.nvim_buf_set_lines(buf, 0, -1, false, vim.split(result.stdout, '\n'))
      vim.bo[buf].modifiable = false
    end, { buffer = true, silent = true, desc = 'Ansible doc in scratch buffer' })
  end,
})



-- Nvim-tree: file browser
vim.pack.add { gh 'nvim-tree/nvim-tree.lua' }
require('nvim-tree').setup()

-- Key mappings
vim.keymap.set('n', '<leader>t', function()
  require('nvim-tree.api').tree.toggle()
end, { desc = '[T]oggle NvimTree' })

-- gx keymap to open URLs
vim.keymap.set('n', 'gx', function()
  vim.fn.system { 'xdg-open', vim.fn.expand '<cfile>' }
end, { desc = '[X]dg Open current url' })

-- Fugitive: git integration
vim.pack.add { gh 'tpope/vim-fugitive' }

-- LazyGit: terminal UI for git
vim.pack.add { gh 'kdheepak/lazygit.nvim', gh 'nvim-lua/plenary.nvim' }

-- Trouble: diagnostics list
vim.pack.add { gh 'folke/trouble.nvim' }
require('trouble').setup({})

-- Obsidian: markdown note-taking
vim.pack.add { gh 'epwalsh/obsidian.nvim' }
require('obsidian').setup({
  workspaces = {
    {
      name = 'cool-lab',
      path = '~/Seafile/EMEA-Demo-Labs Docs/EMEA-Demo-Labs SE/',
    },
    {
      name = 'llm-wiki',
      path = '~/src/openshift-llm-wiki/wiki/',
    },
  },
})

-- Zoom: window zoom toggle
vim.pack.add { gh 'oberblastmeister/zoom.nvim' }

-- Opencode: AI code assistant
vim.pack.add { gh 'nickjvandyke/opencode.nvim', gh 'folke/snacks.nvim' }
require('snacks').setup({
  input = {},
  picker = {
    actions = {
      opencode_send = function(...)
        return require('opencode').snacks_picker_send(...)
      end,
    },
    win = {
      input = {
        keys = {
          ['<a-a>'] = { 'opencode_send', mode = { 'n', 'i' } },
        },
      },
    },
  },
})

---@type opencode.Opts
vim.g.opencode_opts = {
  -- Your configuration, if any; goto definition on the type or field for details
}

vim.o.autoread = true -- Required for `opts.events.reload`

-- Recommended/example keymaps
vim.keymap.set({ 'n', 'x' }, '<C-a>', function()
  require('opencode').ask('@this: ', { submit = true })
end, { desc = 'Ask opencode…' })
vim.keymap.set({ 'n', 'x' }, '<C-x>', function()
  require('opencode').select()
end, { desc = 'Execute opencode action…' })
vim.keymap.set({ 'n', 't' }, '<C-.>', function()
  require('opencode').toggle()
end, { desc = 'Toggle opencode' })

vim.keymap.set({ 'n', 'x' }, 'go', function()
  return require('opencode').operator '@this '
end, { desc = 'Add range to opencode', expr = true })
vim.keymap.set('n', 'goo', function()
  return require('opencode').operator '@this ' .. '_'
end, { desc = 'Add line to opencode', expr = true })

vim.keymap.set('n', '<S-C-u>', function()
  require('opencode').command 'session.half.page.up'
end, { desc = 'Scroll opencode up' })
vim.keymap.set('n', '<S-C-d>', function()
  require('opencode').command 'session.half.page.down'
end, { desc = 'Scroll opencode down' })

-- You may want these if you use the opinionated `<C-a>` and `<C-x>` keymaps above — otherwise consider `<leader>o…` (and remove terminal mode from the `toggle` keymap)
vim.keymap.set('n', '+', '<C-a>', { desc = 'Increment under cursor', noremap = true })
vim.keymap.set('n', '-', '<C-x>', { desc = 'Decrement under cursor', noremap = true })

vim.api.nvim_create_autocmd("BufReadPost", {
  group = vim.api.nvim_create_augroup("RestoreCursorLocation", { clear = true }),
  callback = function()
    local mark = vim.api.nvim_buf_get_mark(0, '"')
    local lcount = vim.api.nvim_buf_line_count(0)
    if mark[1] > 0 and mark[1] <= lcount then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
  }
)

