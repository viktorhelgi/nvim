--[[
	Setup script for the lua lsp server sumneko
--]]
--

local lsp_signature_configs = {
  debug = false, -- set to true to enable debug logging
  log_path = vim.fn.stdpath("cache") .. "/lsp_signature.log", -- log dir when debug is on
  -- default is  ~/.cache/nvim/lsp_signature.log
  verbose = false, -- show debug line number

  bind = true, -- This is mandatory, otherwise border config won't get registered.
               -- If you want to hook lspsaga or other signature handler, pls set to false
  doc_lines = 0 , -- will show two lines of comment/doc(if there are more than two lines in doc, will be truncated);
                 -- set to 0 if you DO NOT want any API comments be shown
                 -- This setting only take effect in insert mode, it does not affect signature help in normal
                 -- mode, 10 by default

  floating_window = false, -- show hint in a floating window, set to false for virtual text only mode

  floating_window_above_cur_line = true, -- try to place the floating above the current line when possible Note:
  -- will set to true when fully tested, set to false will use whichever side has more space
  -- this setting will be helpful if you do not want the PUM and floating win overlap

  --floating_window_off_x = 26, -- adjust float windows x position.
  floating_window_off_x = 0, -- adjust float windows x position.
  floating_window_off_y = 2, -- adjust float windows y position.


  fix_pos = false,  -- set to true, the floating window will not auto-close until finish all parameters
  hint_enable = true, -- virtual hint enable
  hint_prefix = "🐼 ",  -- Panda for parameter
  hint_scheme = "String",
  hi_parameter = "LspSignatureActiveParameter", -- how your parameter will be highlight
  max_height = 15, -- max height of signature floating_window, if content is more than max_height, you can scroll down
                   -- to view the hiding contents
  max_width = 76, -- max_width of signature floating_window, line will be wrapped if exceed max_width
  handler_opts = {
    border = "rounded"   -- double, rounded, single, shadow, none
    -- border = 'none'
  },

  always_trigger = true, -- sometime show signature on new line or in middle of parameter can be confusing, set it to false for #58

  auto_close_after = nil, -- autoclose signature float win after x sec, disabled if nil.
  extra_trigger_chars = {}, -- Array of extra characters that will trigger signature completion, e.g., {"(", ","}
  zindex = 200000, -- by default it will be on top of all floating windows, set to <= 50 send it to bottom

  padding = '', -- character to pad on left and right of signature can be ' ', or '|'  etc

  transparency = nil, -- disabled by default, allow floating win transparent value 1~100
  --transparency = 20,
  shadow_blend = 36, -- if you using shadow as border use this set the opacity
  shadow_guibg = 'Black', -- if you using shadow as border use this set the color e.g. 'Green' or '#121315'
  timer_interval = 2, -- default timer check interval set to lower value if you want to reduce latency
  toggle_key = '<C-s>' -- toggle signature on and off in insert mode,  e.g. toggle_key = '<M-x>'
}

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
if vim.loop.os_uname().sysname=="Linux" then
	-- set binary path to that with a system directory
	sumneko_binary = sumneko_install_path .. '/bin/' .. system_name .. '/lua-language-server'
else
	-- set binary path to just the (oddly) bin directory
	sumneko_binary = sumneko_install_path .. '/bin/lua-language-server'
end


-- local runtime_path = vim.api.nvim_get_runtime_file('', true)

local runtime_path = vim.split(package.path, ';')
table.insert(runtime_path, 'lua/?.lua')
table.insert(runtime_path, 'lua/?/init.lua')

if fn.has('win32') == 1 then
    table.insert(runtime_path, fn.stdpath('config') .. '/?.lua')
end


local library = {}

local function add(lib)
  for _, p in pairs(vim.fn.expand(lib, false, true)) do
    p = vim.loop.fs_realpath(p)
    library[p] = true
  end
end

-- add runtime

-- add your config

-- add plugins
-- if you're not using packer, then you might need to change the paths below
-- if fn.has('win32') == 1 then
    -- add("$VIMRUNTIME")
    -- add(fn.stdpath('config') )
    -- add(fn.stdpath('data') .. "site/pack/packer/opt/*")
    -- add(fn.stdpath('data') .. "site/pack/packer/start/*")
-- end















local opts = { noremap=true, silent=false }
local on_attach = function(client, bufnr)

    require'lsp_signature'.on_attach(lsp_signature_configs, bufnr) -- no need to specify bufnr if you don't use toggle_key
	vim.o.wrap=false

    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>[', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>]', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)

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
	vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>jn',    '/\\v^\\s*def\\s\\zs\\w*|^\\s*class\\s\\zs\\w*\\ze[:(]<CR>', opts)
	vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>js',    '/\\v^\\s*\\zsclass\\ze\\s|^\\s*\\zsdef\\ze\\s|^\\s*\\zsif\\ze\\s|^\\s*\\zsfor\\ze\\s|^\\s*\\zselif\\ze\\s|^\\s*\\zselse\\ze:|^\\s*\\zswhile\\ze\\s<CR>', opts)


end

-- local library = { fn.stdpath('data') .."site/pack/packer/start/" }

_G.library = library


-- local library = {"C:/Users/Lenovo/AppData/Local/nvim-data/site/pack/packer/start/nvim-cmp/lua/cmp/init"}
--
--
-- local array_with_prefix = {}
-- for i = 1,#array_all    do table.insert(array_all,    'pub ' .. array_all[i]) end

local capabilities = vim.lsp.protocol.make_client_capabilities()
-- capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)
capabilities.textDocument.completion.completionItem.snippetSupport = false

local cfg = {
    on_attach = on_attach,
    capabilities = capabilities,
    cmd = { '/home/viktor/.local/share/nvim/lsp_servers/sumneko_lua/extension/server/bin/lua-language-server' },
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
                checkThirdParty = false
                -- library = library
			},
			-- Do not send telemetry data containing a randomized but unique identifier
			telemetry = {
				enable = false,
			},
		},
	},
}


-- if vim.loop.os_uname().sysname == "Linux" then
--     local what = "that"
-- else
--     cfg.cmd = { sumneko_binary, '-E', sumneko_install_path .. '/main.lua' }
-- end

require('lspconfig').sumneko_lua.setup(cfg)
