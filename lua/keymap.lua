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
    if opt==nil then
        return opt_sn
    end
    return opt
end
local function process_func(func)
    if type(func)=="table" then
        return table.concat(func, '<CR>:')
    end
    return func
end

local function nmap(bind, func, opt)
    -- print('nmap')
    func = process_func(func)
    opt = process_opts(opt)
    local exec_func = ':'..func..'<CR>'
    local echo_func = ':echo "'..func..'"<CR>'
    -- print(echo_func)
    map('n', '<leader>'..bind, exec_func .. echo_func , opt)
    -- print('-------------------------------')
end
local function snmap(bind, func, opt, mode)
    if mode==nil then
        mode='n'
    end
    -- print('snmap')
    local func_str = process_func(func)
    local exec_func = ':'..func_str..'<CR>'
    local echo_func = ':echo "'..func_str..'"<CR>'
    opt = process_opts(opt)
    --vim.pretty_print(func)
    map(mode, '<leader>'..bind, exec_func .. echo_func , opt)
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

-- vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>k',    aa_a()   , opts_silent)
snmap('cn', 'lua _G._open_qfl()')
snmap('co', {'cope',  'lua _G._open_qfl()'})
snmap('cb', {'lua require(\'diaglist\').open_buffer_diagnostics()', 'lua _G._open_ll()'})
snmap('cd', {'lua vim.diagnostic.setqflist()', 'lua _G._open_qfl()'})
snmap('cq', 'ccl')
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

snmap('ea', {'AerialToggle',  'winc l'})
snmap('ee', {'winc v',  'winc h',  '60 winc |',  'enew',  'set nonu',  'set nornu'}) -- toggle relative line numbers
snmap('ej', 'lua _G.create_header()') -- toggle relative line numbers
amap('ec', 'CommentToggle') -- toggle comment on current line or selection
snmap('edc', 'cd %:p:h')
snmap('ed-', 'cd ..')
snmap('eSb', { 'profile start profile.log', 'profile file *', 'profile func *', 'echo "profiling has started"' })
snmap('eSe', {'profile pause',  'noautocmd qall!'})
snmap('eh', {'set hlsearch!',  'match none'}) -- toggle comment on current line or selection
snmap('ef', 'set foldenable!')

snmap('e.r', 'set rnu!') -- toggle relative line numbers
snmap('e.n', 'set number!') -- toggle relative line numbers
snmap('e.b', {'syncbind',  'set scrollbind',  'set cursorbind',  'set scrollopt=ver'})
snmap('e.s0', 'set laststatus=0')
snmap('e.s1', 'set laststatus=1')
snmap('e.s2', 'set laststatus=2')
snmap('e.s3', 'set laststatus=3')

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
    ['n <leader>gdm'] = '<cmd>Gdiffsplit master<CR><cmd>winc L<CR>',
    ['n <leader>gdh'] = '<cmd>Gdiffsplit HEAD<CR><cmd>winc L<CR>',
    ['n <leader>gdc1'] = '<cmd>Gdiffsplit !~1<CR><cmd>winc L<CR>',
    ['n <leader>gdc2'] = '<cmd>Gdiffsplit !~2<CR><cmd>winc L<CR>',
    ['n <leader>gdc3'] = '<cmd>Gdiffsplit !~3<CR><cmd>winc L<CR>',
    ['n <leader>gdc4'] = '<cmd>Gdiffsplit !~4<CR><cmd>winc L<CR>',

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
nmap('gaf', {'Git add % ',   'echo "git add file:\\n - " .. expand(\'%\')'})
-- git reset [ < . > , < % > ]
nmap('gr.', 'Git reset . ')
nmap('grf', {'Git reset % ',   'echo "git reset file:\\n - " .. expand(\'%\')'})
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
map('n', '<leader>rl', '<cmd>TestLast<CR>' .. send_r, opt_sn)

local function require_map(bind, path, func, args)
    if args==nil then
        args = ""
    end
    map('n', '<leader>'..bind, ':lua require("'..path..'").'..func..'('..args..')<CR>', opt_sn)
end

require_map('h\'', 'harpoon.mark', 'add_file')
require_map('ht', 'harpoon.ui', 'toggle_quick_menu')
require_map('hn', 'harpoon.ui', 'nav_next')
require_map('hp', 'harpoon.ui', 'nav_prev')

--map('n', '<leader>h\'', ':lua require("harpoon.mark").add_file()<CR>', opt_sn)
--map('n', '<leader>ht', ':lua require("harpoon.ui").toggle_quick_menu()<CR>', opt_sn)
--map('n', '<leader>hn', ':lua require("harpoon.ui").nav_next()<CR>', opt_sn)
--map('n', '<leader>hp', ':lua require("harpoon.ui").nav_prev()<CR>', opt_sn)

