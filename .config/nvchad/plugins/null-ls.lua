local null_ls = require "null-ls"
local b = null_ls.builtins

local sources = {
  -- C et al.
  b.formatting.clang_format,
  -- Git
  -- b.code_actions.gitsigns,
  -- Go
  b.formatting.gofmt,
  b.formatting.goimports,
  -- Lua
  -- b.formatting.stylua,
  -- Proselint
  -- b.code_actions.proselint,
  -- Python
  b.formatting.isort,
  b.formatting.black,
  -- Rust
  b.formatting.rustfmt,
}

local M = {}

M.setup = function()
  null_ls.setup {
    sources = sources,
    on_attach = function(client)
      if client.server_capabilities.documentFormattingProvider then
        vim.cmd [[
            augroup NullLsFormatting
              autocmd! * <buffer>
              autocmd BufWritePre <buffer> lua vim.lsp.buf.format()
            augroup END
          ]]
      end
    end,
  }
end

return M
