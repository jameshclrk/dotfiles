local shared_capabilities = require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities())
local lsp = require("lspconfig")
lsp.gopls.setup {}
lsp.jsonls.setup {
  commands = {
    Format = {
      function()
        vim.lsp.buf.range_formatting({},{0,0},{vim.fn.line("$"),0})
      end
    }
  }
}
lsp.pyright.setup{}
-- lsp.pylsp.setup {
--   settings = {
--     pylsp = {
--       -- configurationSources = {"flake8", "mypy", "isort"},
--       configurationSources = {"flake8"},
--       plugins = {
--         pyls_mypy = {
--           enabled = true,
--         },
--         pyls_black = {
--           enabled = true,
--         },
--         pyls_isort = {
--           enabled = true,
--         },
--       },
--     },
--   },
--   capabilities = shared_capabilities,
-- }