-- -- {{{ related

-- map('n', '<leader>1', ':lua require("harpoon.term").sendCommand(1, "python main.py\\r")<CR>', opt_sn)
-- map('n', '<leader>2', ':lua require("harpoon.term").sendCommand(1, "python run.py\\r")<CR>', opt_sn)
-- map('n', '<leader>p', ':lua require("harpoon.term").sendCommand(1, "pytest -v " .. vim.fn.expand(\'%\') .. "\\r") <CR>', opt_sn)

-- local harpoon = require("harpoon.").

-- map('n', '\'w', ':lua require("harpoon.term").gotoTerminal(2)<CR>', opt_sn)
-- map('n', '<F9>', ':lua require("harpoon.term").sendCommand(1, "python main.py\\r")<CR>', opt_sn)
-- map('n', '<leader>r', ':lua require("harpoon.term").sendCommand(1, "python test_route_guidance.py\\r")<CR>', opt_sn)

-- -- }}}
-- -- {{{ hop.nvim
-- map('n', '<leader>hh', ':HopWord<CR>', opt_sn)
-- map('n', '<leader>hk', ':HopWordBC<CR>', opt_sn)
-- map('n', '<leader>hj', ':HopWordAC<CR>', opt_sn)
-- map('n', '<leader>hl', ':HopWordMW<CR>', opt_sn)
-- map('n', '<leader>hc', ':HopChar1<CR>', opt_sn)
-- map('n', '<leader>hC', ':HopChar2<CR>', opt_sn)
-- map('n', '<leader>hg', ':HopPattern<CR>', opt_sn)
-- map('n', '<leader>hn', ':HopLineStart<CR>', opt_sn)
-- map('n', '<leader>hf', ':HopWordCurrentLine<CR>', opt_sn)
-- -- }}}

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
snmap('Lr', 'LspRestart')
snmap('Ls', 'LspStart')
snmap('LX', 'LspStop')
snmap('Ll', 'LspLog')

