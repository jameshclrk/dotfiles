local custom_attach = function(client, buffnr)
  if client.server_capabilities.documentFormattingProvider then
    vim.cmd [[
            augroup LspFormatting
              autocmd! * <buffer>
              autocmd BufWritePre <buffer> lua vim.lsp.buf.format()
            augroup END
          ]]
  end
end

local attach = require("plugins.configs.lspconfig").on_attach
local capabilities = require("plugins.configs.lspconfig").capabilities

local lspconfig = require "lspconfig"

-- lspservers with default config
local servers = { "gopls", "pyright", "jsonls" }
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = function(client, bufnr)
      attach(client, bufnr)
      custom_attach(client, bufnr)
    end,
    capabilities = capabilities,
  }
end

lspconfig["ltex"].setup {
  on_attach = function(client, bufnr)
    attach(client, bufnr)
    custom_attach(client, bufnr)
  end,
  capabilities = capabilities,
  filetypes = { "bib", "gitcommit", "markdown", "org", "plaintex", "rst", "rnoweb", "tex", "python"},
  settings = {
    ltex = {
      enabled = {"bibtex", "context", "context.tex", "html", "latex", "markdown", "org", "restructuredtext", "rsweave", "python"},
      language = "en-GB",
    },
  },
}
