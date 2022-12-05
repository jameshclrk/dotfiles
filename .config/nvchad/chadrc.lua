local fn = vim.fn
-- local sep_style = require("ui.icons").statusline_separators
-- local user_sep = require("core.utils").load_config().ui.statusline.separator_style
-- local sep_l = sep_style[user_sep]["left"]
-- local sep_r = sep_style[user_sep]["right"]

local M = {}


M.ui = {
  theme_toggle = { "chadracula", "vscode_dark" },
  theme = "chadracula",
  statusline = {
    override = {
      cursor_position = function()
        local current_line = fn.line "."
        local current_col = fn.col "."
        return current_line .. "," .. current_col
      end
    },
  },
}

M.mappings = require "custom.mappings"

M.plugins = {
  user = require "custom.plugins",
}

return M
