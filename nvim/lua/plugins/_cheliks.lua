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
  { "Djancyp/better-comments.nvim" },
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
  { "ThePrimeagen/vim-be-good" },
  -- {"tombh/novim-mode"},
  -- { "mfussenegger/nvim-dap" },
  -- { "mfussenegger/nvim-dap-python" },
  --
  -- {
  --   "folke/which-key.nvim",
  --   opts = {
  --     defaults = {
  --       ["<leader>d"] = { name = "+debug" },
  --       ["<leader>da"] = { name = "+adapters" },
  --     },
  --   },
  -- },
  -- {
  --   "theHamsta/nvim-dap-virtual-text",
  --   opts = {},
  -- },
  -- {
  --   "rcarriga/nvim-dap-ui",
  -- -- stylua: ignore
  -- keys = {
  --   { "<leader>du", function() require("dapui").toggle({ }) end, desc = "Dap UI" },
  --   { "<leader>de", function() require("dapui").eval() end, desc = "Eval", mode = {"n", "v"} },
  -- },
  --   opts = {},
  --   config = function(_, opts)
  --     local dap = require("dap")
  --     local dapui = require("dapui")
  --     dapui.setup(opts)
  --     dap.listeners.after.event_initialized["dapui_config"] = function()
  --       dapui.open({})
  --     end
  --     dap.listeners.before.event_terminated["dapui_config"] = function()
  --       dapui.close({})
  --     end
  --     dap.listeners.before.event_exited["dapui_config"] = function()
  --       dapui.close({})
  --     end
  --   end,
  -- },
  -- {
  --   "mfussenegger/nvim-dap",
  --
  --   dependencies = {
  --
  --     -- fancy UI for the debugger
  --     {
  --       "rcarriga/nvim-dap-ui",
  --     -- stylua: ignore
  --     keys = {
  --       { "<leader>du", function() require("dapui").toggle({ }) end, desc = "Dap UI" },
  --       { "<leader>de", function() require("dapui").eval() end, desc = "Eval", mode = {"n", "v"} },
  --     },
  --       opts = {},
  --       config = function(_, opts)
  --         local dap = require("dap")
  --         local dapui = require("dapui")
  --         dapui.setup(opts)
  --         dap.listeners.after.event_initialized["dapui_config"] = function()
  --           dapui.open({})
  --         end
  --         dap.listeners.before.event_terminated["dapui_config"] = function()
  --           dapui.close({})
  --         end
  --         dap.listeners.before.event_exited["dapui_config"] = function()
  --           dapui.close({})
  --         end
  --       end,
  --     },
  --
  --     -- virtual text for the debugger
  --     {
  --       "theHamsta/nvim-dap-virtual-text",
  --       opts = {},
  --     },
  --
  --     -- which key integration
  --     {
  --       "folke/which-key.nvim",
  --       opts = {
  --         defaults = {
  --           ["<leader>d"] = { name = "+debug" },
  --           ["<leader>da"] = { name = "+adapters" },
  --         },
  --       },
  --     },
  --
  -- -- stylua: ignore
  -- keys = {
  --   { "<leader>dB", function() require("dap").set_breakpoint(vim.fn.input('Breakpoint condition: ')) end, desc = "Breakpoint Condition" },
  --   { "<leader>db", function() require("dap").toggle_breakpoint() end, desc = "Toggle Breakpoint" },
  --   { "<leader>dc", function() require("dap").continue() end, desc = "Continue" },
  --   { "<leader>dC", function() require("dap").run_to_cursor() end, desc = "Run to Cursor" },
  --   { "<leader>dg", function() require("dap").goto_() end, desc = "Go to line (no execute)" },
  --   { "<leader>di", function() require("dap").step_into() end, desc = "Step Into" },
  --   { "<leader>dj", function() require("dap").down() end, desc = "Down" },
  --   { "<leader>dk", function() require("dap").up() end, desc = "Up" },
  --   { "<leader>dl", function() require("dap").run_last() end, desc = "Run Last" },
  --   { "<leader>do", function() require("dap").step_out() end, desc = "Step Out" },
  --   { "<leader>dO", function() require("dap").step_over() end, desc = "Step Over" },
  --   { "<leader>dp", function() require("dap").pause() end, desc = "Pause" },
  --   { "<leader>dr", function() require("dap").repl.toggle() end, desc = "Toggle REPL" },
  --   { "<leader>ds", function() require("dap").session() end, desc = "Session" },
  --   { "<leader>dt", function() require("dap").terminate() end, desc = "Terminate" },
  --   { "<leader>dw", function() require("dap.ui.widgets").hover() end, desc = "Widgets" },
  -- },
  --
  --     config = function()
  --       local Config = require("lazyvim.config")
  --       vim.api.nvim_set_hl(0, "DapStoppedLine", { default = true, link = "Visual" })
  --
  --       for name, sign in pairs(Config.icons.dap) do
  --         sign = type(sign) == "table" and sign or { sign }
  --         vim.fn.sign_define(
  --           "Dap" .. name,
  --           { text = sign[1], texthl = sign[2] or "DiagnosticInfo", linehl = sign[3], numhl = sign[3] }
  --         )
  --       end
  --     end,
  --   },
  -- },
}
