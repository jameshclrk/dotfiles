local opt = vim.opt
local cmd, global = vim.cmd, vim.api.nvim_set_var

vim.g.mapleader = ";"
vim.g.did_load_filetypes=1

opt.lazyredraw = true
opt.number = true
opt.signcolumn = "yes:1"
opt.hidden = true
opt.termguicolors = true
opt.mouse = "a"
opt.showmode = false
opt.tabstop = 4
opt.shiftwidth = 4
opt.softtabstop = 4
opt.expandtab = true
opt.timeoutlen = 500

-- Minimap
global("minimap_auto_start", 1)
global("minimap_auto_start_win_enter", 1)
global("minimap_highlight_range", 1)

-- Dashboard
global("dashboard_default_executive", "telescope")

if vim.fn.filereadable("~/.config/nvim/header.cat") == 1 then
    global("dashboard_preview_command", "cat")
    global("dashboard_preview_file", "~/.config/nvim/header.cat")
    global("dashboard_preview_file_height", 34)
    global("dashboard_preview_file_width", 62)
end

global("dashboard_custom_section", {
    a = {
        description = {"ﭯ  Recently Opened Files"},
        command = "DashboardFindHistory",
    },
    b = {
        description = {"  Find Files           "},
        command = "DashboardFindFile",
    },
    c = {
        description = {"  New File             "},
        command = "DashboardNewFile",
    },
    d = {
        description = {"  Settings             "},
        command = "Telescope find_files cwd=~/.config/nvim",
    },
})

cmd("colorscheme tokyonight")

local disabled_built_ins = {
    "gzip",
    "zip",
    "zipPlugin",
    "tar",
    "tarPlugin",
    "getscript",
    "getscriptPlugin",
    "vimball",
    "vimballPlugin",
    "2html_plugin",
    "logipat",
    "rrhelper",
    "spellfile_plugin",
    "matchit"
}

for _, plugin in pairs(disabled_built_ins) do
    vim.g["loaded_" .. plugin] = 1
end

