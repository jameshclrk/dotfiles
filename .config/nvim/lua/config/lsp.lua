local opts = { noremap = true, silent = true }
local capabilities = require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities())
local on_attach = function(client, bufnr)
	vim.api.nvim_buf_set_keymap(bufnr, "n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
	vim.api.nvim_buf_set_keymap(bufnr, "n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
	vim.api.nvim_buf_set_keymap(bufnr, "n", "gt", "<cmd>lua vim.lsp.buf.type_definition()<CR>", opts)
	vim.api.nvim_buf_set_keymap(bufnr, "n", "[d", "<cmd>lua vim.diagnostic.goto_prev()<CR>", opts)
	vim.api.nvim_buf_set_keymap(bufnr, "n", "]d", "<cmd>lua vim.diagnostic.goto_next()<CR>", opts)
	if client.server_capabilities.documentFormattingProvider then
		vim.cmd([[
      augroup LspFormatting
        autocmd! * <buffer>
        autocmd BufWritePre <buffer> lua vim.lsp.buf.format()
      augroup END
    ]])
	end
end

local M = {}

M.lspconfig = function()
	local lsp = require("lspconfig")
	lsp.gopls.setup({ capabilities = capabilities, on_attach = on_attach })
	lsp.jsonls.setup({
		capabilities = capabilities,
		on_attach = on_attach,
		commands = {
			Format = {
				function()
					vim.lsp.buf.range_formatting({}, { 0, 0 }, { vim.fn.line("$"), 0 })
				end,
			},
		},
	})
	lsp.pyright.setup({ capabilities = capabilities, on_attach = on_attach })
end

M.null_ls = function()
	local null_ls = require("null-ls")
	null_ls.setup({
		on_attach = on_attach,
		sources = {
			-- C et al.
			null_ls.builtins.formatting.clang_format,
			-- Lua
			null_ls.builtins.formatting.stylua,
			-- Python
			null_ls.builtins.formatting.isort,
			null_ls.builtins.formatting.black,
		},
	})
end

return M
