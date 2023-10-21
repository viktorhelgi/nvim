local lspconfig = require("lspconfig")

local on_attach = function(client, bufnr)
	local opt = { noremap = true, silent = false, buffer = bufnr }
	-- require("lsp_signature").on_attach(require("viktor.config.plugin.lsp_signature"), bufnr) -- no need to specify bufnr if you don't use toggle_key

	-- vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opt)
	-- vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opt)

	-- vim.keymap.set('n', 'gef', vim.diagnostic.open_float, opt)
	-- vim.keymap.set('n', 'geq', vim.diagnostic.setloclist, opt)
	-- vim.keymap.set('n', 'gI', vim.lsp.buf.implementation, opt)

	-- vim.keymap.set({ 'n' }, '<Leader>k', function()
	--     vim.lsp.buf.signature_help()
	-- end, { silent = true, noremap = true, desc = 'toggle signature' })

	-- vim.keymap.set('n', 'gd', require('telescope.builtin').lsp_definitions, opt)
	-- vim.keymap.set('n', '<C-g>', require('telescope.builtin').lsp_definitions, opt)
	-- vim.keymap.set('n', '<C-t>', require('telescope.builtin').lsp_type_definitions, opt)

	-- vim.keymap.set('n', '<leader>lh', vim.lsp.buf.hover, opt)
	-- vim.keymap.set('n', '<leader>lI', vim.lsp.buf.implementation, opt)
	-- vim.keymap.set('n', '<leader>lr', vim.lsp.buf.references, opt)
	-- vim.keymap.set('n', '<leader>ls', vim.lsp.buf.signature_help, opt)
	-- vim.keymap.set('n', '<leader>ld', require('telescope.builtin').lsp_definitions, opt)
	-- vim.keymap.set('n', '<leader>lt', require('telescope.builtin').lsp_type_definitions, opt)
	-- vim.keymap.set('n', '<leader>lf', function() vim.cmd('Format') end, opt)
	-- vim.keymap.set('v', '<leader>lf', "<cmd>Format<cr>", opt)

	-- require("viktor.config.plugin.neotest").on_attach(client, bufnr)

	vim.keymap.set("n", "<leader>la", vim.lsp.buf.code_action, opt)
end

local root_dir = lspconfig.util.root_pattern({
	"Pipfile",
	"pyproject.toml",
	"setup.py",
	"setup.cfg",
	"venv",
	"requirements.yml",
	"pyrightconfig.json",
})

lspconfig.pylsp.setup({
	filetypes = { "python", "py" },
	on_attach = function(client, bufnr)
		on_attach(client, bufnr)
		client.server_capabilities = require("viktor.lsp.capabilities.pylsp")
	end,
	root_dir = root_dir,
	settings = {
		pylsp = {
			plugins = {
				-- pyls_black = { enabled = true },
				-- pylint = {enabled = true},
				-- autopep8 = {enabled = true}
				-- flake8 = {enabled = true},
				preload = { enabled = true, modules = { "numpy", "scipy" } },
				ruff = {
					enabled = false,
				},
				pycodestyle = {
					enabled = false,
				},
				pyflakes = {
					enabled = false,
				},
				mccabe = {
					enabled = false,
				},
			},
		},
		python = {
			analysis = {
				-- useLibraryCodeForTypes = true,
				autoImportCompletions = true,

				autoSearchPaths = true,
				-- typeCheckingMode = "strict", --  ["off", "basic", "strict"]:
				-- typeCheckingMode = "basic", --  ["off", "basic", "strict"]:
				typeCheckingMode = "basic", --  ["off", "basic", "strict"]:
				-- diagnosticMode = "workspace", -- ["openFilesOnly", "workspace"]
				diagnosticMode = "openFilesOnly", -- ["openFilesOnly", "workspace"]
                stubPath = "stubs",
				diagnosticSeverityOverrides = { -- "error," "warning," "information," "true," "false," or "none"
					reportDuplicateImport = "warning",
					reportImportCycles = "warning",
					reportMissingImports = "error",
					reportMissingModuleSource = "error",
				},
			},
		},
	},
})

-- lspconfig.ruff_lsp.setup({
-- 	root_dir = root_dir,
--     filetypes = { "python" },
-- 	on_attach = function(client, bufnr)
--         -- vim.pretty_print(client.server_capabilities)
--         on_attach(client, bufnr)
--     end,
-- 	init_options = {
-- 		settings = {
-- 			-- Any extra CLI arguments for `ruff` go here.
-- 			args = {},
-- 		},
--         -- interpreter = "python3.8"
-- 	},
-- })
