require "custom.options"

local autocmd = vim.api.nvim_create_autocmd
vim.api.nvim_create_user_command("ShowRootHighlightUnderCursor", function()
  local function findRoot(id, tree)
    local transId = vim.fn.synIDtrans(id)
    local name = vim.fn.synIDattr(id, "name")
    table.insert(tree, name)

    if id == transId then
      print(table.concat(tree, " -> "))
    else
      findRoot(transId, tree)
    end
  end

  local id = vim.fn.synID(vim.fn.line ".", vim.fn.col ".", 0)
  findRoot(id, {})
end, {})
-- Auto resize panes when resizing nvim window
autocmd("VimResized", {
  pattern = "*",
  -- command = "tabdo wincmd =",
  command = "set formatoptions-=c formatoptions-=r formatoptions-=o",
})
autocmd("Filetype", {
  pattern = "*",
  command = "set formatoptions-=c formatoptions-=r formatoptions-=o",
  -- for some reason this didn't work with BufEnter and BufWinEnter on the first buffer
})
-- vim.cmd "autocmd BufWinEnter * set formatoptions-=cro"
-- vim.cmd "autocmd BufWinEnter * setlocal formatoptions-=cro"
vim.cmd "au BufRead,BufNewFile *.yer set filetype=yer"

-- This is from nvchad api functions to hide unchanged buffers
-- vim.api.nvim_create_autocmd({ "BufAdd", "BufEnter", "tabnew" }, {
--   callback = function()
--     vim.t.bufs = vim.tbl_filter(function(bufnr)
--       return vim.api.nvim_buf_get_option(bufnr, "modified")
--     end, vim.t.bufs)
--   end,
-- })

vim.g.vscode_snippets_path = "/home/unizoro/snippets"
local g = vim.g

g.startify_custom_header = {
  "",
  "",
  "                                       ██            ",
  "                                      ░░             ",
  "    ███████   █████   ██████  ██    ██ ██ ██████████ ",
  "   ░░██░░░██ ██░░░██ ██░░░░██░██   ░██░██░░██░░██░░██",
  "    ░██  ░██░███████░██   ░██░░██ ░██ ░██ ░██ ░██ ░██",
  "    ░██  ░██░██░░░░ ░██   ░██ ░░████  ░██ ░██ ░██ ░██",
  "    ███  ░██░░██████░░██████   ░░██   ░██ ███ ░██ ░██",
  "   ░░░   ░░  ░░░░░░  ░░░░░░     ░░    ░░ ░░░  ░░  ░░ ",
  "",
  "",
}
g.webdevicons_enable_startify = 1
g.startify_enable_special = 0
g.startify_session_autoload = 1
g.startify_session_delete_buffers = 1
g.startify_change_to_vcs_root = 1
g.startify_fortune_use_unicode = 1
g.startify_session_persistence = 1

--[[ -- Custom Header
----------------
local cwd = vim.fn.split(vim.fn.getcwd(), '/')
local banner = vim.fn.system("figlet -f 3d "..cwd[#cwd])
local header = vim.fn['startify#pad'](vim.fn.split(banner, '\n'))
vim.g.startify_custom_header = header ]]

g.startify_lists = {
  { type = "dir", header = { "   Current Directory " .. vim.fn.getcwd() .. ":" } },
  { type = "bookmarks", header = { "   Bookmarks" } },
}

g.startify_bookmarks = {
  { p = "~/.config/nvim/lua/custom/configs/lspconfig.lua" },
  { i = "~/.config/nvim/init.lua" },
  { m = "~/.config/nvim/lua/keys/plugins-mappings.lua" },
  { z = "~/.dotfiles/.config/zsh/.zshrc" },
  { b = "~/apps/vimwiki/cookbook/cookbook.md" },
}
