local wk = require("which-key")
local map = vim.api.nvim_set_keymap

map("n", "f", "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.AFTER_CURSOR, current_line_only = true })<cr>", {})
map("n", "F", "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.BEFORE_CURSOR, current_line_only = true })<cr>", {})

map("n", "j", "gj", {})
map("n", "k", "gk", {})
map("v", "j", "gj", {})
map("v", "k", "gk", {})

map("n", "<Down>", "gj", {})
map("n", "<Up>", "gk", {})

local keymap = {
    ["<TAB>"] = {"<cmd>bnext<cr>", "next buffer"},
    ["<leader>"] = {"<cmd>lua require'custom/telescope'.project_files()<cr>", "find files"},
    c = {"<cmd>lua require 'mdeval'.eval_code_block()<CR>", "eval code block"},
    j = {"<cmd>lua require'hop'.hint_patterns()<cr>", "find pattern and jump"},
    p = {'"+p', "paste from clipboard"},
    q = {"<cmd>Bdelete<cr>", "quit with bufdelete"},
    s = {"<cmd>BrowserSearch<cr>", "search the web"},
    w = {":w!<CR>", "save file"},
    y = {'"+y', "copy to clipboard"},
    Z = {"<cmd>ZenMode<CR>", "enter the z o n e"},
    ["§"] = {"<cmd>bprev<cr>", "previous buffer"},
    f = {
        name = "+telescope",
        n = {"<cmd>Telescope resume<cr>", "resume"},
        f = {"<cmd>lua require'custom/telescope'.project_files()<cr>", "find files"},
        b = {"<cmd>Telescope current_buffer_fuzzy_find<cr>", "fuzzy buf search"},
        t = {"<cmd>Telescope treesitter<cr>", "treesitter"},
        g = {"<cmd>Telescope live_grep<cr>", "grep"},
        e = {"<cmd>Telescope emoji theme=cursor<cr>", "emoji"},
    },
    g = {
        name = "+git",
        n = {"<cmd>Telescope resume<cr>", "resume"},
        h = {
            name = "+github",
            p = {"<cmd>Octo pr list<cr>", "pull requests"},
            i = {"<cmd>Octo issue list<cr>", "issues"},
            m = {
                name = "+my",
                p = {"<cmd>lua require'custom/octo'.my_prs()<cr>", "my pull requests"},
                i = {"<cmd>Octo issue list createdBy='@me'<cr>", "my issues"},   
            },
        },
        g = {"<cmd>Telescope git_bcommits<cr>", "buf git commits"},
        G = {"<cmd>Telescope git_commits<cr>", "all git commits"},
    },
    h = {
        name = "+gitsigns",
        s = 'stage hunk',
        u = "undo stage hunk",
        r = "reset hunk",
        R = "reset buffer",
        p = "preview hunk",
        b = "blame line",
        S = "stage buffer",
        U = "git reset",
    },
    l = {
        name = "+lsp",
        -- broken in python D = {'<cmd>lua vim.lsp.buf.declaration()<CR>', "declaration"},
        F = {"<cmd>lua vim.lsp.buf.formatting()<cr>", "format"},
        R = {"<cmd>lua vim.lsp.buf.rename()<CR>", "rename"},
    },
}

local noremap = {
}

wk.register(keymap, {prefix="<leader>"})
wk.register(noremap, {prefix="<leader>", noremap=true})

