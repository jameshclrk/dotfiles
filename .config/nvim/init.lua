-- starts loading init.lua
vim.opt.shadafile = "NONE"
pcall(require, "impatient")
-- require("impatient").enable_profile()

local disabled_built_ins = {
	"python_provider",
	"python3_provider",
	"ruby_provider",
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
	"matchit",
}

for _, plugin in pairs(disabled_built_ins) do
	vim.g["loaded_" .. plugin] = 1
end

-- load options, mappings, and plugins
local modules = {
	"settings",
	"maps",
	"plugins",
}

for i = 1, #modules, 1 do
	pcall(require, modules[i])
end

vim.opt.shadafile = ""
