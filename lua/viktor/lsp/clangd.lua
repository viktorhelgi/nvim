require('lspconfig').clangd.setup({
	on_attach = function(_, bufnr)
		require('lsp_signature').on_attach(require('viktor.config.plugin.lsp_signature_configs'), bufnr)
	end,
	filetypes = { 'c', 'hpp', 'cpp', 'objc', 'objcpp', 'cuda', 'proto' },
	settings = {
		clangd = {
			arguments = {
				'--background-index',
				'-j=12',
				-- "--query-driver=/usr/bin/**/clang-*,/bin/clang,/bin/clang++,/usr/bin/gcc,/usr/bin/g++",
				'--clang-tidy',
				'--clang-tidy-checks=*',
				'--all-scopes-completion',
				'--cross-file-rename',
				'--completion-style=detailed',
				'--header-insertion-decorators',
				'--header-insertion=iwyu',
				'--pch-storage=memory',
			},
			checkUpdates = false,
			detectExtensionConflicts = true,
			fallbackFlags = {},
			inactiveRegions = {
				opacity = 0.55,
				useBackgroundHighlight = false,
			},
			onConfigChanged = 'prompt',
			path = 'clangd',
			restartAfterCrash = true,
			semanticHighlighting = true,
			serverCompletionRanking = true,
			-- trace = "some-string",
		},
	},
})
