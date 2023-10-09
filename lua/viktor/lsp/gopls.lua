local function _cmd(input)
	return "<CMD>" .. input .. "<CR>"
end

local function on_attach(client, bufnr)

	require("which-key").register({
		["["] = {
			d = { vim.diagnostic.goto_prev, "diagnostic" },
		},
		["]"] = {
			d = { vim.diagnostic.goto_next, "diagnostic" },
		},
		["'"] = {
			name = "goto",
			L = { "<CMD>e ~/.config/nvim/lua/viktor/lsp/gopls.lua<CR>", "lsp" },
			-- C = { "<CMD>e ~/.config/nvim/after/plugin/cmp/rust.lua<CR>", "cmp" },

		},


		g = {
			name = "goto",
			i = { vim.lsp.buf.implementation, "impl" },
			D = { vim.lsp.buf.declaration, "decl" },
			-- k = {"gk", "K" },
			r = { vim.lsp.buf.references, "ref" },
			s = { vim.lsp.buf.signature_help, "sign" },
			k = { _cmd("TSTextobjectPeekDefinitionCode @function.inner"), "peek definition" },
		},
		-- l = {
		-- 	a = { _cmd("CodeActionMenu"), "code-action" },
		-- 	r = { vim.lsp.buf.rename, "rename" },
		-- },
		c = {
			name = "Change/Cargo",
			d = { vim.diagnostic.setqflist, "setqflist" },
			q = { _cmd("cclose"), "close qflist" },
		},
	})
end

require('lspconfig').gopls.setup({
    on_attach = on_attach,
})
