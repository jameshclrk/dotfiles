local trouble = require "trouble"

local M = {}

M.setup = function()
  trouble.setup {
    mode = "document_diagnostics",
    auto_open = false,
    auto_close = true,
  }
end

return M
