local tele = require("telescope")
local actions = require("telescope.actions")
tele.setup {
  defaults = {
    mappings = {
      i = {
        ["<esc>"] = actions.close
      },
    },
  }
}
