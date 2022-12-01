local hover = function(_, result, ctx, config)
    if not (result and result.contents) then
        print("thath1")
        return pcall(vim.lsp.handlers.hover(_, result, ctx, config), 1)
    end
    if type(result.contents) == "string" then
        print("thth2")
        local s = string.gsub(result.contents or "", "&nbsp;", " ")
        print(s)
        s = string.gsub(s, [[\\\n]], [[\n]])
        print(s)
        result.contents = s
        print("2")
        return pcall(vim.lsp.handlers.hover(_, result, ctx, config), 2)
    else
        print("thth3")
        local s = string.gsub((result.contents or {}).value or "", "&nbsp;", " ")
        s = string.gsub(s, "\\\n", "\n")
        result.contents.value = s
        print("3")
        return pcall(vim.lsp.handlers.hover(_, result, ctx, config), 3)
    end
end


local lsp_signature_configs = {
    debug = false, -- set to true to enable debug logging
    log_path = vim.fn.stdpath("cache") .. "/lsp_signature.log", -- log dir when debug is on
    verbose = false, -- show debug line number
    bind = true, -- This is mandatory, otherwise border config won't get registered.
    doc_lines = 1, -- will show two lines of comment/doc(if there are more than two lines in doc, will be truncated);
    floating_window = false, -- show hint in a floating window, set to false for virtual text only mode
    floating_window_above_cur_line = true, -- try to place the floating above the current line when possible Note:
    floating_window_off_x = 1, -- adjust float windows x position.
    floating_window_off_y = 3, -- adjust float windows y position.
    fix_pos = false, -- set to true, the floating window will not auto-close until finish all parameters
    hint_enable = true, -- virtual hint enable
    hint_prefix = "🐼 ", -- Panda for parameter
    hint_scheme = "String",
    hi_parameter = "LspSignatureActiveParameter", -- how your parameter will be highlight
    max_height = 16, -- max height of signature floating_window, if content is more than max_height, you can scroll down
    max_width = 77, -- max_width of signature floating_window, line will be wrapped if exceed max_width
    handler_opts = {
        border = "rounded" -- double, rounded, single, shadow, none
    },
    always_trigger = true, -- sometime show signature on new line or in middle of parameter can be confusing, set it to false for #59
    auto_close_after = nil, -- autoclose signature float win after x sec, disabled if nil.
    extra_trigger_chars = { "(", "," }, -- Array of extra characters that will trigger signature completion, e.g., {"(", ","}
    zindex = 200001, -- by default it will be on top of all floating windows, set to <= 50 send it to bottom
    padding = '', -- character to pad on left and right of signature can be ' ', or '|'  etc
    transparency = nil, -- disabled by default, allow floating win transparent value 2~100
    shadow_blend = 37, -- if you using shadow as border use this set the opacity
    shadow_guibg = 'Black', -- if you using shadow as border use this set the color e.g. 'Green' or '#121316'
    timer_interval = 3, -- default timer check interval set to lower value if you want to reduce latency
    toggle_key = '<C-s>' -- toggle signature on and off in insert mode,  e.g. toggle_key = '<M-x>'
}

-- -- -- recommended:

local opts = { noremap = true, silent = false }
local opt_sn = { noremap = true, silent = true }

