---@type ChadrcConfig
local M = {}
vim.g.transparency = false
function toggle_transparency()
  print("gleb")
  vim.cmd('edit ~/.config/nvim/lua/custom/chadrc.lua')
  if vim.g.transparency then
    vim.api.nvim_feedkeys('2j2Wciwfalse', 'n', false)
  else
    vim.api.nvim_feedkeys('2j2Wciwtrue', 'n', false)
  end
  local esc = vim.api.nvim_replace_termcodes('<ESC>',true,false,true)
  local enter = vim.api.nvim_replace_termcodes('<CR>',true,false,true)
  local space = vim.api.nvim_replace_termcodes('<Space>',true,false,true)
  vim.api.nvim_feedkeys(esc,'m',false)
  vim.api.nvim_feedkeys(':w', 'n', false)
  vim.api.nvim_feedkeys(space, 'n', false)
  vim.api.nvim_feedkeys(enter,'m',false)
  vim.api.nvim_feedkeys(space, 'm', false)
  vim.api.nvim_feedkeys('x', 'm', false)

end
-- Path to overriding theme and highlights files
local highlights = require "custom.highlights"

M.ui = {
  theme = "ayu_dark",
  theme_toggle = { "ayu_dark", "ayu_dark" },

  hl_override = highlights.override,
  hl_add = highlights.add,
  -- nvdash (dashboard)
  nvdash = {
    load_on_startup = false,

    header = {
      "           ▄ ▄                   ",
      "       ▄   ▄▄▄     ▄ ▄▄▄ ▄ ▄     ",
      "       █ ▄ █▄█ ▄▄▄ █ █▄█ █ █     ",
      "    ▄▄ █▄█▄▄▄█ █▄█▄█▄▄█▄▄█ █     ",
      "  ▄ █▄▄█ ▄ ▄▄ ▄█ ▄▄▄▄▄▄▄▄▄▄▄▄▄▄  ",
      "  █▄▄▄▄ ▄▄▄ █ ▄ ▄▄▄ ▄ ▄▄▄ ▄ ▄ █ ▄",
      "▄ █ █▄█ █▄█ █ █ █▄█ █ █▄█ ▄▄▄ █ █",
      "█▄█ ▄ █▄▄█▄▄█ █ ▄▄█ █ ▄ █ █▄█▄█ █",
      "    █▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄█ █▄█▄▄▄█    ",
    },

    buttons = {
      { "  Find File", "Spc f f", "Telescope find_files" },
      { "󰈚  Recent Files", "Spc f o", "Telescope oldfiles" },
      { "󰈭  Find Word", "Spc f w", "Telescope live_grep" },
      { "  Bookmarks", "Spc m a", "Telescope marks" },
      { "  Themes", "Spc t h", "Telescope themes" },
      { "  Mappings", "Spc c h", "NvCheatsheet" },
      { "s  Load last session", "Spc s", "SessionManager load_last_session" },
    },
  },
  -- changed_themes = {
  --   ayu_dark = {
  --     base_30 = {
  --       grey_fg = "#D3D3D3", --changed in highlights
  --     },
  --   },
  -- },
  transparency = vim.g.transparency,
  statusline = {
    separator_style = "block",
    theme = "vscode_colored",
  },
}

M.plugins = "custom.plugins"

-- check core.mappings for table structure
M.mappings = require "custom.mappings"
return M
