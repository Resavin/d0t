-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")
-- require in lua
-- single lua file or a folder with init.lua which requires single lua files
require("live-server").setup()
-- require("neoscroll").setup({
--   -- All these keys will be mapped to their corresponding default scrolling animation
--   mappings = { "<C-u>", "<C-d>", "<C-b>", "<C-f>", "<C-y>", "<C-e>", "zt", "zz", "zb" },
--   hide_cursor = true, -- Hide cursor while scrolling
--   stop_eof = false, -- Stop at <EOF> when scrolling downwards
--   respect_scrolloff = false, -- Stop scrolling when the cursor reaches the scrolloff margin of the file
--   cursor_scrolls_alone = true, -- The cursor will keep on scrolling even if the window cannot scroll further
--   easing_function = nil, -- Default easing function
--   pre_hook = nil, -- Function to run before the scrolling animation starts
--   post_hook = nil, -- Function to run after the scrolling animation ends
--   performance_mode = false, -- Disable "Performance Mode" on all buffers.
-- })
-- eof and cursor don't work????
-- for some reason before I did this <C-u> couldn't go to the top, if there was little space (for example if you were on the second line and pressed <C-u> it wouldn't go to the first line). But now it is working always (with, without extensions (neoscroll and mini-animate), with or without opts when just installing the plugin, with or without setup here, maybe if I require wrong then it would work like this? Vrode net)
-- require("lspconfig").clangd.setup({})
require("lspconfig").clangd.setup({
  on_attach = on_attach,
  capabilities = capabilities,
  filetypes = { "c", "cpp", "objc", "objcpp", "cuda", "proto" },
  -- root_dir = require("lspconfig").util.root_pattern('.git', '.clangd-format', '.gitignore'),
  cmd = { "clangd" },
  log_file = "/tmp/clangd.log",
  log_level = 5,
})
require("color-picker")
-- require('lualine').setup({
--     options = { 'theme': 'everblush' }
-- })
require("everblush").setup({

  -- Default options
  override = {},
  transparent_background = false,
  nvim_tree = {
    contrast = false,
  },

  -- Configuration examples

  -- Override the default highlights using Everblush or other colors
  override = {
    -- Normal = { fg = "#000000", bg = "000000" },
    Normal = { bg = "#192730" },
  },

  -- Set transparent background
  transparent_background = false,

  -- Set contrast for nvim-tree highlights
  nvim_tree = {
    contrast = true,
  },
})
require("dap")
vim.cmd("colorscheme everforest")
