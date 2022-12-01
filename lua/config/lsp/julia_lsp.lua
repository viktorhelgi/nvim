

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
    -- border = none
  },

  always_trigger = true, -- sometime show signature on new line or in middle of parameter can be confusing, set it to false for #58

  auto_close_after = nil, -- autoclose signature float win after x sec, disabled if nil.
  extra_trigger_chars = {"(", ","}, -- Array of extra characters that will trigger signature completion, e.g., {"(", ","}
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
local opt_sn = { noremap=true, silent=true }

local my_on_attach = function(client, bufnr)
    vim.cmd("set colorcolumn=80")
    ---------------------------------------------------------------------------------
    ---------------------------------------------------------------------------------

    require('lsp_signature').on_attach(lsp_signature_configs, bufnr) -- no need to specify bufnr if you don't use toggle_key
    require("aerial").on_attach(client, bufnr)

    ---------------------------------------------------------------------------------
    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

    -- vim.api.nvim_buf_set_option(bufnr, 'nowrap', 'true')
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>[', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>]', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gef', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'geq', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd',       '<cmd>lua vim.lsp.buf.definition()<CR>zt', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gk',       '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<C-s>',       '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
    -- vim.api.nvim_buf_set_keymap(bufnr, 'n', '<C-p>',    '<cmd>winc l<CR><cmd>icargo', opts)
	vim.api.nvim_buf_set_keymap(bufnr,'n', '<leader>p', ':lua require("harpoon.term").sendCommand(1, "cargo run " .. vim.fn.expand(\'%\') .. "\\r") <CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>o', '<cmd>AerialToggle<CR>', opts)

	vim.api.nvim_buf_set_keymap(bufnr, 'n', '<C-g>',    ':lua require(\'telescope.builtin\').lsp_definitions()<CR>', opts)
	vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gt',       ':lua require(\'telescope.builtin\').lsp_type_definitions()<CR>', opts)
	vim.api.nvim_buf_set_keymap(bufnr, 'n', '<C-t>',    ':lua require(\'telescope.builtin\').lsp_type_definitions()<CR>', opts)
	vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gI',    	':lua require(\'telescope.builtin\').lsp_implementations({ignore_filenames=false, path_display=hidden})<CR>', opts)
	-- vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gc',       ':lua require(\'telescope.builtin\').lsp_workspace_symbols({query="def"})<CR>', opts)
	vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gC',       ':lua require(\'telescope.builtin\').lsp_document_symbols({query="def"})<CR>', opts)

    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gi',       '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gD',       '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gr',       '<cmd>lua vim.lsp.buf.references()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gs',       '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)



    ---------------------------------------------------------------------------------
    ---------------------------------------------------------------------------------


	local prefix = '\\s*'
	local suffix = '\\s\\zs\\w*'

	local array_all = { 'impl', 'struct', 'fn', 'trait', 'enum', 'impl<T>' }
	local array_impl = { 'impl', 'impl<T>' }
	local array_struct = { 'struct', 'struct<T>' }
	local array_fn = { 'fn', 'fn<T>' }
	local array_trait = { 'trait', 'trait<T>' }
	local array_enum = { 'enum', 'enum<T>' }
	local array_mod_use = { 'mod', 'use' }

	for i = 1,#array_all    do table.insert(array_all,    'pub ' .. array_all[i]) end
	for i = 1,#array_impl   do table.insert(array_impl,   'pub ' .. array_impl[i]) end
	for i = 1,#array_struct do table.insert(array_struct, 'pub ' .. array_struct[i]) end
	for i = 1,#array_fn     do table.insert(array_fn,     'pub ' .. array_fn[i]) end
	for i = 1,#array_trait  do table.insert(array_trait,  'pub ' .. array_trait[i]) end
	for i = 1,#array_enum   do table.insert(array_enum,   'pub ' .. array_enum[i]) end
	for i = 1,#array_mod_use   do table.insert(array_mod_use,   'pub ' .. array_mod_use[i]) end

    local array_mod_pub = 'pub'

	local sep = suffix .. '|^' .. prefix
	local string_all    =  '/\\v^'..prefix..table.concat(array_all    , sep)..suffix..'<CR>'.. ':set nohlsearch<CR>'
	local string_impl   =  '/\\v^'..prefix..table.concat(array_impl   , sep)..suffix..'<CR>'.. ':set nohlsearch<CR>'
	local string_struct =  '/\\v^'..prefix..table.concat(array_struct , sep)..suffix..'<CR>'.. ':set nohlsearch<CR>'
	local string_fn     =  '/\\v^'..prefix..table.concat(array_fn     , sep)..suffix..'<CR>'.. ':set nohlsearch<CR>'
	local string_trait  =  '/\\v^'..prefix..table.concat(array_trait  , sep)..suffix..'<CR>'.. ':set nohlsearch<CR>'
	local string_enum   =  '/\\v^'..prefix..table.concat(array_enum   , sep)..suffix..'<CR>'.. ':set nohlsearch<CR>'
	local string_mod_use   =  '/\\v^'..prefix..table.concat(array_mod_use   , sep)..suffix..'<CR>'.. ':set nohlsearch<CR>'
	local string_pub   =  '/\\v^'..prefix..array_mod_pub..suffix..'<CR>'.. ':set nohlsearch<CR>'


	vim.api.nvim_buf_set_keymap(bufnr, '', '<leader>na',    string_all    , opt_sn)
	vim.api.nvim_buf_set_keymap(bufnr, '', '<leader>ni',    string_impl   , opt_sn)
	vim.api.nvim_buf_set_keymap(bufnr, '', '<leader>ns',    string_struct , opt_sn)

	vim.api.nvim_buf_set_keymap(bufnr, '', '<leader>nf',    string_fn     , opt_sn)
	vim.api.nvim_buf_set_keymap(bufnr, '', '<leader>nn',    string_fn     , opt_sn)

	vim.api.nvim_buf_set_keymap(bufnr, '', '<leader>nt',    string_trait  , opt_sn)
	vim.api.nvim_buf_set_keymap(bufnr, '', '<leader>ne',    string_enum   , opt_sn)
	vim.api.nvim_buf_set_keymap(bufnr, '', '<leader>nm',    string_mod_use   , opt_sn)
	vim.api.nvim_buf_set_keymap(bufnr, '', '<leader>np',    string_pub   , opt_sn)



    ---------------------------------------------------------------------------------
    -- vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>rn', ':lua require("harpoon.term").sendCommand(1, "cargo test \\r") <CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>ra', ':lua require("harpoon.term").sendCommand(1, "cargo test \\r") <CR>', opts)
    -- vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>rn', ':lua require("harpoon.term").sendCommand(1, "cargo test \\r") <CR>', opts)
    -- vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>rp', ':lua require("harpoon.term").sendCommand(1, "cargo run \\r") <CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>r1', ':lua require("harpoon.term").sendCommand(1, "cargo run To poem.txt\\r") <CR>', opts)


    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>rn', ':AerialPrev<CR>W:RustHoverActions<CR>:RustHoverActions<CR>', opts)

    local python_exe = 'C:/Users/Lenovo/miniconda3/envs/LSPenv/python'
    vim.g.python3_host_prog = python_exe
    -- vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>rp', ':lua require("harpoon.term").sendCommand(1, "'..python_exe..' " .. vim.fn.expand(\'%\') .. "\\r")<CR>', opts)

    local fd_exe = "C:/Users/Lenovo/scoop/shims/fd.exe"
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>tt', ':lua require(\'telescope.builtin\').find_files({find_command={"' .. fd_exe .. '", "test_",     "--type", "f",  "--extension", "rs"                         }})<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>tn', ':lua require(\'telescope.builtin\').find_files({find_command={"' .. fd_exe .. '",             "--type", "f",  "--extension", "rs",    "--exclude", "tests"}})<CR>', opts)

    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>tit', ':lua require(\'telescope.builtin\').find_files({find_command={"' .. fd_exe .. '", "--full-path", "tests", "--extension", ".rs"}})<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>tis', ':lua require(\'telescope.builtin\').find_files({find_command={"' .. fd_exe .. '", "--full-path", "src", "--extension", ".rs"}})<CR>', opts)

    -- vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>rN', '<cmd>lua require("harpoon.term").sendCommand(1, "include(\\"" .. vim.fn.expand(\'%\'):match(\'[^\\\\]*.jl$\') .. "\\")\\r") <CR>', opt_sn)
    -- vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>rN', '<cmd>lua require("harpoon.term").sendCommand(1, "include(\\"" .. table.concat(split(vim.fn.expand(\'%\'), "\\") .. "\\")\\r") <CR>', opt_sn)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>rN', '<cmd>lua require("harpoon.term").sendCommand(1, "include(\\"" .. table.concat(split(vim.fn.expand(\'%\'), "\\\\"), "/") .. "\\")\\r") <CR>', opt_sn)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>Js', '<cmd>lua require("harpoon.term").sendCommand(1, "julia --project=.\\r") <CR>', opt_sn)
    -- vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>Jg', '<cmd>lua require("harpoon.term").sendCommand(1, "julia --project=.\\r") <CR>', opt_sn)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>Jg', '<cmd>lua require("harpoon.term").sendCommand(1, "julia -e \\"using Pkg; Pkg.generate(\\\\\\"" .. split( vim.fn.expand(\'%:p\'), \'\\\\\')[table.getn(split( vim.fn.expand(\'%:p\'), \'\\\\\')) -1] .. "\\\\\\")\\"\\r") <CR>', opt_sn)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>M', ':lua vim.fn.expand(\'%\'):match(\'[\\^\\]*.jl$\')', opt_sn)


    ---------------------------------------------------------------------------------
    ---------------------------------------------------------------------------------
    ---------------------------------------------------------------------------------
    ---------------------------------------------------------------------------------
    require('which-key').register({
        n = {
            name = "Jump",
            a = "All",
            i = "Implementation",
            s = "Struct",
            f = "Function",
            t = "Trait",
            e = "Enum",
            m = "mod/use"
        },
    }, {
        prefix = '<leader>',
    })

    ---------------------------------------------------------------------------------
    ---------------------------------------------------------------------------------
    if client.server_capabilities.document_highlight then
        vim.cmd [[ hi! LspReferenceRead cterm=bold ctermbg=red guibg=LightYellow ]]
        vim.cmd [[ hi! LspReferenceText cterm=bold ctermbg=red guibg=LightYellow]]
        vim.cmd [[ hi! LspReferenceWrite cterm=bold ctermbg=red guibg=LightYellow]]
        vim.api.nvim_create_augroup('lsp_document_highlight', {
            clear = false
        })
        vim.api.nvim_clear_autocmds({
            buffer = bufnr,
            group = 'lsp_document_highlight',
        })
        vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
            group = 'lsp_document_highlight',
            buffer = bufnr,
            callback = vim.lsp.buf.document_highlight,
        })
        vim.api.nvim_create_autocmd('CursorMoved', {
            group = 'lsp_document_highlight',
            buffer = bufnr,
            callback = vim.lsp.buf.clear_references,
        })
    end
