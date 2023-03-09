local M = {}

-- {{{ FUNCTIONS

-- {{{ opts

local opt_e = { silent = false } --empty opt for maps with no extra options
local opt_n = { silent = false, noremap = true } --empty opt for maps with no extra options
local opt_s = { silent = true } --empty opt for maps with no extra options
local opt_sn = { silent = true, noremap = true }
vim.g.mapleader = ' ' -- Map leader key to space
vim.g.maplocalleader = ','

-- }}}
--
-- -- {{{ function map(mode, bind, exec, opts)

local function map(mode, bind, exec, opts)
    --[[
        inputs:
            - mode: Type, whether in all, normal, insert etc. (reference: https://github.com/nanotee/nvim-lua-guide#defining-mappings) 
            - bind: Keybind. Just like normal vim way
            - exec: command to execute
            - options: ...
    --]]
    local options = { noremap = true, silent = true }
    if opts then
        options = vim.tbl_extend('force', options, opts)
    end

    -- print()
    -- print(mode)
    -- print(bind)
    -- print(exec)
    -- print(opts)
    vim.api.nvim_set_keymap(mode, bind, exec, opts)
end

local function process_opts(opt)
    if opt == nil then
        return opt_sn
    end
    return opt
end

local function process_func(func)
    if type(func) == "table" then
        return table.concat(func, '<CR><cmd>')
    end
    return func
end

local function nmap(bind, func, opt)
    -- print('nmap')
    func = process_func(func)
    opt = process_opts(opt)
    local exec_func = '<cmd>' .. func .. '<CR>'
    -- local echo_func = ':echo "'..func..'"<CR>'
    -- print(echo_func)
    map('n', '<leader>' .. bind, exec_func, opt)
    -- print('-------------------------------')
end

local function snmap(bind, func, opt, mode)
    if mode == nil then
        mode = 'n'
    end
    -- print('snmap')
    local func_str = process_func(func)
    local exec_func = '<cmd>' .. func_str .. '<CR>'
    local echo_func = '<cmd>echo \'' .. func_str .. '\'<CR>'
    opt = process_opts(opt)
    --vim.pretty_print(func)
    map(mode, '<leader>' .. bind, exec_func, opt)
    -- print('--------------------------')
end

local function amap(bind, func, opt)
    snmap(bind, func, opt, '')
end

-- -- }}}
-- -- {{{ function unmap(mode, bind)

local function unmap(mode, bind)
    --[[ Umapping
    --unmap('n', '<leader>f')
    --]]
    vim.api.nvim_del_keymap(mode, bind)
end

-- -- }}}
-- -- {{{ function mysplit(inputstr, sep)

local function mysplit(inputstr, sep)
    if sep == nil then
        sep = "%s"
    end
    local t = {}
    for str in string.gmatch(inputstr, "([^" .. sep .. "]+)") do
        table.insert(t, str)
    end
    return t
end

-- -- }}}
-- -- {{{ function mm(file)

local function mm(file)
    local t = vim.fn.expand(file)
    return t
end

-- -- }}}
-- -- {{{ function mm(file)

local function fterm_run(command)
    return ":lua require('FTerm').run(" .. command .. ")<CR>"
end

-- -- }}}

-- }}}


-- {{{ <Leader>
-- {{{ [A] - ...
-- }}}
-- {{{ [B] - Buffers

nmap('bf', 'BufferFirst')
nmap('bf', 'BufferLast')
nmap('bk', 'BufferNext')
nmap('bj', 'BufferPrevious')
nmap('bmk', 'BufferMoveNext')
nmap('bmj', 'BufferMovePrevious')
nmap('bp', 'BufferPick')
nmap('bsk', 'BufferScrollRight')
nmap('bsj', 'BufferScrollLeft')
nmap('bd', 'bd')

-- }}}
-- {{{ [c] - CommentToggle


function _G._open_qfl()
    -- set new keymaps
    vim.api.nvim_set_keymap('n', 'N', ':cp<CR>', {})
    vim.api.nvim_set_keymap('n', 'n', ':cn<CR>', {})

    -- set deactivation keymaps to "/"
    vim.api.nvim_set_keymap('n', '/',
        ":lua vim.api.nvim_del_keymap('n', 'N')<CR>" ..
        ":lua vim.api.nvim_del_keymap('n', 'n')<CR>" ..
        ":lua vim.api.nvim_del_keymap('n', '/')<CR>/", {})

    vim.api.nvim_set_keymap('n', '<leader>cq', ':ccl<CR>', opt_sn)
end

function _G._open_ll()
    -- set new keymaps
    vim.cmd("winc k")
    vim.api.nvim_set_keymap('n', 'N', ':lprev<CR>', {})
    vim.api.nvim_set_keymap('n', 'n', ':lnext<CR>', {})

    -- set deactivation keymaps to "/"
    vim.api.nvim_set_keymap('n', '/',
        ":lua vim.api.nvim_del_keymap('n', 'N')<CR>" ..
        ":lua vim.api.nvim_del_keymap('n', 'n')<CR>" ..
        ":lua vim.api.nvim_del_keymap('n', '/')<CR>/", {})

    vim.api.nvim_set_keymap('n', '<leader>cq', ':lclose<CR>', opt_sn)
end

_G.set_jump_mappings = function(cmd_prev, cmd_next)
    vim.api.nvim_set_keymap('n', 'N', ':' .. cmd_prev .. '<CR>', {})
    vim.api.nvim_set_keymap('n', 'n', ':' .. cmd_next .. '<CR>', {})

    -- set deactivation keymaps to "/"
    vim.api.nvim_set_keymap('n', '/',
        ":lua vim.api.nvim_del_keymap('n', 'N')<CR>" ..
        ":lua vim.api.nvim_del_keymap('n', 'n')<CR>" ..
        ":lua vim.api.nvim_del_keymap('n', '/')<CR>/", {})
end
_G.set_trouble_mappigs = function()
    local opts = '{ skip_groups = true, jump = true }'
    set_jump_mappings("lua require('trouble').previous(" .. opts .. ")", "lua require('trouble').next(" .. opts .. ")")
end

-- snmap('cse', 'lua _G.set_jump_mappings(\'cp\', \'cn\')')
snmap('cj', 'lua _G.set_jump_mappings(\'cp\', \'cn\')')
snmap('cx', 'lua _G.set_trouble_mappigs()')
-- snmap('csl', 'lua _G.set_jump_mappings(\'lprev\', \'lnext\')')
vim.api.nvim_set_keymap('n', '<leader>cu', '<cmd>Task start cmake build_all<cr>', opt_sn)

-- vim.api.nvim_set_keymap('n', '<leader>ce', '<cmd>cex! execute(\'!cd build && ctest --output-on-failure\')<cr>', opt_sn)

snmap('ce',
    { 'silent! execute(\'!cd build && make\')', 'cex! execute(\'!cd build && ctest --output-on-failure\')',
        'echo "Done running ctest"' })

snmap('li', 'Trouble lsp_implementations')
snmap('lr', 'Trouble lsp_references')
snmap('lR', 'lua vim.lsp.buf.rename()')
snmap('ld', 'Trouble lsp_definitions')
snmap('lt', 'Trouble lsp_type_definitions')

-- snmap('pf', 'TSTextobjectPeekDefinitionCode @function.outer')
-- snmap('pc', 'TSTextobjectPeekDefinitionCode @class.outer')

vim.api.nvim_set_keymap('n', 'gk', 'K', {})


-- snmap('csl', 'lua _G.activate_ql_mappings("lprev", "lnext")')

-- vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>k',    aa_a()   , opts_silent)
-- snmap('cn', 'lua _G._open_qfl()')
-- snmap('cp', 'cp')
-- snmap('cn', 'cn')
snmap('la', 'CodeActionMenu')
map('n', 'g,', '<cmd> cp <cr>', opt_sn)
map('n', 'g.', '<cmd> cn <cr>', opt_sn)
map('n', 'cp', '<cmd> cp <cr>', opt_sn)
map('n', 'cn', '<cmd> cn <cr>', opt_sn)
map('n', 'c,', '<cmd> cp <cr>', opt_sn)
map('n', 'c.', '<cmd> cn <cr>', opt_sn)

snmap('co', { 'cope', 'lua _G._open_qfl()' })

_G.get_qflist_dir = function()
    local pwd = vim.fn.getcwd()
    pwd = pwd:gsub("/", "__")
    local qflist_dir = vim.fn.expand("~/.config/nvim/.qflists/") .. pwd

    local path = require('plenary.path'):new(qflist_dir)
    return path
end
_G.create_qflist_filename = function(dir)
    vim.cmd(':silent !mkdir -p '..dir)
    local files = require('plenary.scandir').scan_dir(dir, {})
    local n_files = #files
    local filename = dir .. "/" .. "list" .. n_files+1 ..".qf"
    return filename
end

_G.open_qflist_from_filename = function(quickfix_list)
    quickfix_list = quickfix_list:gsub("|1|", "")
    quickfix_list = quickfix_list:gsub("|| ", "")
    local path = require('plenary.path'):new(quickfix_list)
    print("letsgo")
    if path:exists() then
        print("file exists")
        vim.cmd('cfile '..quickfix_list..'')
    end
    vim.keymap.del('n', "<f3>")
end
_G.read_qf_filename = function(filename)
    local file_reader = io.open(filename)
    if file_reader == nil then
        print("file is empty")
        return
    end
    vim.cmd("call setqflist([], 'f', {'title':'" .. filename .. "', 'id':'qflist_'.. '"..filename.."'})")
    for line in file_reader:lines() do
        line = line:sub(0, line:find('|')-1)
        vim.cmd("call setqflist([{'filename':'"..line.."'}], 'a')")
    end
end

_G.load_qflist = function()
    local pwd = vim.fn.getcwd()
    local dir = _G.get_qflist_dir()
    local files = require('plenary.scandir').scan_dir(dir.filename, {})
    local n_files = #files
    if n_files == 0 then
        print("no quickfix list has been saved corresponding to the directory\n  "..pwd)
    elseif n_files == 1 then
        _G.read_qf_filename(files[1])
    else
        vim.cmd("call setqflist([], 'f', {'title':'available qflists', 'id':'available_qflists'})")


        for _,file in pairs(files) do
            vim.cmd("call setqflist([{'filename':'"..file.."', 'lnum':1}], 'a')")
        end
        vim.keymap.set('n', "<f3>", function() _G.open_qflist_from_filename(vim.fn.expand("<cWORD>")) end, { noremap = true, silent = false })
        -- require('telescope.builtin').find_files({ cwd = dir.filename })
        -- require('telescope.builtin').find_files({ cwd = dir.filename })
        -- TSmap('te', 'find_files', '')
    end
end

-- _G.get_ = function(pwd)
--     pwd = pwd:gsub("/", "__")
--     local qflist_dir = vim.fn.expand("~/.config/nvim/.qflists/") .. pwd
--     vim.cmd(':silent !mkdir -p '..qflist_dir)
--
--     local filename = _G.create_qflist_filename(pwd)
--     -- vim.cmd(':w "'..filename..'"')
--     vim.api.nvim_command('write "'..filename..'"')
-- end

-- _G.save_qflist = 
-- snmap('cl', { 'lua _G.save_qflist(vim.fn.expand("%:p:h"))'})
-- snmap('cl', { "lua vim.cmd(\"echo '\".._G.save_qflist(vim.fn.getcwd()) )..\"'\""})

vim.keymap.set('n', "<leader>cs",  function()
    if "qf" ~= vim.bo.filetype then
        print("not a qflist file")
        return
    end
    local pwd = vim.fn.getcwd()
    pwd = pwd:gsub("/", "__")
    local qflist_dir = vim.fn.expand("~/.config/nvim/.qflists/") .. pwd
    local filename = _G.create_qflist_filename(qflist_dir)
    vim.cmd('w '..filename)
    print("File saved: "..filename)
end, { noremap = true, silent = false })
-- vim.keymap.set('n', "<leader>cs",  "<cmd>lua vim.cmd('echo \"'.._G.save_qflist()..'\"')<cr>", { noremap = true, silent = false })
-- vim.keymap.set('n', "<leader>cs",  "<cmd>lua vim.cmd('echo \"'.._G.save_qflist()..'\"')<cr><cmd>echo 'quickfix-list saved'<cr>", { noremap = true, silent = false })
-- vim.keymap.set('n', "<leader>cl",  "<cmd>lua vim.cmd('cfile '.._G.save_qflist(vim.fn.getcwd()))<cr>", { noremap = true, silent = false })
vim.keymap.set('n', "<leader>cl",  "<cmd>lua _G.load_qflist()<cr>", { noremap = true, silent = false })
-- vim.keymap.set('n', "<leader>cL",  "<cmd>lua _G.load_qflist()<cr>", { noremap = true, silent = false })
-- _G.open_qflist_from_filename
-- snmap('cl', { 'cope', 'lua _G._open_qfl()', 'winc L' })

snmap('cb', { 'lua require(\'diaglist\').open_buffer_diagnostics()', 'lua _G._open_ll()' })
-- snmap('ca', {'lua require(\'diaglist\').open_all_diagnostics()', 'lua _G._open_ll()'})
snmap('cd', { 'lua vim.diagnostic.setqflist()', 'lua _G._open_qfl()' })
snmap('cq', { 'ccl', 'TroubleClose', 'echo "Close quicfix window"' })

vim.cmd("map <leader>ag :<C-U>lua require('aerial').select({jump=true, index=vim.v.count})<CR>")


snmap('ros', 'lua _G.split_term()')
snmap('r<space>', 'lua _G.term_float( vim.fn.bufnr())')
-- 'echo "git reset file:\\n - " .. expand(\'%\')'})
-- vim.api.nvim_set_keymap('n', '<leader>cd',    ':cope<CR>:lua vim.diagnostic.setqflist()<cr>:lua _G._assign_n__CMD_cn_and_cp_CR__()<CR>'   , opt_sn)

-- }}}
-- {{{ [D] - DiffView

snmap('do0', 'DiffviewOpen HEAD') -- Previous Commit
snmap('do1', 'DiffviewOpen HEAD~1') -- Previous Commit
snmap('do2', 'DiffviewOpen HEAD~2') -- Previous Commit
snmap('do3', 'DiffviewOpen HEAD~3') -- Previous Commit
snmap('do4', 'DiffviewOpen HEAD~4') -- Previous Commit

snmap('da', 'DiffviewOpen HEAD') -- Previous Commit
snmap('db', 'DiffviewOpen HEAD~1') -- Previous Commit
snmap('dc', 'DiffviewOpen origin/main') -- Previous Push
-- snmap('dd', 'DiffviewOpen origin/main...HEAD') -- Previous Push
snmap('dq', 'DiffviewClose')
snmap('dt', 'DiffviewToggleFiles')
snmap('df', 'DiffviewFileHistory')

-- }}}
-- {{{ [E] - Extra

snmap('ea', { 'AerialToggle', 'winc l' })
snmap('ee', { 'winc v', 'winc h', '60 winc |', 'enew', 'set nonu', 'set nornu' }) -- toggle relative line numbers
snmap('ej', 'lua _G.create_header()') -- toggle relative line numbers
amap('ec', 'cd %:p:h') -- toggle comment on current line or selection
snmap('e-', 'cd ..')
-- snmap('es', {'so %', "echo 'source -> '..expand('%')"})
snmap('es', 'so %')
snmap('eSb', { 'profile start profile.log', 'profile file *', 'profile func *', 'echo "profiling has started"' })
snmap('eSe', { 'profile pause', 'noautocmd qall!' })
snmap('eh', { 'set hlsearch!', 'match none' }) -- toggle comment on current line or selection

snmap('e.r', 'set rnu!') -- toggle relative line numbers
snmap('e.n', 'set number!') -- toggle relative line numbers
snmap('e.b', { 'syncbind', 'set scrollbind', 'set cursorbind', 'set scrollopt=ver' })
snmap('e.s0', 'set laststatus=0')
snmap('e.s1', 'set laststatus=1')
snmap('e.s2', 'set laststatus=2')
snmap('e.s3', 'set laststatus=3')

map('n', '<leader>ef', ':setlocal foldenable!<CR>:setlocal foldmethod=indent<CR>', opt_sn)
map('n', '<leader>el', 'O//-----------------------------------------------------------------------------', opt_sn)
map('n', '<leader>etv', ':vs | terminal<CR>i', opt_sn)
map('n', '<leader>ets', ':sp | terminal<CR>i', opt_sn)
map('n', '<leader>ep', '"+p', opt_sn) -- toggle relative line numbers
map('n', '<leader>eP', '"+P', opt_sn) -- toggle relative line numbers
map('v', '<leader>y', '"+y', opt_sn)


-- local function m
snmap('edS', 'lua _G.__reload()')


-- }}}
-- {{{ [F] - ...
-- }}}
-- {{{ [G] - GitSigns - Gdiff - git_status
M.gitsigns_mappings = {
    noremap = true,
    -- ['n ]c'] = { expr = true, "&diff ? ']c' : '<cmd>lua require\"gitsigns.actions\".next_hunk()<CR>'" },
    -- ['n [c'] = { expr = true, "&diff ? '[c' : '<cmd>lua require\"gitsigns.actions\".prev_hunk()<CR>'" },

    -- ['n <leader>Gs'] = '<cmd>lua require"gitsigns".stage_hunk()<CR>',
    -- ['v <leader>Gs'] = '<cmd>lua require"gitsigns".stage_hunk({vim.fn.line("."), vim.fn.line("v")})<CR>',
    -- ['n <leader>Gu'] = '<cmd>lua require"gitsigns".undo_stage_hunk()<CR>',
    -- ['n <leader>Gr'] = '<cmd>lua require"gitsigns".reset_hunk()<CR>',
    -- ['v <leader>Gr'] = '<cmd>lua require"gitsigns".reset_hunk({vim.fn.line("."), vim.fn.line("v")})<CR>',
    -- ['n <leader>GR'] = '<cmd>lua require"gitsigns".reset_buffer()<CR>',
    -- ['n <leader>Gp'] = '<cmd>lua require"gitsigns".preview_hunk()<CR>',
    -- ['n <leader>Gb'] = '<cmd>lua require"gitsigns".blame_line(true)<CR>',
    -- ['n <leader>GS'] = '<cmd>lua require"gitsigns".stage_buffer()<CR>',
    -- ['n <leader>GU'] = '<cmd>lua require"gitsigns".reset_buffer_index()<CR>',

    -- Text objects
    -- ['o ih'] = ':<C-U>lua require"gitsigns.actions".select_hunk()<CR>',
    -- ['x ih'] = ':<C-U>lua require"gitsigns.actions".select_hunk()<CR>',

    -- Git Diff View

    -- Git Telescope
    ['n <leader>gts'] = '<cmd>Telescope git_status<CR>',

    -- Git Operations
    -- ['n <leader>gs'] = '<cmd>Git status<CR>',
    -- ['n <leader>ga.'] = '<cmd>Git add .<CR>',
    -- ['n <leader>gaf'] = ':Git add vim.fn.expand(\'%:p:h\')<CR>',
    -- ['n <leader>gc'] = '<cmd>Git commit<CR>',
    -- ['n <leader>gp'] = '<cmd>Git push<CR>',
    -- ['n <leader>gP'] = '<cmd>Git pull<CR>',
}
-- Git Operations
nmap('gs', 'Git status')
-- git add [ < . > , < % > ]
nmap('ga.', 'Git add . ')

if vim.loop.os_uname().sysname == "Linux" then
    snmap('gaf', 'Git add %')
else
    nmap('gaf', { 'Git add % ', 'echo "git add file:\\n - " .. expand(\'%\')' })
end
-- git reset [ < . > , < % > ]
nmap('gr.', 'Git reset . ')
nmap('grf', { 'Git reset % ', 'echo "git reset file:\\n - " .. expand(\'%\')' })
-- git commit
nmap('gc', 'Git commit ')
-- git push
nmap('gp', 'Git push ')
-- git pull
nmap('gP', 'Git pull ')

-- map('n', '<leader>gs', '<cmd>Telescope git_status<CR>', opt_sn)
-- }}}
-- {{{ [H] - Harpoon

local send_r = ':lua require("harpoon.term").sendCommand(1, "\\r")<CR>'
-- map('n', '<leader>rl', '<cmd>TestLast<CR>' .. send_r, opt_sn)
-- map('n', '<leader>rs', '<cmd>TestSuite<CR>' .. send_r, opt_sn)

local function require_map(bind, path, func, args)
    if args == nil then
        args = ""
    end
    map('n', '<leader>' .. bind, ':lua require("' .. path .. '").' .. func .. '(' .. args .. ')<CR>', opt_sn)
end

require_map('h\'', 'harpoon.mark', 'add_file')
require_map('h\'', 'harpoon.mark', 'add_file')
require_map('ht', 'harpoon.ui', 'toggle_quick_menu')
require_map('hn', 'harpoon.ui', 'nav_next')
require_map('hp', 'harpoon.ui', 'nav_prev')

-- }}}
-- {{{ [I] - ???
map('n', '<leader>i', 'V]M', opt_sn)
-- }}}
-- {{{ [J] - ...
-- }}}
-- {{{ [K] - ...
-- }}}
-- {{{ [L] - Lsp

snmap('Li', 'LspInfo')
snmap('LI', 'LspInstallInfo')
snmap('Lr', 'LspRestart')
snmap('Ls', 'LspStart')
snmap('LX', 'LspStop')
snmap('Ll', 'LspLog')

snmap('lf', 'lua vim.lsp.buf.format()')
-- snmap('la', 'lua vim.lsp.buf.code_action()')
-- snmap('lr', 'lua vim.lsp.buf.rename()')

-- }}}
-- {{{ [M] - ...
-- }}}
-- {{{ [N] - ...
-- }}}
-- {{{ [O] - ...
-- }}}
-- {{{ [p]
-- }}}

-- {{{ [P] - Packer ...
snmap('Pr', 'PackerClean')
snmap('Pc', 'PackerCompile')
snmap('Pi', 'PackerInstall')
snmap('Pl', 'PackerLoad')
snmap('Ps', 'PackerStatus')
snmap('Pu', 'PackerSync')
snmap('PSi', 'PackerSnapshot')
snmap('PSd', 'PackerSnapshotDelete')
snmap('PSr', 'PackerSnapshotRollback')
snmap('Pa', 'packloadall')
snmap('P\'', 'e C:/Users/Lenovo/AppData/Local/nvim/lua/plug.lua')
-- }}}
-- {{{ [q] - Quit [:q]
snmap('q', 'q')
-- }}}
-- {{{ [R] - Testing
-- map('n', '<leader>rp', fterm_run('"python " .. vim.fn.expand(\'%\') .. "\\r"'), opt_sn)
-- map('n', '<leader>rt', fterm_run('"pytest -v -rP " .. vim.fn.expand(\'%\') .. "\\r"'), opt_sn)
-- map('n', '<leader>rA', fterm_run('"pytest -v -rP \\r"'), opt_sn)

-- map('n', '<leader>rfl', fterm_run('"pytest --fixtures \\r"'), opt_sn)

-- }}}
-- {{{ [s] - Alternate Buffers
snmap('s', 'w')
-- }}}
-- {{{ [T] - Telescope
local function TSmap(bind, func, args)
    require_map(bind, 'telescope.builtin', func, args)
end

nmap('tf', 'Telescope find_files')
nmap('tc', 'Telescope buffers')

-- find-files
nmap('tu', 'Telescope find_files')
TSmap('te', 'find_files', '{ cwd = vim.fn.expand(\'%:p:h\') }')
nmap('to', 'Telescope buffers')

-- grep
nmap('tp', 'Telescope live_grep')
TSmap('t.', 'live_grep', '{cwd = vim.fn.expand(\'%:p:h\')}')
TSmap('t,', 'live_grep', '{grep_open_files=true}')

-- file-browser
nmap('tb', 'Telescope file_browser')
nmap(',', 'Telescope file_browser')
nmap('tk', 'Telescope file_browser')
nmap('tm', 'Telescope file_browser path=%:p:h')
nmap('tj', 'Telescope file_browser path=%:p:h')

nmap('tgs', 'Telescope git_status')
nmap('tgf', 'Telescope git_files')
nmap('tq', 'Telescope quickfixhistory')

-- TSmap('tg', 'find_files', '{ cwd = vim.fn.expand(\'%:p:h\') }')



snmap('wt', { 'winc s', 'lua require(\'telescope.builtin\').lsp_type_definitions()' })

nmap('tR', 'Telescope resume')
nmap('tlr', 'Telescope lsp_references')
nmap('tr', 'Telescope lsp_references')
nmap('tx', 'Telescope keymaps')
nmap('th', 'Telescope help_tags')

TSmap('tsa', 'lsp_dynamic_workspace_symbols', '{ ignore_symbols = {"variable", "constant"} }')
TSmap('tsc', 'lsp_dynamic_workspace_symbols', '{ symbols = {"class"} }')
TSmap('tsf', 'lsp_dynamic_workspace_symbols', '{ symbols = {"function"} }')
TSmap('t-', 'lsp_document_symbols', '{}')
TSmap('td', 'find_files', '{ find_command={ "C:/Users/Lenovo/scoop/shims/fd.exe", "--type", "d" } }')

-- map('n', '<leader>tj', ':lua require(\'telescope.builtin\').lsp_dynamic_workspace_symbols({ignore_symbols = {"variable", "constant"}, cwd = vim.fn.expand(\'%:p:h\')})<CR>', { noremap = true })
-- map('n', '<leader>tq', ':lua require(\'telescope.builtin\').lsp_dynamic_workspace_symbols({ignore_symbols = {"variable", "constant"}, grep_open_files = true})<CR>', { noremap = true })


-- }}}
-- {{{ [U] - ...
-- }}}
-- {{{ [V] - ...
snmap('vj', 'TSTextobjectGotoNextStart @block.outer')
snmap('vk', 'TSTextobjectGotoNextStart @block.inner')
snmap('ve', 'TSTextobjectGotoPreviousEnd @block.outer')
snmap('vu', 'TSTextobjectGotoPreviousEnd @block.inner')

-- -- function
-- map('n', '[m', ':TSTextobjectGotoPreviousStart @function.outer<CR>', opt_sn)
-- map('n', ']m', ':TSTextobjectGotoNextStart @function.outer<CR>', opt_sn)
--
-- -- class
-- map('n', '[c', ':TSTextobjectGotoPreviousStart @class.inner<CR>', opt_sn)
-- map('n', ']c', ':TSTextobjectGotoNextStart @class.inner<CR>', opt_sn)
--
-- -- loop
-- map('n', '[l', ':TSTextobjectGotoPreviousStart @loop.outer<CR>', opt_sn)
-- map('n', ']l', ':TSTextobjectGotoNextStart @loop.outer<CR>', opt_sn)
--
-- -- [if] conditional
-- map('n', '[i', ':TSTextobjectGotoPreviousStart @loop.outer<CR>', opt_sn)
-- map('n', ']i', ':TSTextobjectGotoNextStart @loop.outer<CR>', opt_sn)
--
-- -- [if] conditional
-- map('n', '[ti', ':TSTextobjectGotoPreviousStart @call.outer<CR>', opt_sn)
-- map('n', ']ti', ':TSTextobjectGotoNextStart @call.outer<CR>', opt_sn)
--
--
-- -- statement
-- map('n', '[s', ':TSTextobjectGotoPreviousStart @statement.outer<CR>', opt_sn)
-- map('n', ']s', ':TSTextobjectGotoNextStart @statement.outer<CR>', opt_sn)
-- -- parameter
-- map('n', '[p', ':TSTextobjectGotoPreviousStart @parameter.inner<CR>', opt_sn)
-- map('n', ']p', ':TSTextobjectGotoNextStart @parameter.inner<CR>', opt_sn)

-- }}}
-- {{{ [W] -
snmap('ws', 'winc s')
snmap('w+', '2winc +')
snmap('w-', '2winc -')
snmap('wv', 'winc v')
snmap('wq', 'winc q')
snmap('wc', 'winc c')
snmap('wo', 'winc o')
snmap('wK', 'winc K')
snmap('wJ', 'winc J')
snmap('wL', 'winc L')
snmap('wH', 'winc H')
snmap('wT', 'winc T')
snmap('w=', 'winc =')

-- map('n', '<leader>wt', ':lua require(\'telescope.builtin\').lsp_type_definition()<CR>:winc s<CR>:b#<CR>:winc K<CR>', opt_sn)
-- }}}
-- {{{ [X] - ...
-- }}}
-- {{{ [Y] - Copy to Clipboard
-- }}}
-- {{{ [Z] - ...
-- local keymap_amend = require('keymap-amend')
-- local pretty_pre = require('pretty-fold.preview')
-- pretty_pre.config = {
--    default_keybindings = true,
--    border = {'', '', '', '', '', '', '', ''},
-- }
-- map('n', '<leader>zc', ':setlocal foldmethod=indent<CR>:setlocal foldnestmax=1<CR>', opt_sn)
-- map('n', '<leader>zR', 'zR:setlocal foldmethod=manual<CR>', opt_sn)
-- map('n', '<leader>zp', ':lua require("pretty-fold.preview").mapping.show_close_preview_open_fold()<CR>', opt_sn)
-- keymap_amend('n', 'zh', pretty_pre.mapping.show_close_preview_open_fold)
-- map('n', 'zc', ':lua require("pretty-fold.preview").mapping.show_close_preview_open_fold()<CR>', opt_sn)
-- }}}
-- {{{ [special chars]
snmap('~', 'Dashboard')
snmap('}', 'bn')
snmap('{', 'bp')
snmap('!', 's/<c-r>///g<left><left>')
snmap('|', "let @/=\"<C-R>=expand(\"<CWORD>\")<CR>\"<CR>:set hls")
map('n', '<leader>|', '<cmd>lua vim.cmd(\'let @/="\'..vim.fn.expand("<cword>")..\'"\')<CR>', opt_sn)

-- vim.api.nvim_set_keymap('n', "<leader>|", ":<C-u>let @/=\"<C-R>=expand(\"<CWORD>\")<CR>\"<CR>:set hls<CR>", opt_sn)
-- vim.cmd('nnoremap <expr> <leader>| ":let @/=\"<C-R>=expand(\"<CWORD>\")<CR>\"<CR>:set hls<CR>"')


map('n', '<leader>,', '<cmd>w<cr>', opt_sn)

snmap('/', 'b#')
TSmap('\\', 'Telescope buffers')
TSmap('-', 'Telescope find_files')
TSmap('#', 'find_files', '{ cwd = vim.fn.expand(\'%:p:h\') }')
-- }}}
-- }}}