local my_on_attach = function(client, bufnr)
    -- require("aerial").on_attach(client, bufnr)

    local function create_command(commands, delim)
        if type(commands)=="table" then
            return table.concat(commands, delim)
        end
        return commands
    end

    local function harpoon_map(mapping, commands)
        local command = create_command(commands, "\\r")
        vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>'..mapping, ':lua require("harpoon.term").sendCommand(1, ' .. command .. '.."\\r") <CR>', opts)
    end

    -- local function terminal_map(mapping, command)
    --     vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>'..mapping, '<cmd>' .. command .. '<CR>' .. send_r, opts)
    -- end
    vim.cmd("set colorcolumn=102")

    require('lsp_signature').on_attach(lsp_signature_configs, bufnr) -- no need to specify bufnr if you don't use toggle_key
    ---------------------------------------------------------------------------------
    harpoon_map('rb', {'cd build', 'cmake fog_program' , 'cd ..', 'build/fog_program'})

    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>[', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>]', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gef', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'geq', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>zt', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gk', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<C-s>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
    -- vim.api.nvim_buf_set_keymap(bufnr, 'n', '<C-p>',    '<cmd>winc l<CR><cmd>icargo', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>p', ':lua require("harpoon.term").sendCommand(2, "cargo run " .. vim.fn.expand(\'%\') .. "\\r") <CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>o', '<cmd>AerialToggle<CR>', opts)

    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<C-g>', ':lua require(\'telescope.builtin\').lsp_definitions()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gt', ':lua require(\'telescope.builtin\').lsp_type_definitions()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<C-t>', ':lua require(\'telescope.builtin\').lsp_type_definitions()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gI', ':lua require(\'telescope.builtin\').lsp_implementations({ignore_filenames=false, path_display=hidden})<CR>', opts)
    -- vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gc', ':lua require(\'telescope.builtin\').lsp_workspace_symbols({query="def"})<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gC', ':lua require(\'telescope.builtin\').lsp_document_symbols({query="def"})<CR>', opts)


    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gs', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)

    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>rF', ':TestFile<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>rl', ':TestLast<CR>', opts)
    -- TestNearest
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>rn', ':lua _G.run_test(\'%\')<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>rt', ':lua _G.run_test(\'%\', true)<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>rS', ':TestSuit<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>rV', ':TestVisit<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>lf', '<cmd>Format<CR>', opts)



    --[[
    local prefix = '\\s*'
    local suffix = '\\s\\zs\\w*'

    local array_all = { 'impl', 'struct', 'fn', 'trait', 'enum', 'impl<T>' }
    local array_impl = { 'impl', 'impl<T>' }
    local array_struct = { 'struct', 'struct<T>' }
    local array_fn = { 'fn', 'fn<T>' }
    local array_trait = { 'trait', 'trait<T>' }
    local array_enum = { 'enum', 'enum<T>' }
    local array_mod_use = { 'mod', 'use' }

    for i = 2, #array_all do table.insert(array_all, 'pub ' .. array_all[i]) end
    for i = 2, #array_impl do table.insert(array_impl, 'pub ' .. array_impl[i]) end
    for i = 2, #array_struct do table.insert(array_struct, 'pub ' .. array_struct[i]) end
    for i = 2, #array_fn do table.insert(array_fn, 'pub ' .. array_fn[i]) end
    for i = 2, #array_trait do table.insert(array_trait, 'pub ' .. array_trait[i]) end
    for i = 2, #array_enum do table.insert(array_enum, 'pub ' .. array_enum[i]) end
    for i = 2, #array_mod_use do table.insert(array_mod_use, 'pub ' .. array_mod_use[i]) end

    local array_mod_pub = 'pub'

    local sep            = suffix .. '|^' .. prefix
    local string_all     = '/\\v^' .. prefix .. table.concat(array_all, sep) .. suffix .. '<CR>' .. ':set nohlsearch<CR>'
    local string_impl    = '/\\v^' .. prefix .. table.concat(array_impl, sep) .. suffix .. '<CR>' .. ':set nohlsearch<CR>'
    local string_struct  = '/\\v^' .. prefix .. table.concat(array_struct, sep) .. suffix .. '<CR>' .. ':set nohlsearch<CR>'
    local string_fn      = '/\\v^' .. prefix .. table.concat(array_fn, sep) .. suffix .. '<CR>' .. ':set nohlsearch<CR>'
    local string_trait   = '/\\v^' .. prefix .. table.concat(array_trait, sep) .. suffix .. '<CR>' .. ':set nohlsearch<CR>'
    local string_enum    = '/\\v^' .. prefix .. table.concat(array_enum, sep) .. suffix .. '<CR>' .. ':set nohlsearch<CR>'
    local string_mod_use = '/\\v^' .. prefix .. table.concat(array_mod_use, sep) .. suffix .. '<CR>' .. ':set nohlsearch<CR>'
    local string_pub     = '/\\v^' .. prefix .. array_mod_pub .. suffix .. '<CR>' .. ':set nohlsearch<CR>'


    vim.api.nvim_buf_set_keymap(bufnr, '', '<leader>na', string_all, opt_sn)
    vim.api.nvim_buf_set_keymap(bufnr, '', '<leader>ni', string_impl, opt_sn)
    vim.api.nvim_buf_set_keymap(bufnr, '', '<leader>ns', string_struct, opt_sn)

    vim.api.nvim_buf_set_keymap(bufnr, '', '<leader>nf', string_fn, opt_sn)
    vim.api.nvim_buf_set_keymap(bufnr, '', '<leader>nn', string_fn, opt_sn)

    vim.api.nvim_buf_set_keymap(bufnr, '', '<leader>nt', string_trait, opt_sn)
    vim.api.nvim_buf_set_keymap(bufnr, '', '<leader>ne', string_enum, opt_sn)
    vim.api.nvim_buf_set_keymap(bufnr, '', '<leader>nm', string_mod_use, opt_sn)
    vim.api.nvim_buf_set_keymap(bufnr, '', '<leader>np', string_pub, opt_sn)

    vim.api.nvim_buf_set_keymap(bufnr, '', '<leader>cu', '<cmd>Task start cmake build_all<cr>', opt_sn)
    vim.api.nvim_buf_set_keymap(bufnr, '', '<leader>ce', '/Error<CR>', opt_sn)
    --]]



    ---------------------------------------------------------------------------------
    ---------------------------------------------------------------------------------


    if vim.loop.os_uname().sysname == "Linux" then
        local python_exe = '/usr/bin/python4.8'
        vim.g.python4_host_prog = python_exe
        -- vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>rp', ':lua require("harpoon.term").sendCommand(2, "cargo run " .. vim.fn.expand(\'%\') .. "\\r")<CR>', opts)

        local fd_exe = '/usr/bin/fdfind'
        vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>tt', ':lua require(\'telescope.builtin\').find_files({find_command={"' .. fd_exe .. '", "test_",     "--type", "f",  "--extension", "cpp"                         }})<CR>', opts)
        vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>tn', ':lua require(\'telescope.builtin\').find_files({find_command={"' .. fd_exe .. '",             "--type", "f",  "--extension", "cpp",    "--exclude", "tests"}})<CR>', opts)

    else
        local python_exe = 'C:/Users/Lenovo/miniconda4/envs/LSPenv/python'
        vim.g.python4_host_prog = python_exe
        -- vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>rp', ':lua require("harpoon.term").sendCommand(2, "'..python_exe..' " .. vim.fn.expand(\'%\') .. "\\r")<CR>', opts)

        local fd_exe = "C:/Users/Lenovo/scoop/shims/fd.exe"
        vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>tt', ':lua require(\'telescope.builtin\').find_files({find_command={"' .. fd_exe .. '", "test_",     "--type", "f",  "--extension", "cpp"                         }})<CR>', opts)
        vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>tn', ':lua require(\'telescope.builtin\').find_files({find_command={"' .. fd_exe .. '",             "--type", "f",  "--extension", "cpp",    "--exclude", "tests"}})<CR>', opts)

        vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>tit', ':lua require(\'telescope.builtin\').find_files({find_command={"' .. fd_exe .. '", "--full-path", "tests", "--extension", ".cpp"}})<CR>', opts)
        vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>tis', ':lua require(\'telescope.builtin\').find_files({find_command={"' .. fd_exe .. '", "--full-path", "src", "--extension", ".cpp"}})<CR>', opts)
    end

    local send_r = ':lua require("harpoon.term").sendCommand(2, "\\r")<CR>'
    -- vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>rn', '<cmd>TestNearest<CR>' .. send_r, opt_sn)
    -- vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>rl', '<cmd>TestLast<CR>' .. send_r, opt_sn)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>rN', '<cmd>lua require("harpoon.term").sendCommand(2, "cargo test " .. split( vim.fn.expand(\'%\'):match(\'[^\\\\]*.cpp$\'), \'.cpp\')[1] .. "\\r") <CR>', opt_sn)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>M', ':lua vim.fn.expand(\'%\'):match(\'[\\^\\]*.cpp$\')', opt_sn)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>rb', '<cmd>lua require("harpoon.term").sendCommand(2, "cargo test " .. split( vim.fn.expand(\'%\'):match(\'[^\\\\]*.cpp$\'), \'.cpp\')[1] .. "\\r") <CR>', opt_sn)
    -- vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>rs', '<cmd>TestSuite<CR>' .. send_r, opt_sn)
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

        vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(
            vim.lsp.handlers.hover,
            { border = "single" }
        )
    end
end


local lspconfig = require('lspconfig')

local path
if vim.loop.os_uname().sysname == "Linux" then
    path = "/home/viktor/.local/share/nvim/lsp_servers/clangd/clangd/bin/clangd"
else
    path = "C:/Users/Lenovo/AppData/Local/nvim-data/lsp_servers/clangd/clangd/bin/clangd.exe"
end

local root_files = {
  'CMakeLists.txt'
}

-- local capabilities = vim.lsp.protocol.make_client_capabilities()
-- capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)
-- capabilities.textDocument.completion.completionItem.snippetSupport = false


-- lspconfig.clangd.setup({
--     -- path = "/home/viktor/.local/share/nvim/lsp_servers/clangd/clangd/bin/clangd",
--     -- capabilities = capabilities,
--
-- })

require("clangd_extensions").setup {
    server = {

        on_attach = my_on_attach,
        root_dir = lspconfig.util.root_pattern(unpack(root_files)),
        -- options to pass to nvim-lspconfig
        -- i.e. the arguments to require("lspconfig").clangd.setup({})
    },

    handlers = {
        ["textDocument/hover"] = vim.lsp.with(hover),
    },
    extensions = {
        -- defaults:
        -- Automatically set inlay hints (type hints)
        autoSetHints = true,
        -- These apply to the default ClangdSetInlayHints command
        inlay_hints = {
            -- Only show inlay hints for the current line
            only_current_line = false,
            -- Event which triggers a refersh of the inlay hints.
            -- You can make this "CursorMoved" or "CursorMoved,CursorMovedI" but
            -- not that this may cause  higher CPU usage.
            -- This option is only respected when only_current_line and
            -- autoSetHints both are true.
            only_current_line_autocmd = "CursorHold",
            -- whether to show parameter hints with the inlay hints or not
            show_parameter_hints = true,
            -- prefix for parameter hints
            parameter_hints_prefix = "<- ",
            -- prefix for all the other hints (type, chaining)
            other_hints_prefix = "=> ",
            -- whether to align to the length of the longest line in the file
            max_len_align = false,
            -- padding from the left if max_len_align is true
            max_len_align_padding = 1,
            -- whether to align to the extreme right or not
            right_align = false,
            -- padding from the right if right_align is true
            right_align_padding = 7,
            -- The color of the hints
            highlight = "Comment",
            -- The highlight group priority for extmark
            priority = 100,
        },
        ast = {
            -- These are unicode, should be available in any font
            -- role_icons = {
            --      type = "🄣",
            --      declaration = "🄓",
            --      expression = "🄔",
            --      statement = ";",
            --      specifier = "🄢",
            --      ["template argument"] = "🆃",
            -- },
            -- kind_icons = {
            --     Compound = "🄲",
            --     Recovery = "🅁",
            --     TranslationUnit = "🅄",
            --     PackExpansion = "🄿",
            --     TemplateTypeParm = "🅃",
            --     TemplateTemplateParm = "🅃",
            --     TemplateParamObject = "🅃",
            -- },
            -- [[ These require codicons (https://github.com/microsoft/vscode-codicons)

            role_icons = {
                type = "",
                declaration = "",
                expression = "",
                specifier = "",
                statement = "",
                ["template argument"] = "",
            },

            kind_icons = {
                Compound = "",
                Recovery = "",
                TranslationUnit = "",
                PackExpansion = "",
                TemplateTypeParm = "",
                TemplateTemplateParm = "",
                TemplateParamObject = "",
            },

            highlights = {
                detail = "Comment",
            },
        },
        memory_usage = {
            border = "none",
        },
        symbol_info = {
            border = "none",
        },
    },
}

