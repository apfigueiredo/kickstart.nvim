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
  { 'akinsho/toggleterm.nvim', version = '*', opts = {} },
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
}