-- {{{ Letters
-- {{{ [d]
map('o', 'w', 'iw', opt_sn)
map('o', 'W', 'iW', opt_sn)
-- }}}
-- {{{ [g] - Aerial
map('n', 'g}', ':AerialNext<CR>', opt_sn)
map('n', 'g{', ':AerialPrev<CR>', opt_sn)
-- map('n', 'g]', ':TSTextobjectGotoNextStart @function.inner<CR>:TSTextobjectGotoNextStart @function.inner<CR>', opt_sn)
map('n', 'g[', ':AerialPrevUp<CR>', opt_sn)
map('n', 'g]', ':AerialNextUp<CR>', opt_sn)
map('', 'gF', ':lua _G.print_stuff(vim.fn.expand("<cWORD>"))<CR>', opt_sn)
-- map('', 'gF', ':expand("<cWORD>")<CR>', opt_e)
-- }}}
-- }}}



-- {{{ Visual-Block Mode
-- {{{ [p]
-- map('v', 'p', '"_dp', opt_sn)
-- }}}
-- }}}


-- {{{ ['] - Marks

map('n', '\'/', '<cmd>A<CR>', opt_sn)
-- map('n', '\'\\', '<cmd>AV<CR>', opt_sn)


map('n', '<leader>\'', ':lua require("harpoon.mark").add_file()<CR>', opt_sn)
-- require_map('h\'', 'harpoon.mark', 'add_file')
map('n', '\'h', ':lua require("harpoon.ui").nav_file(1)<CR>', opt_sn)
map('n', '\'t', ':lua require("harpoon.ui").nav_file(2)<CR>', opt_sn)
map('n', '\'n', ':lua require("harpoon.ui").nav_file(3)<CR>', opt_sn)
map('n', '\'s', ':lua require("harpoon.ui").nav_file(4)<CR>', opt_sn)
map('n', '\'-', ':lua require("harpoon.ui").nav_file(5)<CR>', opt_sn)
map('n', '\'#', ':lua require("harpoon.ui").nav_file(6)<CR>', opt_sn)
-- map('n', '\'g', ':lua require("harpoon.ui").nav_file(7)<CR>', opt_sn)
map('n', '\'m', ':lua require("harpoon.term").gotoTerminal(1)<CR>', opt_sn)
map('n', '\'w', ':lua require("harpoon.term").gotoTerminal(2)<CR>', opt_sn)
map('n', '\'v', ':lua require("harpoon.term").gotoTerminal(3)<CR>', opt_sn)
-- map('n', '\'m', '<CMD>lua require("FTerm").toggle()<CR>', opt_sn)             -- returns any externally-required keymaps for usage
map('n', '\'z', ':lua _G.__fterm_gitui()<CR>', opt_sn)

-- }}}

-- {{{ [Ctrl]

map('n', '<C-h>', ':winc h<CR>', opt_sn)
map('n', '<C-l>', ':winc l<CR>', opt_sn)
map('n', '<C-j>', ':winc j<CR>', opt_sn)
map('n', '<C-k>', ':winc k<CR>', opt_sn)
map('n', '<C-\\>', ':w<CR>', opt_sn)
map('n', '<C-d>', '3<C-e>', opt_sn)
map('n', '<C-u>', '3<C-y>', opt_sn)

-- map('i', '<C-a>', '<Esc>Ea', opt_sn)
-- map('i', '<C-l>', '<Esc>la', opt_sn)
map('i', '<C-o>', '<C-x><C-o>', opt_sn)
map('i', '<C-f>', '<C-x><C-f>', opt_sn)

map('v', '<C-y>', '"+y', opt_sn)
map('v', '<C-p>', '"+p', opt_sn)
-- }}}


-- {{{ terminal mappings
map('t', '<esc>', '<C-\\><C-n>', opt_sn)
map('t', '<C-j>', '<Down>', opt_e)
map('t', '<C-k>', '<Up>', opt_e)
-- }}}
-- {{{ command-line mappings
map('c', '<C-j>', '<Down>', opt_e)
map('c', '<C-k>', '<Up>', opt_e)
-- }}}



-- {{{ buffer management

map('n', '\\k', ':bn<CR>', { noremap = true })
map('n', '\\j', ':bp<CR>', { noremap = true })

-- }}}
-- {{{ F-keys
map('n', '<F1>', ':w<CR>', opt_n)
-- }}}
-- {{{
-- local function F2er(input)
--     if F
--     map('n', '<F2>' ":set laststatus=3<CR>")
-- end
--
-- map('n', '<leader>es2', ':set laststatus=2<CR>', opt_e)
-- map('n', '<leader>es3', ':set laststatus=3<CR>', opt_e)
-- map('n', '<F2>', ':w<CR>:winc l<CR>ipython main.py<CR>', opt_sn)

-- }}}

-- {{{ ?

-- map('n', '<leader><F1>', ':%s/\ //g<CR>', opt_sn)

-- function create_dir(file)
-- local var = vim.cmd(':call input(\'ae\')<CR>')
-- vim.cmd(':echo ' .. var )
-- end
-- map('n', '<F3>', ':!mkdir stinput(\'input: \')<CR>', opt_sn)
-- map('n', 'bbb', 'create_dir(%)', opt_sn)
-- map('n', '<F3>', ':')
-- map('t', '\'m', '<C-\\><C-n><CMD>lua require("FTerm").toggle()<CR>', opt_sn)
-- map('n', '<leader>rt', fterm_run('"pytest -v " .. vim.fn.expand(\'%\') .. "\\r"'), opt_sn)

-- }}}

-- Vimspector
vim.cmd([[
nmap <F9> <cmd>call vimspector#Launch()<cr>
nmap <F5> <cmd>call vimspector#StepOver()<cr>
nmap <F8> <cmd>call vimspector#Reset()<cr>
nmap <F11> <cmd>call vimspector#StepOver()<cr>")
nmap <F12> <cmd>call vimspector#StepOut()<cr>")
nmap <F10> <cmd>call vimspector#StepInto()<cr>")
]])
map('n', "<leader>Db", ":call vimspector#ToggleBreakpoint()<cr>", opt_sn)
map('n', "<leader>Dw", ":call vimspector#AddWatch()<cr>", opt_sn)
map('n', "<leader>De", ":call vimspector#Evaluate()<cr>", opt_sn)
map('n', "<leader>Dl", ":call vimspector#Launch()<cr>", opt_sn)
map('n', "<leader>Dq", ":call vimspector#Reset()<cr>", opt_sn)
map('n', "<leader>Dc", ":call vimspector#Continue()<cr>", opt_sn)
map('n', "<leader>Dr", ":call vimspector#Reset()<cr>", opt_sn)
map('n', "<leader>DR", ":call vimspector#Restart()<cr>", opt_sn)
-- map('n', "<leader>cd", ':vimgrep /\\.<C-r>l/g %<CR>:Trouble quickfix<CR>', opt_sn)
-- map('n', '<leader>cb', '<cmd>lua _G.build_file_in_nvim(vim.fn.expand("%:p"))<CR>', opt_sn)


map('n', '<leader>[', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opt_sn)
map('n', '<leader>]', '<cmd>lua vim.diagnostic.goto_next()<CR>', opt_sn)
map('n', '<leader>ds', '<cmd>lua vim.diagnostic.show()<CR>', opt_sn)

local function gs_map(mode, l, r, opts)
    opts = opts or {}
    -- opts.buffer = 0
    vim.keymap.set(mode, l, r, opts)
end

local gs = require('gitsigns')

function _G.activate_git_inspect()
    require('gitsigns').toggle_linehl()
    require('gitsigns').toggle_numhl()
    require('gitsigns').toggle_word_diff()
    -- Navigation
    -- gs_map('n', ']]', function()
    --     -- if vim.wo.diff then return ']]' end
    --     vim.schedule(function() require('gitsigns'))
    --     return '<Ignore>'
    --     end, {expr=true}
    -- )

    -- gs_map('n', '[[', function()
    --   -- if vim.wo.diff then return '[[' end
    --   vim.schedule(function() require('gitsigns'))
    --   return '<Ignore>'
    -- end, {expr=true})
end

map('n', '<leader>gi', '<cmd>lua _G.activate_git_inspect()<CR>', opt_sn)




local gs = require('gitsigns')
-- Actions
gs_map({ 'n', 'v' }, '<leader>uh', ':Gitsigns stage_hunk<CR>')
gs_map({ 'n', 'v' }, '<leader>ur', ':Gitsigns reset_hunk<CR>')
gs_map({ 'o', 'x' }, 'uh', ':<c-u>gitsigns select_hunk<cr>')
gs_map('n', '<leader>ub', require('gitsigns').toggle_current_line_blame)
gs_map('n', '<leader>us', require('gitsigns').stage_hunk)
gs_map('n', '<leader>uS', require('gitsigns').stage_buffer)
gs_map('n', '<leader>uu', require('gitsigns').undo_stage_hunk)
gs_map('n', '<leader>ur', require('gitsigns').reset_buffer)
gs_map('n', '<leader>up', require('gitsigns').preview_hunk)
gs_map('n', '<leader>ub', function() require('gitsigns').blame_line { full = true } end)
gs_map('n', '<leader>ud', require('gitsigns').diffthis)
gs_map('n', '<leader>uD', function() require('gitsigns').diffthis('~') end)
gs_map('n', '<leader>ud', require('gitsigns').toggle_deleted)

map('n', '<leader>uv', '<cmd>Gdiffsplit HEAD<CR><cmd>winc L<CR>', opt_sn)
map('n', '<leader>ut', '<cmd>Telescope git_status<cr>', opt_sn)
-- map('n', '<leader>gdm',  '<cmd>Gdiffsplit master<CR><cmd>winc L<CR>', opt_sn)
-- map('n', '<leader>gdc1', '<cmd>Gdiffsplit !~1<CR><cmd>winc L<CR>', opt_sn)
-- map('n', '<leader>gdc2', '<cmd>Gdiffsplit !~2<CR><cmd>winc L<CR>', opt_sn)
-- map('n', '<leader>gdc3', '<cmd>Gdiffsplit !~3<CR><cmd>winc L<CR>', opt_sn)
-- map('n', '<leader>gdc4', '<cmd>Gdiffsplit !~4<CR><cmd>winc L<CR>', opt_sn)

-- Text object
local wk = require('which-key')
local keymap = {
    u = {
        name = "Gitsigns",
        s = "stage hunk",
        S = "stage buffer",
        n = "reset hunk",
        u = "undo stage hunk",
        R = "reset buffer",
        p = "preview hunk",
        b = "blame line",
        d = "diff this && toggle deleted",
        D = "diff this ~",
        v = "diff-split",
        t = "Telescope git status"
    }
}
wk.register(keymap, {
    prefix = '<leader>',
})


map('n', '<leader>gdm', '<cmd>Gdiffsplit master<CR><cmd>winc L<CR>', opt_sn)
map('n', '<leader>gdh', '<cmd>Gdiffsplit HEAD<CR><cmd>winc L<CR>', opt_sn)
map('n', '<leader>gdc1', '<cmd>Gdiffsplit !~1<CR><cmd>winc L<CR>', opt_sn)
map('n', '<leader>gdc2', '<cmd>Gdiffsplit !~2<CR><cmd>winc L<CR>', opt_sn)
map('n', '<leader>gdc3', '<cmd>Gdiffsplit !~3<CR><cmd>winc L<CR>', opt_sn)
map('n', '<leader>gdc4', '<cmd>Gdiffsplit !~4<CR><cmd>winc L<CR>', opt_sn)
nmap(',', 'Telescope file_browser theme=dropdown path=%:p:h')

map('n', '<c-u>', '<c-u>zz', opt_sn)
map('n', '<c-d>', '<c-d>zz', opt_sn)

-- map('i', '|', "<esc>", opt_sn)

-- map('n', '<leader>1', "<cmd>lua vim.g.material_style=\"darker\"<CR><cmd>colorscheme material<CR>", opt_sn)
-- map('n', '<leader>2', "<cmd>lua vim.g.material_style=\"lighter\"<CR><cmd>colorscheme material<CR>", opt_sn)
-- map('n', '<leader>3', "<cmd>lua vim.g.material_style=\"oceanic\"<CR><cmd>colorscheme material<CR>", opt_sn)
-- map('n', '<leader>4', "<cmd>lua vim.g.material_style=\"palenight\"<CR><cmd>colorscheme material<CR>", opt_sn)
-- map('n', '<leader>5', "<cmd>lua vim.g.material_style=\"deep ocean\"<CR><cmd>colorscheme material<CR>", opt_sn)

map('n', '<leader>1', "<cmd>lua vim.g.gruvbox_material_foreground=\"material\"<CR><cmd>colorscheme gruvbox-material<CR>", opt_sn)
map('n', '<leader>2', "<cmd>lua vim.g.gruvbox_material_foreground=\"mix\"<CR><cmd>colorscheme gruvbox-material<CR>", opt_sn)
map('n', '<leader>3', "<cmd>lua vim.g.gruvbox_material_foreground=\"original\"<CR><cmd>colorscheme gruvbox-material<CR>", opt_sn)

require('lib.qf_cpp')

-- map('n', '<leader>rbl', '<cmd>lua _G.build_file(vim.fn.expand("%:p"))<CR>', opt_sn)
-- map('n', '<leader>rfl', '<cmd>lua _G.run_file_left(vim.fn.expand("%:p"))<CR>', opt_sn)

-- map('n', '<leader>rbf', '<cmd>lua _G.build_file_in_nvim(vim.fn.expand("%:p"))<CR><CMD>copen<CR>', opt_sn)
-- map('n', '<leader>rf', '<cmd>lua _G.run_file_here(vim.fn.expand("%:p"))<CR>', opt_sn)
-- map('n', '<leader>rtl', '<cmd>lua _G.make_file_right(vim.fn.expand("%:p"))<CR>', opt_sn)

-- map('n', '<leader>rbl', '<cmd>lua _G.run_cmake_in_nvim(vim.fn.expand("%:p"))<CR>', opt_sn)



-- map('n', '<leader>rah', '<cmd>lua _G.run_file_here(vim.fn.expand("%:p"))<CR>', opt_sn)

-- map('n', '<leader>rt', '<cmd>lua _G.new_run_test_file(vim.fn.expand("%:p"))<CR>', opt_sn)


map('n', '<leader>1', '<cmd>so ~/.config/nvim/lua/lib/qf_cpp.lua<CR>', opt_sn)




--  %s/\,\"\"gyr_1_x.*timestamp"":""/
-- local comma = "\\,"
-- local colon = ":"
-- local g = '\\"'
-- local until_ = '.*'
--
-- map('n', '<leader>at1', ':%s/'..comma..g..g.."gyr_1_x"..until_.."//g", opt_sn)
-- map('n', '<leader>at\'', '<cmd>%s/'..g.."//g<cr>", opt_sn)
-- map('n', '<leader>atx', '<cmd>%s/acc_x//g<cr>', opt_sn)
-- map('n', '<leader>aty', '<cmd>%s/acc_y//g<cr>', opt_sn)
-- map('n', '<leader>atz', '<cmd>%s/acc_z//g<cr>', opt_sn)
-- map('n', '<leader>at:', '<cmd>%s/'..colon..'//g<cr>', opt_sn)
-- map('n', '<leader>at,', '<cmd>%s/'..comma..'//g<cr>', opt_sn)
-- map('n', '<leader>at{', '<cmd>%s/{//g<cr>', opt_sn)
-- map('n', '<leader>at}', '<cmd>%s/}//g<cr>', opt_sn)
-- map('n', '<leader>at2', '<cmd>%s/'..until_.."timestamp//g<CR>", opt_sn)


-- map('n', '<leader>rbu', '<cmd>lua _G.run_cmake_in_nvim(vim.fn.expand("%:p"))<CR>', opt_sn)

-- map('n', '<leader>on', '<cmd>lua require("harpoon.tmux").sendCommand(2, "nvim "..vim.fn.expand("%").."\\r")<CR>', opt_sn)
map('n', '<leader>cP', '<cmd>colder<CR>', opt_sn)
map('n', '<leader>cN', '<cmd>cnewer<CR>', opt_sn)

map('n', '<leader>wl', '<cmd>wincmd l<CR>', opt_sn)
map('n', '<leader>wh', '<cmd>wincmd h<CR>', opt_sn)
map('n', '<leader>wj', '<cmd>wincmd j<CR>', opt_sn)
map('n', '<leader>wk', '<cmd>wincmd k<CR>', opt_sn)

map('n', '<C-l>', '<cmd>wincmd l<CR>', opt_sn)
map('n', '<C-h>', '<cmd>wincmd h<CR>', opt_sn)
map('n', '<C-j>', '<cmd>wincmd j<CR>', opt_sn)
map('n', '<C-k>', '<cmd>wincmd k<CR>', opt_sn)


_G.run_python_file = function(file)

    print(file)
    require('harpoon.term').sendCommand(1, "python3 "..file.."\r")
end

map('n', '<leader>rp', ':lua _G.run_python_file(vim.fn.expand("%:p"))<CR>', opt_sn)
-- require('lib.goto_parent')
-- map('n', 'gp', '<cmd>lua _G.goto_parent(vim.fn.expand("%:p"), "CMakeLists.txt")<CR>')


-- map('n', '<leader>rch', '<cmd>lua _G.run_xxx_in_nvim("cd build && cmake ..")<CR><CMD>copen<CR>', opt_sn)
-- map('n', '<leader>rcl', '<cmd>lua _G.build_file(vim.fn.expand("%:p"))<CR>', opt_sn)
return M
