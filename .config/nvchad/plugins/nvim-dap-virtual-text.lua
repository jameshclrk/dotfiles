local dap_vt = require "nvim-dap-virtual-text"

local M = {}

M.setup = function()
  dap_vt.setup({
    virt_text_win_col = 90,
    highlight_changed_variables = true,
    commented = true,
  })
end

return M
