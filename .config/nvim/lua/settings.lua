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
opt.scrolloff = 8
opt.sidescrolloff = 8
opt.foldlevel=20

global("markdown_fenced_languages", {"html", "python", "javascript", "js=javascript"})
global("markdown_folding", 1)

cmd("colorscheme tokyonight")

