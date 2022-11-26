return {
	require('config.lsp.setup'),
	require('config.lsp.lua_lsp'),

	require('config.lsp.python_lsp'),
	require('config.lsp.rust_lsp'),
	-- require('config.lsp.julia_lsp'),
	require('config.lsp.cpp_lsp'),
	require('config.lsp.javascript_lsp'),
	require('config.lsp.typescript_lsp'),
	require('config.lsp.cmake_lsp'),
	require('config.lsp.terminal_lsp')
}

