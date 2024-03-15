local root_dir = require('lspconfig').util.root_pattern({
	'Pipfile',
	'pyproject.toml',
	'setup.py',
	'setup.cfg',
	'venv',
	'requirements.txt',
	'pyrightconfig.json',
	'.letsgo',
})

require('lspconfig').pyright.setup({
	filetypes = { 'python', 'py' },
	on_attach = function(client, _)
		client.server_capabilities = require('viktor.lsp.capabilities.pyright')

		-- local handlers = require('viktor.lsp.handlers.pyright')
		-- vim.lsp.handlers['textDocument/publishDiagnostics'] = vim.lsp.with(handlers.textDocument.publishDiagnostics, {})
	end,
	root_dir = root_dir,
	settings = {
		pyright = {
			disableLanguageServices = false,
			disableOrganizeImports = false,
			pythonVersion = '3.12',
		},
		python = {
			analysis = {
				autoImportCompletions = true,
				autoSearchPaths = true,
				diagnosticMode = true,
				extraPaths = {},
				logLevel = 'Error',
				diagnosticSeverityOverrides = {
					reportAssertAlwaysTrue = 'warning',
					reportCallInDefaultInitializer = 'information',
					reportConstantRedefinition = 'information',
					reportDeprecated = 'information',
					reportDuplicateImport = 'information',
					reportFunctionMemberAccess = 'information',

					reportImportCycles = 'information',
					reportIncompatibleVariableOverride = 'information',
					reportIncompleteStub = 'information',
					reportInconsistentConstructor = 'information',
					reportInvalidStringEscapeSequence = 'warning',
					reportInvalidStubStatement = 'information',
					reportInvalidTypeVarUse = 'warning',
					reportMatchNotExhaustive = 'information',
					reportMissingImports = 'error',
					reportMissingParameterType = 'information',
					reportMissingTypeArgument = 'none',
					reportMissingTypeStubs = 'none',
					reportOptionalCall = 'error',
					reportOptionalContextManager = 'error',
					reportOptionalIterable = 'error',
					reportOptionalMemberAccess = 'error',
					reportOptionalOperand = 'error',
					reportOptionalSubscript = 'error',
					reportOverlappingOverload = 'information',
					reportPrivateImportUsage = 'error',
					reportPropertyTypeMismatch = 'information',
					reportSelfClsParameterName = 'warning',
					reportShadowedImports = 'information',
					reportTypeCommentUsage = 'information',
					reportTypedDictNotRequiredAccess = 'error',
					reportUnboundVariable = 'error',
					reportUndefinedVariable = 'error',
					reportUninitializedInstanceVariable = 'information',
					reportUnknownArgumentType = 'none',
					reportUnknownLambdaType = 'none',
					reportUnknownMemberType = 'none',
					reportUnknownParameterType = 'none',
					reportUnknownVariableType = 'none',
					reportUnnecessaryCast = 'information',
					reportUnnecessaryComparison = 'information',
					reportUnnecessaryContains = 'information',
					reportUnnecessaryIsInstance = 'information',
					reportUnnecessaryTypeIgnoreComment = 'information',
					reportUnsupportedDunderAll = 'warning',
					reportUntypedBaseClass = 'information',
					reportUntypedClassDecorator = 'information',
					reportUntypedFunctionDecorator = 'information',
					reportUntypedNamedTuple = 'information',
					reportUnusedCallResult = 'information',
					reportUnusedClass = 'information',
					reportUnusedCoroutine = 'information',
					reportUnusedExpression = 'information',
					reportUnusedFunction = 'information',
					reportUnusedImport = 'information',
					reportWildcardImportFromLibrary = 'warning',

					-- reportUnusedVariable = "information",
					reportUnusedVariable = 'none',

					-- reportPrivateUsage = "information",
					reportPrivateUsage = 'none',

					-- reportImplicitOverride = "information",
					reportImplicitOverride = 'none',

					-- reportImplicitStringConcatenation = "information",
					reportImplicitStringConcatenation = 'none',

					-- reportIncompatibleMethodOverride = "information",
					reportIncompatibleMethodOverride = 'none',

					-- reportMissingModuleSource = "information",
					reportMissingModuleSource = 'warning',

					-- WHY AM I GETTING THIS ERROR!!!!!
					-- reportMissingSuperCall = "information",
					reportMissingSuperCall = 'none',

					-- -- reportGeneralTypeIssues = 'error',
					-- reportGeneralTypeIssues = 'none',
				},
				stubPath = 'typings',
				typeCheckingMode = 'off', --  ["off", "basic", "strict"]:
				typeshedPaths = {},
				useLibraryCodeForTypes = true,
				-- stubPath = "/home/viktor/hm/rust-main/fetch-data/stubs",
				-- diagnosticMode = "workspace", -- ["openFilesOnly", "workspace"]
				-- diagnosticMode = "openFilesOnly", -- ["openFilesOnly", "workspace"]
				-- diagnosticSeverityOverrides = { -- "error", "warning", "information", "true," "false," or "none"
				-- 	reportDuplicateImport = "warning",
				-- 	reportImportCycles = "warning",
				-- 	reportMissingImports = "error",
				-- 	reportMissingModuleSource = "error",
				-- },
			},
		},
	},
})
