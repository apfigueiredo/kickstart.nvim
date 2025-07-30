-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
--
return {
  { 'akinsho/bufferline.nvim', opts = {} },
  { 'github/copilot.vim' },
  { 'nmac427/guess-indent.nvim', opts = {} },
  { 'NeogitOrg/neogit', dependencies = {
    'sindrets/diffview.nvim',
    'nvim-lua/plenary.nvim',
  } },
  {
    'benlubas/neorg-interim-ls',
  },
  {
    'nvim-neorg/neorg',
    lazy = false, -- Disable lazy loading as some `lazy.nvim` distributions set `lazy = true` by default
    version = '*', -- Pin Neorg to the latest stable release
    config = true,
    opts = function()
      require('neorg').setup {
        load = {
          ['core.defaults'] = {}, -- Load all the default modules
          ['core.concealer'] = {}, -- Adds pretty icons to your documents
          ['external.interim-ls'] = {},
          ['core.completion'] = {
            config = { engine = { module_name = 'external.lsp-completion' } },
          },
          ['core.dirman'] = {
            config = {
              workspaces = {
                personal = '~/notes/personal',
                work = '~/notes/work',
              },
              default_workspace = 'personal',
            },
          },
        },
      }
      vim.keymap.set('n', '<leader>ni', '<cmd>Neorg index<cr>', { desc = '[neorg] Open Index' })
      vim.keymap.set('n', '<leader>nt', '<cmd>Neorg journal today<cr>', { desc = '[neorg] Open Today Journal' })
    end,
  },
  { 'akinsho/toggleterm.nvim', version = '*', opts = {} },
  {
    'MeanderingProgrammer/render-markdown.nvim',
    dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' },
    opts = function()
      require('render-markdown').setup {
        completions = { lsp = { enabled = true } },
      }
    end,
  },
  {
    'yetone/avante.nvim',
    build = function()
      return 'make'
    end,
    event = 'VeryLazy',
    version = false,
    opts = {
      provider = 'copilot',
    },
    dependencies = {
      'nvim-treesitter/nvim-treesitter',
      'nvim-lua/plenary.nvim',
      'MunifTanjim/nui.nvim',
      'zbirenbaum/copilot.lua',
    },
  },
  {
    'zbirenbaum/copilot.lua',
    opts = function()
      require('copilot.api').status = require 'copilot.status'
    end,
  },
  {
    'folke/flash.nvim',
    event = 'VeryLazy',
    ---@type Flash.Config
    opts = {},
    -- stylua: ignore
    keys = {
      { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
      { "S", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
      { "r", mode = "o", function() require("flash").remote() end, desc = "Remote Flash" },
      { "R", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
      { "<c-s>", mode = { "c" }, function() require("flash").toggle() end, desc = "Toggle Flash Search" },
    },
  },
  {
    'folke/edgy.nvim',
    event = 'VeryLazy',
    init = function()
      vim.opt.laststatus = 3
      vim.opt.splitkeep = 'screen'
    end,
    opts = {
      bottom = {
        {
          ft = 'toggleterm',
          size = { height = 0.4 },
          filter = function(buf, win)
            return vim.api.nvim_win_get_config(win).relative == ''
          end,
        },
        {
          ft = 'lazyterm',
          title = 'LazyTerm',
          size = { height = 0.4 },
          filter = function(buf)
            return not vim.b[buf].lazyterm_cmd
          end,
        },
        'Trouble',
        { ft = 'qf', title = 'QuickFix' },
        {
          ft = 'help',
          size = { height = 20 },
          filter = function(buf)
            return vim.bo[buf].buftype == 'help'
          end,
        },
      },
      left = {
        {
          title = 'Neo-Tree',
          ft = 'neo-tree',
          filter = function(buf)
            return vim.b[buf].neo_tree_source == 'filesystem'
          end,
          size = { height = 0.5 },
        },
        {
          title = 'Neo-Tree Git',
          ft = 'neo-tree',
          filter = function(buf)
            return vim.b[buf].neo_tree_source == 'git_status'
          end,
          pinned = true,
          collapsed = true,
          open = 'Neotree position=right git_status',
        },
        {
          title = 'Neo-Tree Symbols',
          ft = 'neo-tree',
          filter = function(buf)
            return vim.b[buf].neo_tree_source == 'document_symbols'
          end,
          pinned = true,
          collapsed = true,
          open = 'Neotree position=top document_symbols',
        },
      },
    },
  },
  {
    'folke/noice.nvim',
    event = 'VeryLazy',
    opts = {
      -- add any options here
      lsp = {
        -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
        override = {
          ['vim.lsp.util.convert_input_to_markdown_lines'] = true,
          ['vim.lsp.util.stylize_markdown'] = true,
          ['cmp.entry.get_documentation'] = true, -- requires hrsh7th/nvim-cmp
        },
      },
      -- you can enable a preset for easier configuration
      presets = {
        bottom_search = true, -- use a classic bottom cmdline for search
        command_palette = true, -- position the cmdline and popupmenu together
        long_message_to_split = true, -- long messages will be sent to a split
        inc_rename = false, -- enables an input dialog for inc-rename.nvim
        lsp_doc_border = false, -- add a border to hover docs and signature help
      },
    },
    dependencies = {
      -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
      'MunifTanjim/nui.nvim',
      -- OPTIONAL:
      --   `nvim-notify` is only needed, if you want to use the notification view.
      --   If not available, we use `mini` as the fallback
      'rcarriga/nvim-notify',
    },
  },
}
