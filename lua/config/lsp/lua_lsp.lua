--[[
	Setup script for the lua lsp server sumneko
--]]
local fn = vim.fn

-- check for the underlying operating system
local system_name
if fn.has('mac') == 1 then
	system_name = 'macOS'
elseif fn.has('unix') == 1 then
	system_name = 'Linux'
elseif fn.has('win32') == 1 then
	system_name = 'Windows'
else
	print('Unsupported system for sumneko')
end

-- set the path to the sumneko installation (ABSOLUTE PATH)
local sumneko_install_path = fn.stdpath('data') .. '/lspservers/lua-language-server'
local pathcheck = sumneko_install_path .. '/bin/' .. system_name
local sumneko_binary

-- check of weird build directories
if fn.isdirectory(pathcheck) > 0 then
	-- set binary path to that with a system directory
	sumneko_binary = sumneko_install_path .. '/bin/' .. system_name .. '/lua-language-server'
else
	-- set binary path to just the (oddly) bin directory
	sumneko_binary = sumneko_install_path .. '/bin/lua-language-server'
end

local runtime_path = vim.split(package.path, ';')
table.insert(runtime_path, 'lua/?.lua')
table.insert(runtime_path, 'lua/?/init.lua')

local opts = { noremap=true, silent=false }
local on_attach = function(client, bufnr)

    require'lsp_signature'.on_attach(lsp_signature_configs, bufnr) -- no need to specify bufnr if you don't use toggle_key
	vim.o.wrap=false

    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
    vim.api.nvim_set_keymap('n', 'gd',       '<cmd>lua vim.lsp.buf.definition()<CR>zt', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gk',       '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gs',       '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
	-- vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd',       ':lua require(\'telescope.builtin\').lsp_definitions()<CR>', opts)

    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>lh',       '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>ls',       '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
	vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>ld',       ':lua require(\'telescope.builtin\').lsp_definitions()<CR>', opts)
	vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>lt',       ':lua require(\'telescope.builtin\').lsp_type_definitions()<CR>', opts)
	vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>lc',       ':lua require(\'telescope.builtin\').lsp_workspace_symbols({query="def"})<CR>', opts)
	vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>lC',       ':lua require(\'telescope.builtin\').lsp_document_symbols({query="def"})<CR>', opts)


end
require('lspconfig').sumneko_lua.setup({
	on_attach = on_attach,
	cmd = { sumneko_binary, '-E', sumneko_install_path .. '/main.lua' },
	settings = {
		Lua = {
			runtime = {
				-- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
				version = 'LuaJIT',
				-- Setup your lua path
				path = runtime_path,
			},
			diagnostics = {
				-- Get the language server to recognize the `vim` global
				globals = { 'vim' },
			},
			workspace = {
				-- Make the server aware of Neovim runtime files
				library = vim.api.nvim_get_runtime_file('', true),
			},
			-- Do not send telemetry data containing a randomized but unique identifier
			telemetry = {
				enable = false,
			},
		},
	},
})
