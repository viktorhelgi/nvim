
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
    -- border = "rounded"   -- double, rounded, single, shadow, none
    border = none
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

-- -- -- recommended:

local opts = { noremap=true, silent=false }
local opts_silent = { noremap=true, silent=true }
local my_on_attach = function(client, bufnr)
    require'lsp_signature'.on_attach(lsp_signature_configs, bufnr) -- no need to specify bufnr if you don't use toggle_key
    require("aerial").on_attach(client, bufnr)
    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
    -- vim.api.nvim_buf_set_option(bufnr, 'nowrap', 'true')
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>[', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>]', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gef', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'geq', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd',       '<cmd>lua vim.lsp.buf.definition()<CR>zt', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gk',       '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gI',       '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gD',       '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gr',       '<cmd>lua vim.lsp.buf.references()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gs',       '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<C-s>',       '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<C-p>',    '<cmd>winc l<CR><cmd>icargo', opts)
	vim.api.nvim_buf_set_keymap(bufnr,'n', '<leader>p', ':lua require("harpoon.term").sendCommand(1, "cargo run " .. vim.fn.expand(\'%\') .. "\\r") <CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>o', '<cmd>AerialToggle<CR>', opts)

	vim.api.nvim_buf_set_keymap(bufnr, 'n', '<C-g>',    ':lua require(\'telescope.builtin\').lsp_definitions()<CR>', opts)
	vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gt',       ':lua require(\'telescope.builtin\').lsp_type_definitions()<CR>', opts)
	vim.api.nvim_buf_set_keymap(bufnr, 'n', '<C-t>',    ':lua require(\'telescope.builtin\').lsp_type_definitions()<CR>', opts)
	vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gi',    	':lua require(\'telescope.builtin\').lsp_implementations()<CR>', opts)
	vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gc',       ':lua require(\'telescope.builtin\').lsp_workspace_symbols({query="def"})<CR>', opts)
	vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gC',       ':lua require(\'telescope.builtin\').lsp_document_symbols({query="def"})<CR>', opts)

	local prefix = '\\s*'
	local suffix = '\\s\\zs\\w*'

	local array_all = { 'impl', 'struct', 'fn', 'trait', 'enum', 'impl<T>' }
	local array_impl = { 'impl', 'impl<T>' }
	local array_struct = { 'struct', 'struct<T>' }
	local array_fn = { 'fn', 'fn<T>' }
	local array_trait = { 'trait', 'trait<T>' }
	local array_enum = { 'enum', 'enum<T>' }

	for i = 1,#array_all    do table.insert(array_all,    'pub ' .. array_all[i]) end
	for i = 1,#array_impl   do table.insert(array_impl,   'pub ' .. array_impl[i]) end
	for i = 1,#array_struct do table.insert(array_struct, 'pub ' .. array_struct[i]) end
	for i = 1,#array_fn     do table.insert(array_fn,     'pub ' .. array_fn[i]) end
	for i = 1,#array_trait  do table.insert(array_trait,  'pub ' .. array_trait[i]) end
	for i = 1,#array_enum   do table.insert(array_enum,   'pub ' .. array_enum[i]) end

	local sep = suffix .. '|^' .. prefix
	local string_all    =  '/\\v^'..prefix..table.concat(array_all    , sep)..suffix..'<CR>'.. ':set nohlsearch<CR>'
	local string_impl   =  '/\\v^'..prefix..table.concat(array_impl   , sep)..suffix..'<CR>'.. ':set nohlsearch<CR>'
	local string_struct =  '/\\v^'..prefix..table.concat(array_struct , sep)..suffix..'<CR>'.. ':set nohlsearch<CR>'
	local string_fn     =  '/\\v^'..prefix..table.concat(array_fn     , sep)..suffix..'<CR>'.. ':set nohlsearch<CR>'
	local string_trait  =  '/\\v^'..prefix..table.concat(array_trait  , sep)..suffix..'<CR>'.. ':set nohlsearch<CR>'
	local string_enum   =  '/\\v^'..prefix..table.concat(array_enum   , sep)..suffix..'<CR>'.. ':set nohlsearch<CR>'


	vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>ja',    string_all    , opts_silent)
	vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>ji',    string_impl   , opts_silent)
	vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>js',    string_struct , opts_silent)
	vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>jf',    string_fn     , opts_silent)
	vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>jt',    string_trait  , opts_silent)
	vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>je',    string_enum   , opts_silent)

    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>rn', ':lua require("harpoon.term").sendCommand(1, "cargo run \\r") <CR>', opts)
    -- vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>rt', ':lua require("harpoon.term").sendCommand(1, "pytest --no-header -v -rP " .. vim.fn.expand(\'%\') .. "\\r") <CR>', opts)
    -- vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>rp', ':lua require("harpoon.term").sendCommand(1, "python " .. vim.fn.expand(\'%\') .. "\\r")<CR>', opts)

    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>tt', ':lua require(\'telescope.builtin\').find_files({find_command={"C:/Users/Lenovo/scoop/shims/fd.exe", "test_",     "--type", "f",  "--extension", "rs"                         }})<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>tn', ':lua require(\'telescope.builtin\').find_files({find_command={"C:/Users/Lenovo/scoop/shims/fd.exe",             "--type", "f",  "--extension", "rs",    "--exclude", "tests"}})<CR>', opts)
end




-- local capabilities = vim.lsp.protocol.make_client_capabilities()
-- capabilities.textDocument.completion.completionItem.snippetSupport = true
require("lspconfig").rust_analyzer.setup {
    -- capabilities=capabilities,
    on_attach = my_on_attach,
	filetype = {'rs'}, 
    checkOnSave = {
        enable = true,
    },
    -- server = {
    --     path = "C:/Users/Lenovo/AppData/Roaming/nvim-data/lsp_servers/rust/rust-analyzer.exe"
    -- }
}




vim.cmd("setlocal indentexpr=")
-- vim.cmd("setlocal nowrap")

-- require('rust-tools').setup({})
