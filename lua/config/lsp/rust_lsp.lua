
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
    ---------------------------------------------------------------------------------
    ---------------------------------------------------------------------------------

    require'lsp_signature'.on_attach(lsp_signature_configs, bufnr) -- no need to specify bufnr if you don't use toggle_key
    require("aerial").on_attach(client, bufnr)

    ---------------------------------------------------------------------------------
    ---------------------------------------------------------------------------------
    
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

	local sep = suffix .. '|^' .. prefix
	local string_all    =  '/\\v^'..prefix..table.concat(array_all    , sep)..suffix..'<CR>'.. ':set nohlsearch<CR>'
	local string_impl   =  '/\\v^'..prefix..table.concat(array_impl   , sep)..suffix..'<CR>'.. ':set nohlsearch<CR>'
	local string_struct =  '/\\v^'..prefix..table.concat(array_struct , sep)..suffix..'<CR>'.. ':set nohlsearch<CR>'
	local string_fn     =  '/\\v^'..prefix..table.concat(array_fn     , sep)..suffix..'<CR>'.. ':set nohlsearch<CR>'
	local string_trait  =  '/\\v^'..prefix..table.concat(array_trait  , sep)..suffix..'<CR>'.. ':set nohlsearch<CR>'
	local string_enum   =  '/\\v^'..prefix..table.concat(array_enum   , sep)..suffix..'<CR>'.. ':set nohlsearch<CR>'
	local string_mod_use   =  '/\\v^'..prefix..table.concat(array_mod_use   , sep)..suffix..'<CR>'.. ':set nohlsearch<CR>'


	vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>na',    string_all    , opts_silent)
	vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>ni',    string_impl   , opts_silent)
	vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>ns',    string_struct , opts_silent)
	vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>nf',    string_fn     , opts_silent)
	vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>nt',    string_trait  , opts_silent)
	vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>ne',    string_enum   , opts_silent)
	vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>nm',    string_mod_use   , opts_silent)


    ---------------------------------------------------------------------------------
    ---------------------------------------------------------------------------------
    
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>rn', ':lua require("harpoon.term").sendCommand(1, "cargo run \\r") <CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>rp', ':lua require("harpoon.term").sendCommand(1, "cargo run \\r") <CR>', opts)

    -- Rust
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>rc', ':RustCodeAction<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>rd', ':RustDebuggables<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>rD', ':RustDisableInlayHints<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>re', ':RustEmitAsm<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>rei', ':RustEmitIr<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>ree', ':RustExpand<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>reE', ':RustExpandMacro<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>rf',  ':RustFmt<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>rF',  ':RustFmtRange<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>rHs', ':RustSetInlayHints<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>rHt', ':RustToggleInlayHints<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>rha', ':RustHoverActions<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>rhr', ':RustHoverRange<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>rj', ':RustJoinLines<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>rmu', ':RustMoveItemUp<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>rmd', ':RustMoveItemDown<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>roc', ':RustOpenCargo<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>roe', ':RustOpenExternalDocs<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>rp', ':RustParentModule<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>rP', ':RustPlay<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>rrr', ':RustRun<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>rrR', ':RustRunnables<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>rrw', ':RustReloadWorkspace<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>rs', ':RustSSR<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>rS', ':RustStartStandaloneServerForBuffer<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>rC', ':RustViewCrateGraph<CR>', opts)


    ---------------------------------------------------------------------------------
    ---------------------------------------------------------------------------------
    

    -- vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>rt', ':lua require("harpoon.term").sendCommand(1, "pytest --no-header -v -rP " .. vim.fn.expand(\'%\') .. "\\r") <CR>', opts)
    -- vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>rp', ':lua require("harpoon.term").sendCommand(1, "python " .. vim.fn.expand(\'%\') .. "\\r")<CR>', opts)

    -- vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>tt', ':lua require(\'telescope.builtin\').find_files({find_command={"C:/Users/Lenovo/scoop/shims/fd.exe", "test_",     "--type", "f",  "--extension", "rs"                         }})<CR>', opts)
    -- vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>tn', ':lua require(\'telescope.builtin\').find_files({find_command={"C:/Users/Lenovo/scoop/shims/fd.exe",             "--type", "f",  "--extension", "rs",    "--exclude", "tests"}})<CR>', opts)

    if vim.loop.os_uname().sysname=="Linux" then
        local python_exe = '/usr/bin/python3.8'
	    vim.g.python3_host_prog = python_exe
        -- vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>rp', ':lua require("harpoon.term").sendCommand(1, "cargo run " .. vim.fn.expand(\'%\') .. "\\r")<CR>', opts)

        local fd_exe = '/usr/bin/fdfind'
        vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>tt', ':lua require(\'telescope.builtin\').find_files({find_command={"' .. fd_exe .. '", "test_",     "--type", "f",  "--extension", "rs"                         }})<CR>', opts)
        vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>tn', ':lua require(\'telescope.builtin\').find_files({find_command={"' .. fd_exe .. '",             "--type", "f",  "--extension", "rs",    "--exclude", "tests"}})<CR>', opts)

    else
        local python_exe = 'C:/Users/Lenovo/miniconda3/envs/LSPenv/python'
	    vim.g.python3_host_prog = python_exe
        -- vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>rp', ':lua require("harpoon.term").sendCommand(1, "'..python_exe..' " .. vim.fn.expand(\'%\') .. "\\r")<CR>', opts)

        local fd_exe = "C:/Users/Lenovo/scoop/shims/fd.exe"
        vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>tt', ':lua require(\'telescope.builtin\').find_files({find_command={"' .. fd_exe .. '", "test_",     "--type", "f",  "--extension", "rs"                         }})<CR>', opts)
        vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>tn', ':lua require(\'telescope.builtin\').find_files({find_command={"' .. fd_exe .. '",             "--type", "f",  "--extension", "rs",    "--exclude", "tests"}})<CR>', opts)
    end

    ---------------------------------------------------------------------------------
    ---------------------------------------------------------------------------------
    ---------------------------------------------------------------------------------
    ---------------------------------------------------------------------------------
    require('which-key').register({
        j = {
            name = "Jump",
            a = "All",
            i = "Implementation",
            s = "Struct",
            f = "Function",
            t = "Trait",
            e = "Enum",
            m = "mod/use"
        },
        r = {
            name = 'Rust',
            c = "RustCodeAction",
            d = "Debuggables",
            D = "DisableInlayHints",
            e = {
                name = "E",
                a = "EmitAsm",
                i = "EmitIr",
                e = "Expand",
                E = "ExpandMacro"
            },
            f = "Fmt",
            F = "FmtRange",
            H = {
                name = "Hints",
                s = "RustSetInlayHints",
                t = "RustToggleInlayHints"
            },
            h = {
                name = "Hover",
                a = "HoverActions",
                r = "HoverRange"
            },
            j = "JoinLines",
            m = {
                name = "MoveItem",
                u = "MoveItemUp",
                d = "MoveItemDown",
            },
            o = {
                name = "Open",
                c = "OpenCargo",
                e = "OpenExternalDocs",
            },
            p = "ParentModule",
            P = "RustPlay",
            r = {
                name = "R",
                r = "RustRun",
                R = "RustRunnables",
                w = "RustReloadWorkspace"
            },
            s = "RustSSR",
            S = "StartServer",
            C = "RustViewCrateGraph"
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

    ---------------------------------------------------------------------------------
    ---------------------------------------------------------------------------------
    
end


local lspconfig = require('lspconfig')


-- local capabilities = vim.lsp.protocol.make_client_capabilities()
-- capabilities.textDocument.completion.completionItem.snippetSupport = true
-- lspconfig.rust_analyzer.setup({
--     -- capabilities=capabilities,
--     on_attach = my_on_attach,
-- 	filetypes = {'rust', 'rs'},
--     checkOnSave = {
--         enable = true,
--     },
--     -- server = {
--     --     path = "C:/Users/Lenovo/AppData/Roaming/nvim-data/lsp_servers/rust/rust-analyzer.exe"
--     -- }
-- })
--
-- require'cmp'.setup {
  -- sources = {
    -- { name = 'nvim_lsp' }
  -- }
-- }

-- The nvim-cmp almost supports LSP's capabilities so You should advertise it to LSP servers..
-- local capabilities = vim.lsp.protocol.make_client_capabilities()
-- capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)





vim.cmd("setlocal indentexpr=")
-- vim.cmd("setlocal nowrap")



local cmp = require'cmp'

cmp.setup({
    snippet = { 
        -- REQUIRED - you must specify a snippet engine 
        expand = function(args) 
            vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
            -- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
            -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
            -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users. 
        end,
    },
    window = {
        -- completion = cmp.config.window.bordered(),
        -- documentation = cmp.config.window.bordered(),
    },
    mapping = cmp.mapping.preset.insert({
        ['<C-b>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.abort(),
        ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    }),
    sources = cmp.config.sources({
        { name = 'nvim_lsp' },
        { name = 'vsnip' }, -- For vsnip users.
        -- { name = 'luasnip' }, -- For luasnip users.
        -- { name = 'ultisnips' }, -- For ultisnips users.
        -- { name = 'snippy' }, -- For snippy users.
    }, {
        { name = 'buffer' },
    })
})

-- Set configuration for specific filetype.
cmp.setup.filetype('gitcommit', {
    sources = cmp.config.sources({
        { name = 'cmp_git' }, -- You can specify the `cmp_git` source if you were installed it.
    }, {
        { name = 'buffer' },
    })
})

-- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline('/', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
        { name = 'buffer' }
    }
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
        { name = 'path' }
    }, {
        { name = 'cmdline' }
    })
})

-- Setup lspconfig.
local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())





local rust_tools_opts = {
    capabilities = capabilities,
    filetypes = {"rs"},
    tools = { -- rust-tools options
        autoSetHints = true,
        hover_with_actions = true,
        inlay_hints = {
            show_parameter_hints = true,
            parameter_hints_prefix = " ",
            other_hints_prefix = "  ",
            highlight = "VirtualTextHint"
            --📜💡
            --, , , , , ,  
        },
    },

    -- all the opts to send to nvim-lspconfig
    -- these override the defaults set by rust-tools.nvim
    -- see https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#rust_analyzer
    server = {
        -- on_attach is a callback called when the language server attachs to the buffer
        on_attach = my_on_attach,
        settings = {
            -- to enable rust-analyzer settings visit:
            -- https://github.com/rust-analyzer/rust-analyzer/blob/master/docs/user/generated_config.adoc
            ["rust-analyzer"] = {
                -- enable clippy on save
                checkOnSave = {
                    command = "clippy"
                },
            }
        }
    },
}
require("rust-tools").setup(rust_tools_opts)
