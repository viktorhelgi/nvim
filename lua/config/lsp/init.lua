return {
    require('config.lsp.mason'),
	require('config.lsp.setup'),
	require('config.lsp.lua_lsp'),

	require('config.lsp.python_lsp'),
	require('config.lsp.rust_lsp'),
	-- require('config.lsp.julia_lsp'),
	require('config.lsp.cpp_lsp'),
	require('config.lsp.cmake_lsp'),
	-- require('config.lsp._neo-cmake-lsp_'),
	-- require('config.lsp._glow-hover_'),
	require('config.lsp.terminal_lsp')
}

