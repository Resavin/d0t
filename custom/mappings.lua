---@type MappingsTable
local M = {}
M.disabled = {
  n = {
    ["A-v"] = "",
    ["A-h"] = "",
    ["<leader>v"] = "",
    ["<leader>h"] = "",
    ["<C-n>"] = "",
    -- ["<Esc>"] = "",
  },
  i = {
    ["<Tab>"] = "",
  },
}
M.chatgpt = {
  i = {
    -- ["A-e"] = {"<cmd> ChatGPTCompleteCode <CR> ", "chatgpt complete"}, -- don't work
  },
  n = {
    ["<leader>gp"] = {"<cmd> ChatGPT <CR>", "open chatgpt window"},
    ["<leader>ge"] = {"<cmd> ChatGPTEditWithInstructions <CR>", "open chatgpt window"},
    ["<leader>gc"] = {"<cmd> ChatGPTCompleteCode <CR> ", "chatgpt complete"}
  }
}
M.nvim_tmux = {
  n = {
    ["<C-h>"] = {"<cmd> NvimTmuxNavigateLeft <CR>", "left pane"},
    ["<C-j>"] = {"<cmd> NvimTmuxNavigateDown <CR>", "down pane"},
    ["<C-k>"] = {"<cmd> NvimTmuxNavigateUp <CR>", "up pane"},
    ["<C-l>"] = {"<cmd> NvimTmuxNavigateRight <CR>", "right pane"},
    ["<C-\\>"] = {"<cmd> NvimTmuxNavigateLastActive <CR>", "last active pane"},
    ["<C-Space>"] = {"<cmd> NvimTmuxNavigateNext <CR>", "next pane"},
  }
}
M.tresitter = {
  n = {
    -- ["<C-e>"] = {
    --   function()
    --     local result = vim.treesitter.get_captures_at_cursor(0)
    --     print(vim.inspect(result))
    --   end,
    --   "show highlight(?) groups under cursor",
    -- },
  },
}
M.dap = {
  plugin = true,
  n = {
    ["<leader>db"] = { "<cmd> DapToggleBreakpoint <CR>", "toggle breakpoint" },
    ["<F2>"] = { "<cmd> DapToggleBreakpoint <CR>", "toggle breakpoint" },
  },
}
M.dap_python = {
  plugin = true,
  n = {
    ["<leader>dpr"] = {
      function()
        require("dap-python").test_method()
      end,
      "test_method",
    },
  },
}
function cargo_run()
  -- vim.cmd "split"
  -- vim.cmd "wincmd J"
  vim.cmd "w"
  vim.cmd "!cargo run"
  --vim.cmd "wimcmd c"
end
function cargo_test()
  vim.cmd "!cargo test"
end
M.general = {
  n = {
    [";"] = { ":", "enter command mode", opts = { nowait = true } },
    ["Q"] = { "<cmd>qa!<CR>", "exit" },
    ["<C-Q>"] = { "<C-V>", "visual-block mode?" },
    ["<leader><Tab><Tab>"] = { "<cmd> enew <CR>", "new buffer" },
    ["<leader>rr"] = { "<cmd>lua cargo_run()<CR>", "run rust" },
    ["<leader>rt"] = { "<cmd>lua cargo_test()<CR>", "test rust" },
    ["<C-X>"] = { ":%s/\\r//g<CR>", "remove ^M" }, -- without second backslash before \r it would count \r as enter, I think.
    ["<C-n>"] = {"10j", "faster scrolling"},
    ["<C-p>"] = {"10k", "faster scrolling up"}
  },
  v = {
    ["Q"] = { "<cmd>qa!<CR>", "exit" },
  },
  i = {
    ["<C-V>"] = { "<Esc>pa", "paste in insert mode" },
    ["<C-s>"] = { "<cmd> w <CR><Esc>", "save file" },
  },
  -- didn't work, started using tmux
  -- t = {
  --   ["<C-h>"] = { "<C-h>", "focus left window" },
  -- },
}
M.telescope = {
  plugin = true,
  n = {
    ["<leader>fk"] = { "<cmd> Telescope keymaps <CR>", "keysss" },
    ["<space>lf"] = {
      function()
        require("telescope").extensions.file_browser.file_browser()
      end,
      "file browser",
    },
  },
}
-- more keybinds!
M.tabufline = {
  plugin = true,

  n = {
    -- cycle through buffers
    ["<S-L>"] = {
      function()
        require("nvchad.tabufline").tabuflineNext()
      end,
      "goto next buffer",
    },

    ["<S-H>"] = {
      function()
        require("nvchad.tabufline").tabuflinePrev()
      end,
      "goto prev buffer",
    },
    ["<leader>n"] = {
      function()
        require("nvchad_ui.tabufline").closeAllBufs()
      end,
      "close all buffers",
    },
  },
}
M.nvimtree = {
  plugin = true,

  n = {
    -- toggle
    -- ["<C-n>"] = { "<cmd> NvimTreeToggle <CR>", "Toggle nvimtree" },
    -- focus
    ["<leader>e"] = { "<cmd> NvimTreeToggle <CR>", "toggle nvimtree" },
  },
}
return M
