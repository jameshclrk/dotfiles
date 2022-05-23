local tele = require("telescope")
local actions = require("telescope.actions")
tele.setup({
	defaults = {
		borderchars = { " ", " ", " ", " ", " ", " ", " ", " " },
		layout_config = { prompt_position = "top" },
		prompt_prefix = " ",
		sorting_strategy = "ascending",
		preview = {
			filesize_limit = 5,
			timeout = 150,
			treesitter = true,
			filesize_hook = function(filepath, bufnr, opts)
				local path = Path:new(filepath)
				local height = vim.api.nvim_win_get_height(opts.winid)
				local lines = vim.split(path:head(height), "[\r]?\n")
				vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, lines)
			end,
		},
		dynamic_preview_title = true,
		mappings = {
			i = {
				["<esc>"] = actions.close,
			},
		},
	},
})
tele.load_extension("file_browser")
tele.load_extension("fzf")
tele.load_extension("frecency")
tele.load_extension("emoji")
tele.load_extension("projects")
