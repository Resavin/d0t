vim.scriptencoding = "utf-8"
local options = {
	encoding = "utf-8",
	fileencoding = "utf-8", -- File-content encoding for the current buffer

	number = true, -- show line numbers
	relativenumber = true, -- Show the line number relative to the line with the cursor in front of each line
	cursorline = true, -- highlight the current line
	title = true,
	autoindent = true,
	showcmd = true,
	-- laststatus = 2, -- different status lines for different buffers
	backup = false, -- disabled the creation of backups
	scrolloff = 10,
	cmdheight = 1,          -- Number of screen lines to use for the command-line

	-- Search
	hlsearch = true, -- When there is a previous search pattern, highlight all its matches
	ignorecase = true,
	showmatch = true, -- When a bracket is inserted, briefly jump to the matching one
	smartcase = true,

	--    tabstop = 4,            -- Number of spaces that a <Tab> in the file counts for
	-- shiftwidth = 4, -- Number of spaces to use for each step of (auto)indent
	ai = true, -- Auto indent
	si = true, -- Smart indent
	expandtab = true, -- Use the appropriate number of spaces to insert a <Tab>
	backspace = "start,eol,indent",
	-- wrap = false,		-- No wrap lines

	smarttab = true,
	syntax = "on",
	shell = "fish",
	inccommand = "split",
	breakindent = true,

	-- autochdir = true, -- change dir to current file open
}

for k, v in pairs(options) do
	vim.opt[k] = v
end

-- Transparent
-- vim.cmd("highlight Normal guifg=none guibg=none")
-- vim.cmd("highlight TabLine guifg=none guibg=none")
-- vim.cmd("highlight TabLineFill guifg=none guibg=none")

-- Turn off paste mode when leaving insert
vim.api.nvim_create_autocmd("InsertLeave", {
	pattern = "*",
	command = "set nopaste",
})
