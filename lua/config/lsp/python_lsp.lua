--require("nvim-test").setup{}
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


-- local function unmap(mode, bind)
	-- vim.api.nvim_del_keymap(mode, bind)
-- end


local opts = { noremap=true, silent=false }
local on_attach = function(client, bufnr)

    -- local fd_exe = ""
    require'lsp_signature'.on_attach(lsp_signature_configs, bufnr) -- no need to specify bufnr if you don't use toggle_key
    -- require("aerial").on_attach(client, bufnr)
	vim.o.wrap=false

	-- vim.cmd('TSBufEnable indent')
	vim.opt.colorcolumn = '60'
	-- unmap('n', ']]')
	-- unmap('n', '[[')

	-- vim.g.CondaEnv = os.getenv("CONDA_DEFAULT_ENV")
	-- vim.g.python3_host_prog = 'C:/Users/Lenovo/miniconda3/envs/' .. vim.g.CondaEnv .. '/python'
    require("aerial").on_attach(client, bufnr)
    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>[', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>]', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gef', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'geq', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)
    vim.api.nvim_set_keymap('n', 'gd',       '<cmd>lua vim.lsp.buf.definition()<CR>zt', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gk',       '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gI',       '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gr',       '<cmd>lua vim.lsp.buf.references()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gs',       '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
	vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd',       ':lua require(\'telescope.builtin\').lsp_definitions()<CR>', opts)
	vim.api.nvim_buf_set_keymap(bufnr, 'n', '<C-g>',       ':lua require(\'telescope.builtin\').lsp_definitions()<CR>', opts)
	vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gt',       ':lua require(\'telescope.builtin\').lsp_type_definitions()<CR>', opts)
	vim.api.nvim_buf_set_keymap(bufnr, 'n', '<C-t>',       ':lua require(\'telescope.builtin\').lsp_type_definitions()<CR>', opts)
	vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gc',       ':lua require(\'telescope.builtin\').lsp_workspace_symbols({query="def"})<CR>', opts)
	vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gC',       ':lua require(\'telescope.builtin\').lsp_document_symbols({query="def"})<CR>', opts)
	vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gf',       ':lua require(\'pytrize.api\').jump_fixture()<CR>', opts)


    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>lh',       '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>lI',       '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>lr',       '<cmd>lua vim.lsp.buf.references()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>ls',       '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
	vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>ld',       ':lua require(\'telescope.builtin\').lsp_definitions()<CR>', opts)
	vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>lt',       ':lua require(\'telescope.builtin\').lsp_type_definitions()<CR>', opts)
	vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>lc',       ':lua require(\'telescope.builtin\').lsp_workspace_symbols({query="def"})<CR>', opts)
	vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>lC',       ':lua require(\'telescope.builtin\').lsp_document_symbols({query="def"})<CR>', opts)
    -- vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gD',       '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
    -- vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
    -- vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gp',       '<cmd>lua require("lvim.lsp.peek").Peek("definition")<CR>', opts)
    -- vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gt',       '<cmd>lua require("lvim.lsp.peek").Peek("typeDefinition")<CR>', opts)
    -- vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gi',       '<cmd>lua require("lvim.lsp.peek").Peek("implementation")<CR>', opts)
	-- vim.api.nvim_buf_set_keymap(bufnr, 'n', '<C-p>',    '<cmd>RustRun<CR>', opts)
    -- vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>p',    '<cmd>RustRun<CR>', opts)
    -- vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>o', '<cmd>AerialToggle<CR>', opts)
	--
	vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>jn',    '/\\v^\\s*def\\s\\zs\\w*|^\\s*class\\s\\zs\\w*\\ze[:(]<CR>', opts)
	vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>js',    '/\\v^\\s*\\zsclass\\ze\\s|^\\s*\\zsdef\\ze\\s|^\\s*\\zsif\\ze\\s|^\\s*\\zsfor\\ze\\s|^\\s*\\zselif\\ze\\s|^\\s*\\zselse\\ze:|^\\s*\\zswhile\\ze\\s<CR>', opts)

	vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>jd',    ':let t=[]<CR>:let t=[] | %s/^\\s*def\\s\\zs\\w*/\\=add(t,submatch(0))[-1]/g ', opts)
	vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>jt',    ':echo t<CR> ', opts)


    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>ra', ':lua require("harpoon.term").sendCommand(1, "pytest --no-header -v -rP \\r") <CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>rt', ':lua require("harpoon.term").sendCommand(1, "pytest --no-header -v -rP " .. vim.fn.expand(\'%\') .. "\\r") <CR>', opts)

    local send_r = ':lua require("harpoon.term").sendCommand(1, "\\r")<CR>'
    vim.api.nvim_buf_set_keymap(bufnr,'n', '<leader>rF', '<cmd>TestFile --no-header -v -rP <CR>' .. send_r, opts)
    vim.api.nvim_buf_set_keymap(bufnr,'n', '<leader>rl', '<cmd>TestLast<CR>' .. send_r, opts)
    vim.api.nvim_buf_set_keymap(bufnr,'n', '<leader>rn', '<cmd>TestNearest --no-header -v -rP <CR>' .. send_r, opts)
    vim.api.nvim_buf_set_keymap(bufnr,'n', '<leader>rN', '<cmd>TestNearest -m plot<CR>' .. send_r, opts)
    vim.api.nvim_buf_set_keymap(bufnr,'n', '<leader>rS', '<cmd>TestSuit<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr,'n', '<leader>rV', '<cmd>TestVisit<CR>', opts)

    if vim.loop.os_uname().sysname=="Linux" then
        local python_exe = '/usr/bin/python3.8'
	    vim.g.python3_host_prog = python_exe
        vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>rp', ':lua require("harpoon.term").sendCommand(1, "'..python_exe..' " .. vim.fn.expand(\'%\') .. "\\r")<CR>', opts)

        local fd_exe = '/usr/bin/fdfind'
        vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>tt', ':lua require(\'telescope.builtin\').find_files({find_command={"' .. fd_exe .. '", "test_",     "--type", "f",  "--extension", "py"                         }})<CR>', opts)
        vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>tn', ':lua require(\'telescope.builtin\').find_files({find_command={"' .. fd_exe .. '",             "--type", "f",  "--extension", "py",    "--exclude", "tests"}})<CR>', opts)

        vim.api.nvim_buf_set_keymap(bufnr,'n', '<leader>rfn', ':e tests/fixtures/', opts)
        vim.api.nvim_buf_set_keymap(bufnr,'n', '<leader>rfc', ':e tests/conftest.py<CR>', opts)
        vim.api.nvim_buf_set_keymap(bufnr,'n', '<leader>rfg', ':Telescope file_browser path=' .. vim.loop.cwd().. "/tests/fixtures<CR>", opts)
        vim.api.nvim_buf_set_keymap(bufnr,'n', '<leader>ru', ':Telescope file_browser path=' .. vim.loop.cwd().. "/tests/fixtures<CR>", opts)
        vim.api.nvim_buf_set_keymap(bufnr,'n', '<leader>rff', ':Telescope lsp_dynamic_workspace_symbols path=' .. vim.loop.cwd().. "/tests/fixtures<CR>", { noremap = true })
    else

        local python_exe = 'C:/Users/Lenovo/miniconda3/envs/LSPenv/python'
	    vim.g.python3_host_prog = python_exe
        vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>rp', ':lua require("harpoon.term").sendCommand(1, "'..python_exe..' " .. vim.fn.expand(\'%\') .. "\\r")<CR>', opts)

        local fd_exe = "C:/Users/Lenovo/scoop/shims/fd.exe"
        vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>tt', ':lua require(\'telescope.builtin\').find_files({find_command={"' .. fd_exe .. '", "test_",     "--type", "f",  "--extension", "py"                         }})<CR>', opts)
        vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>tn', ':lua require(\'telescope.builtin\').find_files({find_command={"' .. fd_exe .. '",             "--type", "f",  "--extension", "py",    "--exclude", "tests"}})<CR>', opts)

        vim.api.nvim_buf_set_keymap(bufnr,'n', '<leader>rfn', ':e tests/fixtures/', opts)
        vim.api.nvim_buf_set_keymap(bufnr,'n', '<leader>rfc', ':e tests/conftest.py<CR>', opts)
        vim.api.nvim_buf_set_keymap(bufnr,'n', '<leader>rfg', ':Telescope file_browser path=' .. vim.loop.cwd().. "\\tests\\fixtures<CR>", opts)
        vim.api.nvim_buf_set_keymap(bufnr,'n', '<leader>ru', ':Telescope file_browser path=' .. vim.loop.cwd().. "\\tests\\fixtures<CR>", opts)
        vim.api.nvim_buf_set_keymap(bufnr,'n', '<leader>rff', ':Telescope lsp_dynamic_workspace_symbols path=' .. vim.loop.cwd().. "\\tests\\fixtures<CR>", { noremap = true })
    end

    require('which-key').register({
        r = {
            name = 'Test',
            F = 'TestFile',
            L = 'TestLast',
            N = 'TestNearest',
            S = 'TestSuit',
            v = 'TestVisit',
            t = 'pytest %',
            a = 'pytest all',
            p = 'python %',
            f = {
                name = 'Fixtures',
                l = 'list fixtures',
                n = 'create new file',
                g = 'goto tests/fixtures/',
                c = 'goto tests/conftest.py',
            },
        },

    }, {
        prefix = '<leader>',
    })
end


-- local capabilities = vim.lsp.protocol.make_client_capabilities()
-- capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

local lspconfig = require('lspconfig')
local util = lspconfig.util

function find_package_pip_ancestor(startpath)
  return util.search_ancestors(startpath, function(path)
    if util.path.is_file(M.path.join(path, 'requirements.yml')) then
      return path
    end
    if util.path.is_file(M.path.join(path, 'Pipfile')) then
      return path
    end
  end)
end


local root_files = {
  'Pipfile',
  'pyproject.toml',
  'setup.py',
  'setup.cfg',
  -- 'requirements.txt',
  'requirements.yml',
  'pyrightconfig.json',
  
}


-- function _G.pipenv_path()
--     local handle = io.popen("C:/Users/Lenovo/BATS/pipenv_check.bat")
--     local result = handle:read("*l")
--     if result==nil or result=="" then
--         return ""
--     end
--     -- vim.cmd("let g:my_pipenv=".."'".. result.."'")
--     handle.close()
--     local pipenv_path = string.sub(result,0, string.len(result)-1)
--     return pipenv_path
-- end
-- function _G.pipenv_stubpath()
--     local pipenv_path = _G.pipenv_path()
--     return pipenv_path..'/Lib/site-packages'
-- end
-- function _G.pipenv_python()
--     local pipenv_path = _G.pipenv_path()
--     return pipenv_path..'/Scripts/python.exe'
-- end

function _G.conda_stub()
    local val = os.getenv("CONDA_DEFAULT_ENV")
    if val==nil or val=='' then
        return nil
    end
    return 'C:/Users/Lenovo/miniconda3/envs/' .. val .. '/Lib/site-packages'
end
function _G.conda_python()
    local val = os.getenv("CONDA_DEFAULT_ENV")
    if val==nil or val=='' then
        return nil
    end
    return 'C:/Users/Lenovo/miniconda3/envs/'.. val .. '/python.exe'
end

lspconfig.pyright.setup({
	-- cmd = { 'pyright-langserver', '--stdio' },
	on_attach = on_attach,
    -- filetypes = { 'python' },

    -- root_dir = lspconfig.util.find_git_ancestor or lspconfig.util.find_package_pipfile_ancestor or lspconfig.util.find_package_pyproject_ancestor,
    -- root_dir = find_package_pipfile_ancestor,
	root_dir = util.root_pattern(unpack(root_files)),
    filetypes = {'python'},
    settings = {
        pyright = {
            --disableLanguageServices = false,
            --disableOrganizeImports = truee,
            disablerganizeImports = false,
        },
        python = {
            analysis = {
        --         stubPath = _G.pipenv_stubpath(),
        --
                stubPath = _G.conda_stub(),
            },
            -- venvPath = "C:/Users/Lenovo/.virtualenvs/",
        --     pythonPath = _G.pipenv_python(),
            -- pythonPath = _G.conda_python(),
        },
        -- python = {
            -- analysis = {
        --         autoImportCompletions = true,
        --         autoSearchPaths = true,
        --         diagnosticMode = 'workspace', -- ["openfFilesOnly", "workspace"]
        --         -- diagnosticSeverityOverrides = ''
        --         -- extraPaths =
        --         logLevel = 'Warning',
        --         --stubPath = 'C:/Users/Lenovo/miniconda3/envs/NoDk/Lib/site-packages',
        --         stubPath = 'C:/Users/Lenovo/miniconda3/envs/' .. os.getenv("CONDA_DEFAULT_ENV") .. '/Lib/site-packages',
        --         typeCheckingMode = 'basic',
        --         -- typeshedPaths
        --         -- useLibraryCodeForTypes = false
        --     },
        --     pythonPath = 'C:/Users/Lenovo/miniconda3/envs/'.. os.getenv("CONDA_DEFAULT_ENV") .. '/python.exe',
        --     --pythonPath = 'C:/Users/Lenovo/miniconda3/envs/NoDk/python.exe',
        --     venvPath = 'C:/Users/Lenovo/miniconda3/envs'
        -- },
    },
})



--unmap('n', '<leader>f')



-- unmap('x', ']]')
-- unmap('x', '[[')
-- unmap('v', ']]')
-- unmap('v', '[[')