end



local lspconfig = require('lspconfig')

local capabilities = vim.lsp.protocol.make_client_capabilities()
-- capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)
capabilities.textDocument.completion.completionItem.snippetSupport = false


lspconfig.julials.setup({
    capabilities = capabilities,
    on_attach = my_on_attach,
    settings = {
        julia = {
            analysis = {
                stubPath = 'C:/Users/Lenovo/.julia/packages'
            }
        }
    },
    on_new_config = function(new_config, _)
        local julia = vim.fn.expand("C:/Users/Lenovo/AppData/Local/Programs/Julia-1.7.3/bin/julia")
        if require'lspconfig'.util.path.is_file(julia) then
            new_config.cmd[1] = julia
        end
    end,
--     on_attach = on_attach_julia,
    filetypes = {'julia'},

    -- "--project=.",
    --
    cmd = { "julia", "--startup-file=no", "--history-file=no", "-e", '    # Load LanguageServer.jl: attempt to load from ~/.julia/environments/nvim-lspconfig\n    # with the regular load path as a fallback\n    ls_install_path = joinpath(\n        get(DEPOT_PATH, 1, joinpath(homedir(), ".julia")),\n        "environments", "nvim-lspconfig"\n    )\n    pushfirst!(LOAD_PATH, ls_install_path)\n    using LanguageServer\n    popfirst!(LOAD_PATH)\n    depot_path = get(ENV, "JULIA_DEPOT_PATH", "")\n    project_path = let\n        dirname(something(\n            ## 1. Finds an explicitly set project (JULIA_PROJECT)\n            Base.load_path_expand((\n                p = get(ENV, "JULIA_PROJECT", nothing);\n                p === nothing ? nothing : isempty(p) ? nothing : p\n            )),\n            ## 2. Look for a Project.toml file in the current working directory,\n            ##    or parent directories, with $HOME as an upper boundary\n            Base.current_project(),\n            ## 3. First entry in the load path\n            get(Base.load_path(), 1, nothing),\n            ## 4. Fallback to default global environment,\n            ##    this is more or less unreachable\n            Base.load_path_expand("@v#.#"),\n        ))\n    end\n    @info "Running language server" VERSION pwd() project_path depot_path\n    server = LanguageServer.LanguageServerInstance(stdin, stdout, project_path, depot_path)\n    server.runlinter = true\n    run(server)\n  ' }
    -- cmd = { "julia", "--startup-file=no",  "--history-file=no", "-e", table.concat({
    --     '    # Load LanguageServer.jl: attempt to load from ~/.julia/environments/nvim-lspconfig',
    --     '    # with the regular load path as a fallback',
    --     '    ls_install_path = joinpath(',
    --     '        get(DEPOT_PATH, 1, joinpath(homedir(), ".julia")),',
    --     '        "environments", "nvim-lspconfig"',
    --     '    )',
    --     '    pushfirst!(LOAD_PATH, ls_install_path)',
    --     '    using LanguageServer',
    --     '    popfirst!(LOAD_PATH)',
    --     '    depot_path = get(ENV, "JULIA_DEPOT_PATH", "")',
    --     '    project_path = let',
    --     '        dirname(something(',
    --     '            ## 1. Finds an explicitly set project (JULIA_PROJECT)',
    --     '            Base.load_path_expand((',
    --     '                p = get(ENV, "JULIA_PROJECT", nothing);',
    --     '                p === nothing ? nothing : isempty(p) ? nothing : p',
    --     '            )),',
    --     '            ## 2. Look for a Project.toml file in the current working directory,',
    --     '            ##    or parent directories, with $HOME as an upper boundary',
    --     '            Base.current_project(),',
    --     '            ## 3. First entry in the load path',
    --     '            get(Base.load_path(), 1, nothing),',
    --     '            ## 4. Fallback to default global environment,',
    --     '            ##    this is more or less unreachable',
    --     '            Base.load_path_expand("@v#.#"),',
    --     '        ))',
    --     '    end',
    --     '    @info "Running language server" VERSION pwd() project_path depot_path',
    --     '    server = LanguageServer.LanguageServerInstance(stdin, stdout, project_path, depot_path)',
    --     '    server.runlinter = true',
    --     '    run(server)',
    --     '  '}, '\n')
    -- }
})


local opt = { silent=true } --empty opt for maps with no extra options



-- map('n', '<F2>', ':w<CR>:winc l<CR>iinclude("create_available_chamfer.jl")<CR>', opt)



-- vim.api.nvim_set_keymap('n', '<leader>rN', '<cmd>lua require("harpoon.term").sendCommand(1, "include(\\"" .. vim.fn.expand(\'%\'):match(\'[^\\\\]*.jl$\') .. "\\")\\r") <CR>', opt_sn)

-- vim.api.nvim_set_keymap('n', '<leader>rN', '<cmd>lua require("harpoon.term").sendCommand(1, "include(\\"" .. table.concat(split(vim.fn.expand(\'%\'), "\\\\"), "/") .. "\\")\\r") <CR>', opt_sn)









-- vim.api.nvim_set_keymap('n', '<leader>JJ', '<cmd>lua require("harpoon.term").sendCommand(1, "julia -e \'using Pkg; Pkg.generate(\\\\\\"" .. split( vim.fn.expand(\'%:p\'), \'\\\\\')[table.getn(split( vim.fn.expand(\'%:p\'), \'\\\\\')) -1] .. "\\")\'\\r") <CR>', opt_sn)
