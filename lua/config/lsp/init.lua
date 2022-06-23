return {
	require('config.lsp.setup'),
	require('config.lsp.lua_lsp'),

	require('config.lsp.python_lsp'),
	require('config.lsp.rust_lsp'),
	require('config.lsp.julia_lsp'),
	require('config.lsp.terminal_lsp')
}