snmap('lf', 'lua vim.lsp.buf.formatting()')
snmap('lr', 'lua vim.lsp.buf.rename()')

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
snmap('Pc', 'PackerClean')
snmap('PC', 'PackerCompile')
snmap('Pi', 'PackerInstall')
snmap('Pl', 'PackerLoad')
snmap('PP', 'PackerProfile')
snmap('Po', 'PackerStatus')
snmap('Ps', 'PackerSync')
snmap('PSi', 'PackerSnapshot')
snmap('PSd', 'PackerSnapshotDelete')
snmap('PSr', 'PackerSnapshotRollback')
snmap('Pu', 'PackerUpdate')
-- snmap('Pa', 'packadd ')
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
snmap('s', 'b#')
-- }}}
-- {{{ [T] - Telescope
-- local function TSmap(mapping, func, inputs)
--     if inputs==nil then
--         map('n', '<leader>'..mapping, ':'..func..'<CR>', {noremap = true})
--     else
-- 	local st = ':lua require(\'telescope.builtin\').'
-- 	map('n', '<leader>'..mapping, st..func..'('..inputs..')<CR>', { noremap = true })
--     end
-- end
local function TSmap(bind, func, args)
    require_map(bind, 'telescope.builtin', func, args)
end



nmap('tf', 'Telescope find_files')
nmap('tc', 'Telescope buffers')
nmap('tu', 'Telescope find_files')
nmap('to', 'Telescope buffers')
nmap('tw', 'Telescope live_grep')
TSmap('tg', 'find_files', '{ cwd = vim.fn.expand(\'%:p:h\') }')
TSmap('te', 'find_files', '{ cwd = vim.fn.expand(\'%:p:h\') }')


TSmap('tv', 'live_grep', '{cwd = vim.fn.expand(\'%:p:h\')}')
TSmap('tz', 'live_grep', '{grep_open_files=true}')

snmap('wt', {'winc s',   'lua require(\'telescope.builtin\').lsp_type_definitions()'})

nmap('tr', 'Telescope resume')
nmap('tx', 'Telescope keymaps')
nmap('th', 'Telescope help_tags')

TSmap('tsa', 'lsp_dynamic_workspace_symbols', '{ ignore_symbols = {"variable", "constant"} }')
TSmap('tsc', 'lsp_dynamic_workspace_symbols', '{ symbols = {"class"} }')
TSmap('tsf', 'lsp_dynamic_workspace_symbols', '{ symbols = {"function"} }')
TSmap('t-',  'lsp_document_symbols', '{}')
TSmap('td',  'find_files','{ find_command={ "C:/Users/Lenovo/scoop/shims/fd.exe", "--type", "d" } }')

-- map('n', '<leader>tj', ':lua require(\'telescope.builtin\').lsp_dynamic_workspace_symbols({ignore_symbols = {"variable", "constant"}, cwd = vim.fn.expand(\'%:p:h\')})<CR>', { noremap = true })
-- map('n', '<leader>tq', ':lua require(\'telescope.builtin\').lsp_dynamic_workspace_symbols({ignore_symbols = {"variable", "constant"}, grep_open_files = true})<CR>', { noremap = true })

nmap('tb', 'Telescope file_browser')
nmap('tm', 'Telescope file_browser path=%:p:h')

-- }}}
-- {{{ [U] - ...
-- }}}
-- {{{ [V] - ...
snmap('vj', 'TSTextobjectGotoNextStart @block.outer')
snmap('vk', 'TSTextobjectGotoNextStart @block.inner')
snmap('ve', 'TSTextobjectGotoPreviousEnd @block.outer')
snmap('vu', 'TSTextobjectGotoPreviousEnd @block.inner')

-- function
map('n', '[mi', ':TSTextobjectGotoPreviousStart @function.inner<CR>', opt_sn)
map('n', '[mo', ':TSTextobjectGotoPreviousStart @function.outer<CR>', opt_sn)
map('n', ']mi', ':TSTextobjectGotoNextStart @function.inner<CR>', opt_sn)
map('n', ']mo', ':TSTextobjectGotoNextStart @function.outer<CR>', opt_sn)

-- class
map('n', '[ci', ':TSTextobjectGotoPreviousStart @class.inner<CR>', opt_sn)
map('n', '[co', ':TSTextobjectGotoPreviousStart @class.outer<CR>', opt_sn)
map('n', ']ci', ':TSTextobjectGotoNextStart @class.inner<CR>', opt_sn)
map('n', ']co', ':TSTextobjectGotoNextStart @class.outer<CR>', opt_sn)

-- loop
map('n', '[li', ':TSTextobjectGotoPreviousStart @loop.inner<CR>', opt_sn)
map('n', '[lo', ':TSTextobjectGotoPreviousStart @loop.outer<CR>', opt_sn)
map('n', ']li', ':TSTextobjectGotoNextStart @loop.inner<CR>', opt_sn)
map('n', ']lo', ':TSTextobjectGotoNextStart @loop.outer<CR>', opt_sn)

-- [if] conditional
map('n', '[ii', ':TSTextobjectGotoPreviousStart @loop.inner<CR>', opt_sn)
map('n', '[io', ':TSTextobjectGotoPreviousStart @loop.outer<CR>', opt_sn)
map('n', ']ii', ':TSTextobjectGotoNextStart @loop.inner<CR>', opt_sn)
map('n', ']io', ':TSTextobjectGotoNextStart @loop.outer<CR>', opt_sn)

-- [if] conditional
map('n', '[ti', ':TSTextobjectGotoPreviousStart @call.inner<CR>', opt_sn)
map('n', '[to', ':TSTextobjectGotoPreviousStart @call.outer<CR>', opt_sn)
map('n', ']ti', ':TSTextobjectGotoNextStart @call.inner<CR>', opt_sn)
map('n', ']to', ':TSTextobjectGotoNextStart @call.outer<CR>', opt_sn)


-- statement
map('n', '[s', ':TSTextobjectGotoPreviousStart @statement.outer<CR>', opt_sn)
map('n', ']s', ':TSTextobjectGotoNextStart @statement.outer<CR>', opt_sn)
-- parameter
map('n', '[p', ':TSTextobjectGotoPreviousStart @parameter.inner<CR>', opt_sn)
map('n', ']p', ':TSTextobjectGotoNextStart @parameter.inner<CR>', opt_sn)

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
snmap('|', "let @/='<C-R>=expand('<cword>')<CR>'<CR>:set hls")


map('n','<leader>,', '<cmd>w<cr>', opt_sn)

snmap('/', 'A')
TSmap('\\', 'Telescope buffers')
TSmap('-', 'Telescope find_files')
TSmap('#', 'find_files',   '{ cwd = vim.fn.expand(\'%:p:h\') }')
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
map('', 'gF', ':lua _G.print_thing(vim.fn.expand("<cWORD>"))<CR>', opt_e)
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
map('n', '\'\\', '<cmd>AV<CR>', opt_sn)
map('n', '\'h', ':lua require("harpoon.ui").nav_file(1)<CR>', opt_sn)
map('n', '\'t', ':lua require("harpoon.ui").nav_file(2)<CR>', opt_sn)
map('n', '\'n', ':lua require("harpoon.ui").nav_file(3)<CR>', opt_sn)
map('n', '\'s', ':lua require("harpoon.ui").nav_file(4)<CR>', opt_sn)
map('n', '\'-', ':lua require("harpoon.ui").nav_file(5)<CR>', opt_sn)
map('n', '\'#', ':lua require("harpoon.ui").nav_file(6)<CR>', opt_sn)
map('n', '\'g', ':lua require("harpoon.ui").nav_file(7)<CR>', opt_sn)
map('n', '\'c', ':lua require("harpoon.ui").nav_file(8)<CR>', opt_sn)
map('n', '\'r', ':lua require("harpoon.ui").nav_file(9)<CR>', opt_sn)
map('n', '\'l', ':lua require("harpoon.ui").nav_file(10)<CR>', opt_sn)
-- map('n', '\'g', ':lua require("harpoon.ui").nav_file(7)<CR>', opt_sn)
map('n', '\'m', ':lua require("harpoon.term").gotoTerminal(1)<CR>', opt_sn)
map('n', '\'w', ':lua require("harpoon.term").gotoTerminal(2)<CR>', opt_sn)
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

map('i', '<C-a>', '<Esc>Ea', opt_sn)
map('i', '<C-l>', '<Esc>la', opt_sn)
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

return M
