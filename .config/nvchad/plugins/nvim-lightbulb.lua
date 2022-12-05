local lightbulb = require('nvim-lightbulb')

local M = {}

M.setup = function()
  lightbulb.setup(
    {
      autocmd = {
        enabled = true,
      },
    }
  )
end

return M
