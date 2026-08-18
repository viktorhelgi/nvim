--Enable (broadcasting) snippet capability for completion
local capabilities = vim.lsp.protocol.make_client_capabilities()

capabilities.textDocument.completion.completionItem.snippetSupport = true

vim.lsp.config('cssls', {
	capabilities = capabilities,
	cmd = { 'vscode-css-language-server', '--stdio' },
})
vim.lsp.enable('cssls')
