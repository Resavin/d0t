local overrides = require("custom.configs.overrides")
---@type NvPluginSpec[]
local plugins = {
	{
		"folke/trouble.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		opts = {
			-- your configuration comes here
			-- or leave it empty to use the default settings
			-- refer to the configuration section below
		},
    event = "VeryLazy",
	},
	{
		"stevearc/dressing.nvim",
		opts = {},
	},
	{
		"echasnovski/mini.indentscope",
		event = { "BufReadPre", "BufNewFile" },
		opts = {
			-- symbol = "▏",
			symbol = "│",
			options = { try_as_border = true },
		},
		init = function()
			vim.api.nvim_create_autocmd("FileType", {
				pattern = {
					"help",
					"alpha",
					"dashboard",
					"neo-tree",
					"Trouble",
					"lazy",
					"mason",
					"notify",
					"toggleterm",
					"lazyterm",
				},
				callback = function()
					vim.b.miniindentscope_disable = true
				end,
			})
		end,
	},
	-- {
	-- 	"huy-hng/anyline.nvim",
	-- 	dependencies = { "nvim-treesitter/nvim-treesitter" },
	-- 	config = true,
	-- 	event = "VeryLazy",
	-- },
	-- {
	--   "jackMort/ChatGPT.nvim",
	--   event = "VeryLazy",
	--   config = function()
	--     require("chatgpt").setup {
	--       api_key_cmd = "cat /home/unizoro/openai_key",
	--     }
	--   end,
	--   dependencies = {
	--     "MunifTanjim/nui.nvim",
	--     "nvim-lua/plenary.nvim",
	--     "nvim-telescope/telescope.nvim",
	--   },
	--   -- opts = { -- didn't work maybe because of the setup() fucntion call earlier
	--   --   api_key_cmd = "cat ~/openai_key"
	--   -- }
	-- },
	{
		"alexghergh/nvim-tmux-navigation",
		lazy = false,
		config = function(_, opts)
			require("nvim-tmux-navigation").setup({
				disable_when_zoomed = true, -- defaults to false
				keybindings = {
					left = "<C-h>",
					down = "<C-j>",
					up = "<C-k>",
					right = "<C-l>",
					last_active = "<C-\\>",
					next = "<C-Space>",
				},
			})
		end,
	},
	{
		"nvim-telescope/telescope-file-browser.nvim",
		dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" },
	},
	-- {
	--   "folke/trouble.nvim",
	--   dependencies = { "nvim-tree/nvim-web-devicons" },
	--   opts = {
	--     -- your configuration comes here
	--     -- or leave it empty to use the default settings
	--     -- refer to the configuration section below
	--   },
	-- },
	{ "mhinz/vim-startify", lazy = false },
	{
		"Shatur/neovim-session-manager",
		-- lazy = false,
		config = function(_, opts)
			require("session_manager").setup(require("custom.configs.sessions"))
		end,
	},
	{
		"rcarriga/nvim-dap-ui",
		dependencies = "mfussenegger/nvim-dap",
		config = function()
			local dap = require("dap")
			local dapui = require("dapui")
			dapui.setup()
			dap.listeners.after.event_initialized["dapui_config"] = function()
				dapui.open()
			end
		end,
	},
	{
		"mfussenegger/nvim-dap",
		config = function(_, opts)
			require("core.utils").load_mappings("dap")
		end,
	},
	{
		"mfussenegger/nvim-dap-python",
		ft = "python",
		dependencies = {
			"mfussenegger/nvim-dap",
			"rcarriga/nvim-dap-ui",
		},
		config = function(_, opts)
			local path = "~/.local/share/nvim/mason/packages/debugpy/venv/bin/python"
			require("dap-python").setup(path)
			require("core.utils").load_mappings("dap_python")
		end,
	},
	-- { "echasnovski/mini.nvim", version = false },
	{
		"echasnovski/mini.animate",
		-- version = false,
		lazy = false,
		config = function(_, opts)
			require("mini.animate").setup()
		end,
	},
	-- Override plugin definition options

	{
		"neovim/nvim-lspconfig",
		dependencies = {
			-- format & linting
			{
				"jose-elias-alvarez/null-ls.nvim",
				config = function()
					require("custom.configs.null-ls")
				end,
			},
		},
		config = function()
			require("plugins.configs.lspconfig")
			require("custom.configs.lspconfig")
		end, -- Override to setup mason-lspconfig
	},

	-- override plugin configs
	{
		"williamboman/mason.nvim",
		opts = overrides.mason,
	},

	{
		"nvim-treesitter/nvim-treesitter",
		opts = overrides.treesitter,
	},

	{
		"nvim-tree/nvim-tree.lua",
		opts = overrides.nvimtree,
	},

	-- Install a plugin
	{
		"max397574/better-escape.nvim",
		event = "InsertEnter",
		config = function()
			require("better_escape").setup()
		end,
	},

	-- To make a plugin not be loaded
	-- {
	--   "NvChad/nvim-colorizer.lua",
	--   enabled = false
	-- },

	-- All NvChad plugins are lazy-loaded by default
	-- For a plugin to be loaded, you will need to set either `ft`, `cmd`, `keys`, `event`, or set `lazy = false`
	-- If you want a plugin to load on startup, add `lazy = false` to a plugin spec, for example
	-- {
	--   "mg979/vim-visual-multi",
	--   lazy = false,
	-- }
}

return plugins
