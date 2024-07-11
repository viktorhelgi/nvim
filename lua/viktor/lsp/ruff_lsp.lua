local root_dir = require('lspconfig').util.root_pattern({
	'ruff.toml',
	'.ruff.toml',
	'pyproject.toml',
	'Pipfile',
})

local configs = require('lspconfig.configs')

if not configs.ruff_lsp then
	configs.ruff_lsp = {
		default_config = {
			cmd = { 'ruff-lsp' },
			filetypes = { 'python' },
			root_dir = root_dir,
			init_options = {
				settings = {
					args = {},
				},
			},
		},
	}
end

require('lspconfig').ruff_lsp.setup({
	-- root_dir = root_dir,
})
