local M = {}

M.my_prs = function()
  local me = require("octo.gh").get_user_name()
  require("octo.picker").prs({author=me})
end

return M
