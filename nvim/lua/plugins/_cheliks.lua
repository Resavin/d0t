return {
  -- { "ellisonleao/gruvbox.nvim" },

  { "LnL7/vim-nix" },
  -- { "neoclide/coc.nvim" },
  { "mattn/emmet-vim" },

  -- { "karb94/neoscroll.nvim"},

  { "barrett-ruth/live-server.nvim" },
  { "ziontee113/color-picker.nvim" },
  { "chriskempson/base16-vim" },
  { "ayu-theme/ayu-vim" },
  { "sainnhe/sonokai" },
  { "sainnhe/everforest" },
  { "sainnhe/edge" },
  -- { "aglepnir/dashboard-nvim" },
  -- { "catpuccin/nvim", name = "catpuccin" },
  { "famiu/bufdelete.nvim" },
  { "Everblush/nvim", name = "everblush" },
  -- {
  --   "NTBBloodbath/doom-one.nvim",
  --   init = function()
  --     -- Add color to cursor
  --     vim.g.doom_one_cursor_coloring = false
  --     -- Set :terminal colors
  --     vim.g.doom_one_terminal_colors = true
  --     -- Enable italic comments
  --     vim.g.doom_one_italic_comments = true
  --     -- Enable TS support
  --     vim.g.doom_one_enable_treesitter = true
  --     -- Color whole diagnostic text or only underline
  --     vim.g.doom_one_diagnostics_text_color = false
  --     -- Enable transparent background
  --     vim.g.doom_one_transparent_background = false
  --
  --     -- Pumblend transparency
  --     vim.g.doom_one_pumblend_enable = false
  --     vim.g.doom_one_pumblend_transparency = 20
  --
  --     -- Plugins integration
  --     vim.g.doom_one_plugin_neorg = true
  --     vim.g.doom_one_plugin_barbar = false
  --     vim.g.doom_one_plugin_telescope = false
  --     vim.g.doom_one_plugin_neogit = true
  --     vim.g.doom_one_plugin_nvim_tree = true
  --     vim.g.doom_one_plugin_dashboard = true
  --     vim.g.doom_one_plugin_startify = true
  --     vim.g.doom_one_plugin_whichkey = true
  --     vim.g.doom_one_plugin_indent_blankline = true
  --     vim.g.doom_one_plugin_vim_illuminate = true
  --     vim.g.doom_one_plugin_lspsaga = false
  --   end,
  -- },
  { "sainnhe/gruvbox-material" },
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    opts = function(_, opts)
      table.insert(opts.sections.lualine_x, "😄")
    end,
  },

  {
    "neovim/nvim-lspconfig",
    ---@class PluginLspOpts
    opts = {
      ---@type lspconfig.options
      servers = {
        -- pyright will be automatically installed with mason and loaded with lspconfig
        -- rnix-lsp = {},
      },
    },
  },

  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        -- "stylua",
        "shellcheck",
        "shfmt",
      },
    },
  },
  -- add more treesitter parsers
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "bash",
        "vimdoc",
        "html",
        "javascript",
        "json",
        "lua",
        "markdown",
        "markdown_inline",
        "python",
        "query",
        "regex",
        "tsx",
        "typescript",
        "vim",
        "yaml",
      },
    },
  },
  -- {"tombh/novim-mode"},
  { "mfussenegger/nvim-dap" },
}
