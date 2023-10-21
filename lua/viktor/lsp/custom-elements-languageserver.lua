require('lspconfig').custom_elements_ls.setup({
	on_attach = function(client, _)
		client.server_capabilities = {
			codeActionProvider = true,
			completionProvider = vim.empty_dict(),
			-- declarationProvider = true,
			-- definitionProvider = true,
			hoverProvider = true,
			referencesProvider = true,
			textDocumentSync = {
				change = 1,
				openClose = true,
				save = {
					includeText = false,
				},
				willSave = false,
				willSaveWaitUntil = false,
			},
			workspace = {
				workspaceFolders = {
					supported = true,
				},
			},
		}
	end,
})
