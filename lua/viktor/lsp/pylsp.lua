local root_dir = require('lspconfig').util.root_pattern({
	'Pipfile',
	'pyproject.toml',
	'setup.py',
	'setup.cfg',
	'venv',
	'requirements.yml',
	'pyrightconfig.json',
})

require('lspconfig').pylsp.setup({
	filetypes = { 'python', 'py' },
	on_attach = function(client, _)
		client.server_capabilities = require('viktor.lsp.capabilities.pylsp')
	end,
	root_dir = root_dir,
	settings = {
		pylsp = {
			plugins = {
				-- pyls_black = { enabled = true },
				-- pylint = {enabled = true},
				-- autopep8 = {enabled = true}
				-- flake8 = {enabled = true},
				preload = { enabled = true, modules = { 'numpy', 'scipy' } },
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
				typeCheckingMode = 'basic', --  ["off", "basic", "strict"]:
				-- diagnosticMode = "workspace", -- ["openFilesOnly", "workspace"]
				diagnosticMode = 'openFilesOnly', -- ["openFilesOnly", "workspace"]
				stubPath = 'stubs',
				diagnosticSeverityOverrides = { -- "error," "warning," "information," "true," "false," or "none"
					reportDuplicateImport = 'warning',
					reportImportCycles = 'warning',
					reportMissingImports = 'error',
					reportMissingModuleSource = 'error',
				},
			},
		},
	},
})
