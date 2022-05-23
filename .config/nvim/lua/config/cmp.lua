local cmp = require("cmp")
cmp.setup({
	mapping = {
		["<C-d>"] = cmp.mapping(cmp.mapping.scroll_docs(-4), { "i", "c" }),
		["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(4), { "i", "c" }),
		["<CR>"] = cmp.mapping.confirm({ select = true }),
		["<Tab>"] = function(fallback)
			if cmp.visible() then
				cmp.select_next_item()
			else
				fallback()
			end
		end,
		["<S-Tab>"] = function(fallback)
			if cmp.visible() then
				cmp.select_prev_item()
			else
				fallback()
			end
		end,
	},
	sources = {
		{ name = "nvim_lua" },
		{ name = "nvim_lsp" },
		{ name = "buffer" },
	},
	formatting = {
		format = require("lspkind").cmp_format(),
	},
})
cmp.setup.cmdline("/", {
	completion = {
		autocomplete = true,
	},
	sources = cmp.config.sources({
		{ name = "nvim_lsp_document_symbol" },
	}, {
		-- { name = "buffer", keyword_length = 5 },
	}),
})
