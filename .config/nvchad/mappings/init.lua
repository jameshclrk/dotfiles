local M = {}

M.disabled = {
  n = {
    ["<leader>wk"] = "",
    ["<leader>wK"] = "",
    ["<leader>wa"] = "",
    ["<leader>wr"] = "",
    ["<leader>wl"] = "",
    ["<leader>ff"] = "",
    ["<leader>fa"] = "",
    ["<leader>fw"] = "",
    ["<leader>fb"] = "",
    ["<leader>fh"] = "",
    ["<leader>fo"] = "",
    ["<leader>fm"] = "",
    ["<TAB>"] = "",
    ["§"] = "",
  },
}

M.general = {
  n = {
    ["<leader>w"] = { ":w!<CR>", "save file" },
    ["<leader><leader>"] = { "<cmd> lua require'custom.plugins.telescope_cfg'.project_files()<CR>", "  find files" },
  },
}

M.bufferline = {
  n = {
    ["<leader><TAB>"] = {
      function()
        require("core.utils").tabuflineNext()
      end, "  cycle next buffer" },
    ["<leader><S-Tab>"] = { function()
      require("core.utils").tabuflinePrev()
    end, "  cycle prev buffer" },
  },
}

M.lspconfig = {
  n = {
    ["<leader>ca"] = {
      "<cmd> CodeActionMenu<CR>",
      "   lsp code_action",
    },
    ["<leader>q"] = {
      "<cmd>Trouble<CR>",
      "   diagnostics",
    },
    ["<leader>fm"] = {
       function()
          vim.lsp.buf.format { async = true }
       end,
       "   lsp formatting",
    },
    ["[e"] = {
       function()
         vim.diagnostic.goto_prev()
       end,
       "   lsp formatting",
    },
    ["]e"] = {
       function()
         vim.diagnostic.goto_next()
       end,
       "   lsp formatting",
    },
  },
}

M.telescope = {
  n = {
    -- find
    ["<leader>tf"] = { "<cmd> Telescope find_files <CR>", "  find files" },
    ["<leader>ta"] = { "<cmd> Telescope find_files follow=true no_ignore=true hidden=true <CR>", "  find all" },
    ["<leader>tw"] = { "<cmd> Telescope live_grep <CR>", "   live grep" },
    ["<leader>tb"] = { "<cmd> Telescope buffers <CR>", "  find buffers" },
    ["<leader>to"] = { "<cmd> Telescope oldfiles <CR>", "   find oldfiles" },
  },
}

M.whichkey = {
  n = {
    ["<leader>\\"] = {
      function()
        vim.cmd "WhichKey"
      end,
      "   which-key all keymaps",
    },
  },
}

M.debug = {
  n = {
    ["<leader>db"] = {"<ESC>:lua require('dap').toggle_breakpoint()<CR>", "Toggle Breakpoint"},
    ["<leader>dc"] = {"<ESC>:lua require('dap').continue()<CR>", "Continue"},
    ["<leader>dd"] = {"<ESC>:lua require('dapui').toggle()<CR>", "Open Debug UI"},
    ["<leader>do"] = {"<ESC>:lua require('dap').step_over()<CR>", "Step Over"},
    ["<leader>di"] = {"<ESC>:lua require('dap').step_into()<CR>", "Step Into"},
    ["<leader>dr"] = {"<ESC>:lua require('dap').repl.toggle()<CR>", "Toggle REPL"},

    ["<leader>dn"] = {"<ESC>:lua require('dap-python').test_method()<CR>", "Debug test (method)"},
    ["<leader>df"] = {"<ESC>:lua require('dap-python').test_class()<CR>", "Debug test (class)"},
  },
  v = {
    ["<leader>ds"] = {"<ESC>:lua require('dap-python').debug_selection({config = {stopOnEntry = true}})<CR>", "Debug Selection"},
  },
}

return M
