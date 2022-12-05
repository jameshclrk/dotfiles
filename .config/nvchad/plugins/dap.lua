local dap = require "dap"
local dap_python = require "dap-python"
local dap_ui = require "dapui"

local M = {}

M.setup = function()
  dap_python.setup("~/.local/venvs/debugpy/bin/python")
  dap_python.test_runner = 'pytest'
  dap_ui.setup({
    layouts = {
      {
        elements = {
          -- Elements can be strings or table with id and size keys.
          { id = "scopes", size = 0.45 },
          { id = "stacks", size = 0.25 },
          { id = "breakpoints", size = 0.15 },
          { id = "watches", size = 0.15 },
        },
        size = 50,
        position = "left",
      },
      {
        elements = {
          "console",
        },
        size = 10,
        position = "bottom",
      },
    },
  })
  dap.listeners.after.event_initialized["dapui_config"] = function()
    require("trouble").close()
    require("trouble.config").options.auto_open = false
    dap_ui.open()
  end
  dap.listeners.before.event_terminated["dapui_config"] = function()
    dap_ui.close()
    require("trouble.config").options.auto_open = true
    require("trouble").refresh()
  end
  dap.listeners.before.event_exited["dapui_config"] = function()
    dap_ui.close()
    require("trouble.config").options.auto_open = true
    require("trouble").refresh()
  end
end

return M
