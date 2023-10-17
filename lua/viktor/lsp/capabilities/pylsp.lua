return {
	-- codeActionProvider = true,
	-- codeLensProvider = {
	-- 	resolveProvider = false,
	-- },
	-- completionProvider = {
	-- 	resolveProvider = true,
	-- 	triggerCharacters = { "." },
	-- },
	-- definitionProvider = true,
	-- documentFormattingProvider = true,
	-- documentHighlightProvider = true,
	-- documentRangeFormattingProvider = true,
	-- documentSymbolProvider = true,
	executeCommandProvider = {
		commands = {},
	},
	-- experimental = vim.empty_dict(),
	-- foldingRangeProvider = true,
	-- hoverProvider = true,
	referencesProvider = true,
	renameProvider = true,
	-- signatureHelpProvider = {
	-- 	triggerCharacters = { "(", ",", "=" },
	-- },
	textDocumentSync = {
		change = 2,
		openClose = true,
		save = {
			includeText = true,
		},
	},
	workspace = {
		workspaceFolders = {
			changeNotifications = true,
			supported = true,
		},
	},
}
