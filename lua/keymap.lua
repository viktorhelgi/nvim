
local M = {}

-- {{{ FUNCTIONS

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
	vim.api.nvim_set_keymap(mode, bind, exec, opts)
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

local function mysplit (inputstr, sep)
        if sep == nil then
                sep = "%s"
        end
        local t={}
        for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
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

-- {{{ opts

local opt_e = { silent=false } --empty opt for maps with no extra options
local opt_n = { silent=false, noremap=true } --empty opt for maps with no extra options
local opt_s = { silent=true } --empty opt for maps with no extra options
local opt_sn ={ silent=true, noremap=true }
vim.g.mapleader = ' ' -- Map leader key to space
vim.g.maplocalleader = ','

-- }}}

-- {{{ Random

-- -- {{{ autocompletion mappings for cmp

local cmp = require('cmp')
M.cmp_mappings = {
	['<Tab>'] = cmp.mapping(cmp.mapping.select_next_item(), { 'i', 's' }),
	['<S-Tab>'] = cmp.mapping(cmp.mapping.select_prev_item(), { 'i', 's' }),
	['<C-d>'] = cmp.mapping(cmp.mapping.select_next_item(), { 'i', 's' }),
	['<C-u>'] = cmp.mapping(cmp.mapping.select_prev_item(), { 'i', 's' }),
	['<C-Space>'] = cmp.mapping.complete(),
	['<C-y>'] = cmp.mapping.scroll_docs(-4),
	['<C-e>'] = cmp.mapping.scroll_docs(4),
	-- ['<C-e>'] = cmp.mapping.close(),
	['<C-k>'] = cmp.mapping.confirm({
		behavior = cmp.ConfirmBehavior.Insert,
		select = true,
	}),
}

-- -- }}}
-- --{{{ gitsigns mappings

-- }}}

-- }}}

-- {{{ <Leader>

-- {{{ [A] - ...
-- }}}
-- {{{ [B] - Buffers

map('n', '<leader>bf', ':bf<CR>', { noremap = true })
map('n', '<leader>bk', ':bn<CR>', { noremap = true })
map('n', '<leader>bj', ':bp<CR>', { noremap = true })
map('n', '<leader>bl', ':bl<CR>', { noremap = true })
map('n', '<leader>bd', ':bd<CR>', { noremap = true })

-- }}}
-- {{{ [c] - CommentToggle


function _G._assign_n__CMD_cn_and_cp_CR__()
    -- set new keymaps
    vim.api.nvim_set_keymap('n', 'N', ':cp<CR>', {})
    vim.api.nvim_set_keymap('n', 'n', ':cn<CR>', {})

    -- set deactivation keymaps to "/"
    vim.api.nvim_set_keymap('n', '/',
        ":lua vim.api.nvim_del_keymap('n', 'N')<CR>"..
        ":lua vim.api.nvim_del_keymap('n', 'n')<CR>"..
        ":lua vim.api.nvim_del_keymap('n', '/')<CR>/" , {})
end

-- vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>k',    aa_a()   , opts_silent)
vim.api.nvim_set_keymap('n', '<leader>cn',    ':lua _G._assign_n__CMD_cn_and_cp_CR__()<CR>'   , opt_sn)
vim.api.nvim_set_keymap('n', '<leader>co',    ':cope<CR>'   , opt_sn)
vim.api.nvim_set_keymap('n', '<leader>cq',    ':ccl<CR>'   , opt_sn)
vim.api.nvim_set_keymap('n', '<leader>cd',    ':lua vim.diagnostic.setqflist()<cr>'   , opt_sn)

-- }}}
-- {{{ [D] - DiffView

map('', '<leader>do0', ':DiffviewOpen HEAD<CR>', opt_sn) -- Previous Commit
map('', '<leader>do1', ':DiffviewOpen HEAD~1<CR>', opt_sn) -- Previous Commit
map('', '<leader>do2', ':DiffviewOpen HEAD~2<CR>', opt_sn) -- Previous Commit
map('', '<leader>do3', ':DiffviewOpen HEAD~3<CR>', opt_sn) -- Previous Commit
map('', '<leader>do4', ':DiffviewOpen HEAD~4<CR>', opt_sn) -- Previous Commit

map('', '<leader>da', ':DiffviewOpen HEAD<CR>', opt_sn) -- Previous Commit
map('', '<leader>db', ':DiffviewOpen HEAD~1<CR>', opt_sn) -- Previous Commit
map('', '<leader>dc', ':DiffviewOpen origin/main<CR>', opt_sn)     -- Previous Push
map('', '<leader>dd', ':DiffviewOpen origin/main...HEAD<CR>', opt_sn)     -- Previous Push
map('', '<leader>dq', ':DiffviewClose<CR>', opt_sn)
map('', '<leader>dt', ':DiffviewToggleFiles<CR>', opt_sn)
map('', '<leader>df', ':DiffviewFileHistory<CR>', opt_sn)

-- }}}
-- {{{ [E] - Extra

map('n', '<leader>ea', ':AerialToggle<CR>', opt_sn)
map('n', '<leader>ee', ':winc v<CR>:winc h<CR>:50 winc |<CR>:enew<CR>:set nonu<CR>', opt_sn) -- toggle relative line numbers
map('',  '<leader>ec', ':CommentToggle<CR>', opt_sn) -- toggle comment on current line or selection
map('n', '<leader>edc',    ':cd %:p:h<CR>', opt_sn)
map('n', '<leader>ed-',    ':cd ..<CR>', opt_sn)
map('n', '<leader>ePb', ':profile start profile.log<CR>:profile file *<CR>:profile func *<CR>:echo "profiling has started"<CR>', opt_sn)
map('n', '<leader>ePe', ':profile pause<CR>:noautocmd qall!<CR>', opt_sn)
map('n', '<leader>etv', ':vs | terminal<CR>i', opt_sn)
map('n', '<leader>ets',   ':sp | terminal<CR>i', opt_sn)
map('n', '<leader>eh', ':set hlsearch!<CR>:match none<CR>', opt_sn) -- toggle comment on current line or selection
map('n', '<leader>er', ':set rnu!<CR>', opt_sn) -- toggle relative line numbers
map('n', '<leader>ep', '"+p', opt_sn) -- toggle relative line numbers

map('v', '<leader>y', '"+y', opt_sn)

-- debugger
-- map('n', '<leader>edl', ':lua require("osv").launch({port = 8086})<CR>', opt_sn)
-- map('n', '<leader>edb', ':lua require("dap").toggle_breakpoint()<CR>', opt_sn)
-- map('n', '<leader>edc', ':lua require("dap").continue()<CR>', opt_sn)
-- map('n', '<leader>edi', ':lua require("dap").step_into()<CR>', opt_sn)
-- map('n', '<leader>edo', ':lua require("dap").step_over()<CR>', opt_sn)
-- map('n', '<leader>eds', ':lua require("dap").repl.open()<CR>', opt_sn)

-- local function m
map('n', '<leader>edS', ':lua _G.__reload()<CR>', opt_sn)


-- }}}
-- {{{ [F] - ...
-- }}}
-- {{{ [G] - GitSigns - Gdiff - git_status
M.gitsigns_mappings = {
	noremap = true,
	['n ]c'] = { expr = true, "&diff ? ']c' : '<cmd>lua require\"gitsigns.actions\".next_hunk()<CR>'" },
	['n [c'] = { expr = true, "&diff ? '[c' : '<cmd>lua require\"gitsigns.actions\".prev_hunk()<CR>'" },

	['n <leader>Gs'] = '<cmd>lua require"gitsigns".stage_hunk()<CR>',
	['v <leader>Gs'] = '<cmd>lua require"gitsigns".stage_hunk({vim.fn.line("."), vim.fn.line("v")})<CR>',
	['n <leader>Gu'] = '<cmd>lua require"gitsigns".undo_stage_hunk()<CR>',
	['n <leader>Gr'] = '<cmd>lua require"gitsigns".reset_hunk()<CR>',
	['v <leader>Gr'] = '<cmd>lua require"gitsigns".reset_hunk({vim.fn.line("."), vim.fn.line("v")})<CR>',
	['n <leader>GR'] = '<cmd>lua require"gitsigns".reset_buffer()<CR>',
	['n <leader>Gp'] = '<cmd>lua require"gitsigns".preview_hunk()<CR>',
	['n <leader>Gb'] = '<cmd>lua require"gitsigns".blame_line(true)<CR>',
	['n <leader>GS'] = '<cmd>lua require"gitsigns".stage_buffer()<CR>',
	['n <leader>GU'] = '<cmd>lua require"gitsigns".reset_buffer_index()<CR>',

	-- Text objects
	['o ih'] = ':<C-U>lua require"gitsigns.actions".select_hunk()<CR>',
	['x ih'] = ':<C-U>lua require"gitsigns.actions".select_hunk()<CR>',

	['n <leader>gdm'] = '<cmd>Gdiffsplit master<CR><cmd>winc L<CR>',
	['n <leader>gdh'] = '<cmd>Gdiffsplit HEAD<CR><cmd>winc L<CR>',
	['n <leader>gdc1'] = '<cmd>Gdiffsplit !~1<CR><cmd>winc L<CR>',
	['n <leader>gdc2'] = '<cmd>Gdiffsplit !~2<CR><cmd>winc L<CR>',
	['n <leader>gdc3'] = '<cmd>Gdiffsplit !~3<CR><cmd>winc L<CR>',
	['n <leader>gdc4'] = '<cmd>Gdiffsplit !~4<CR><cmd>winc L<CR>',

	['n <leader>gs'] = '<cmd>Telescope git_status<CR>',
}

map('n', '<leader>gs', '<cmd>Telescope git_status<CR>', opt_sn)
-- }}}
-- {{{ [H] - Harpoon

local send_r = ':lua require("harpoon.term").sendCommand(1, "\\r")<CR>'
map('n', '<leader>rl', '<cmd>TestLast<CR>' .. send_r, opt_sn)

map('n', '<leader>h\'', ':lua require("harpoon.mark").add_file()<CR>', opt_sn)
map('n', '<leader>ht', ':lua require("harpoon.ui").toggle_quick_menu()<CR>', opt_sn)
map('n', '<leader>hn', ':lua require("harpoon.ui").nav_next()<CR>', opt_sn)
map('n', '<leader>hp', ':lua require("harpoon.ui").nav_prev()<CR>', opt_sn)

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

map('n', '<leader>Li', ':LspInfo<CR>', opt_n)
map('n', '<leader>Lr', ':LspRestart<CR>', opt_n)
map('n', '<leader>Ls', ':LspStart<CR>', opt_n)
map('n', '<leader>LX', ':LspStop<CR>', opt_n)
map('n', '<leader>Ll', ':LspLog<CR>', opt_n)

map('n', '<leader>lf','<cmd>lua vim.lsp.buf.formatting()<CR>', opt_sn)
map('n', '<leader>lr','<cmd>lua vim.lsp.buf.rename()<CR>', opt_sn)

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
map('n', '<leader>Pc', ':PackerClean<CR>', opt_n)
map('n', '<leader>PC', ':PackerCompile<CR>', opt_n)
map('n', '<leader>Pi', ':PackerInstall<CR>', opt_n)
map('n', '<leader>Pl', ':PackerLoad<CR>', opt_n)
map('n', '<leader>PP', ':PackerProfile<CR>', opt_n)
map('n', '<leader>Po', ':PackerStatus<CR>', opt_n)
map('n', '<leader>Ps', ':PackerSync<CR>', opt_n)
map('n', '<leader>PSi', ':PackerSnapshot<CR>', opt_n)
map('n', '<leader>PSd', ':PackerSnapshotDelete<CR>', opt_n)
map('n', '<leader>PSr', ':PackerSnapshotRollback<CR>', opt_n)
map('n', '<leader>Pu', ':PackerUpdate<CR>', opt_n)
map('n', '<leader>Pa', ':packadd ', opt_n)
map('n', '<leader>PL', ':packloadall<CR>', opt_n)
map('n', '<leader>P\'', ':e C:/Users/Lenovo/AppData/Local/nvim/lua/plug.lua<CR>', opt_n)
-- }}}
-- {{{ [q] - Quit [:q]
map('n', '<leader>q', ':q<CR>', opt_sn)
-- }}}
-- {{{ [R] - Testing
-- map('n', '<leader>rp', fterm_run('"python " .. vim.fn.expand(\'%\') .. "\\r"'), opt_sn)
-- map('n', '<leader>rt', fterm_run('"pytest -v -rP " .. vim.fn.expand(\'%\') .. "\\r"'), opt_sn)
-- map('n', '<leader>rA', fterm_run('"pytest -v -rP \\r"'), opt_sn)

-- map('n', '<leader>rfl', fterm_run('"pytest --fixtures \\r"'), opt_sn)

-- }}}
-- {{{ [s] - Alternate Buffers
map('n', '<leader>s', ':b#<CR>', opt_sn)
-- }}}
-- {{{ [T] - Telescope
map('n', '<leader>tf', ':Telescope find_files<CR>', { noremap = true })
map('n', '<leader>tg', ':lua require(\'telescope.builtin\').find_files( { cwd = vim.fn.expand(\'%:p:h\') })<CR>', { noremap = true })
map('n', '<leader>tc', ':Telescope buffers<CR>', { noremap = true })
map('n', '<leader>tu', ':Telescope find_files<CR>', { noremap = true })
map('n', '<leader>te', ':lua require(\'telescope.builtin\').find_files( { cwd = vim.fn.expand(\'%:p:h\') })<CR>', { noremap = true })
map('n', '<leader>to', ':Telescope buffers<CR>', { noremap = true })

map('n', '<leader>tw', ':Telescope live_grep<CR>', { noremap = true })
map('n', '<leader>tv', ':lua require(\'telescope.builtin\').live_grep({cwd = vim.fn.expand(\'%:p:h\')})<CR>', opt_sn)
map('n', '<leader>tz', ':lua require(\'telescope.builtin\').live_grep({grep_open_files=true})<CR>', opt_sn)
map('n', '<leader>tp', ':Telescope live_grep<CR>', { noremap = true })
-- map('n', '<leader>t.', ':lua require(\'telescope.builtin\').live_grep({cwd = vim.fn.expand(\'%:p:h\')})<CR>', opt_sn)
-- map('n', '<leader>t,', ':lua require(\'telescope.builtin\').live_grep({grep_open_files=true})<CR>', opt_sn)

map('n', '<leader>tr', ':Telescope resume<CR>', { noremap = true })
map('n', '<leader>tx', ':Telescope keymaps<CR>', { noremap = true })
map('n', '<leader>th', ':Telescope help_tags<CR>', { noremap = true })

map('n', '<leader>ts', ':lua require(\'telescope.builtin\').lsp_dynamic_workspace_symbols({ ignore_symbols = {"variable", "constant"} })<CR>', { noremap = true })
map('n', '<leader>t-', ':lua require(\'telescope.builtin\').lsp_document_symbols({})<CR>', { noremap = true })
-- map('n', '<leader>tj', ':lua require(\'telescope.builtin\').lsp_dynamic_workspace_symbols({ignore_symbols = {"variable", "constant"}, cwd = vim.fn.expand(\'%:p:h\')})<CR>', { noremap = true })
-- map('n', '<leader>tq', ':lua require(\'telescope.builtin\').lsp_dynamic_workspace_symbols({ignore_symbols = {"variable", "constant"}, grep_open_files = true})<CR>', { noremap = true })

map('n', '<leader>tb', ':Telescope file_browser<CR>', { noremap = true })
map('n', '<leader>tm', ':Telescope file_browser path=%:p:h<CR>', { noremap = true })

map('n', '<leader>td', ':lua require(\'telescope.builtin\').find_files({find_command={"C:/Users/Lenovo/scoop/shims/fd.exe",             "--type", "d"                                               }})<CR>', opt_sn)
-- }}}
-- {{{ [U] - ...
-- }}}
-- {{{ [V] - ...
map('n', '<leader>vj', ':TSTextobjectGotoNextStart @block.outer<CR>', opt_sn)
map('n', '<leader>vk', ':TSTextobjectGotoNextStart @block.inner<CR>', opt_sn)
map('n', '<leader>ve', ':TSTextobjectGotoPreviousEnd @block.outer<CR>', opt_sn)
map('n', '<leader>vu', ':TSTextobjectGotoPreviousEnd @block.inner<CR>', opt_sn)

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
map('n', '<leader>ws', ':winc s<CR>', opt_sn)
map('n', '<leader>wv', ':winc v<CR>', opt_sn)
map('n', '<leader>wq', ':winc q<CR>', opt_sn)
map('n', '<leader>wc', ':winc c<CR>', opt_sn)
map('n', '<leader>wo', ':winc o<CR>', opt_sn)
map('n', '<leader>wK', ':winc K<CR>', opt_sn)
map('n', '<leader>wJ', ':winc J<CR>', opt_sn)
map('n', '<leader>wL', ':winc L<CR>', opt_sn)
map('n', '<leader>wH', ':winc H<CR>', opt_sn)
map('n', '<leader>wT', ':winc T<CR>', opt_sn)
map('n', '<leader>w=', ':winc =<CR>', opt_sn)
map('n', '<leader>wt', ':winc s<CR>:lua require(\'telescope.builtin\').lsp_type_definitions()<CR>', opt_sn)

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
-- {{{ [<other>]
map('n', '<leader>~', ':Dashboard<CR>', opt_sn) -- map show dashboard
map('n', '<leader>}', ':bn<CR>', { noremap = true })
map('n', '<leader>{', ':bp<CR>', { noremap = true })
map('n', '<leader>!', ':s/<c-r>///g<left><left>', opt_sn)
map('n', '<leader>|', ":let @/='<C-R>=expand('<cword>')<CR>'<CR>:set hls<CR>", opt_sn)


map('n', '<leader>,', ':w<CR>', opt_sn)

map('n', '<leader>/', '<cmd>A<CR>', opt_sn)
map('n', '<leader>\\', ':Telescope buffers<CR>', opt_sn)
map('n', '<leader>-', ':Telescope find_files<CR>', opt_sn)
map('n', '<leader>#', ':lua require(\'telescope.builtin\').find_files( { cwd = vim.fn.expand(\'%:p:h\') })<CR>', opt_sn)
-- }}}

-- }}}

-- {{{ ['] - Marks

map('n', '\'/', '<cmd>A<CR>', opt_sn)
map('n', '\'h', ':lua require("harpoon.ui").nav_file(1)<CR>', opt_sn)
map('n', '\'t', ':lua require("harpoon.ui").nav_file(2)<CR>', opt_sn)
map('n', '\'n', ':lua require("harpoon.ui").nav_file(3)<CR>', opt_sn)
map('n', '\'s', ':lua require("harpoon.ui").nav_file(4)<CR>', opt_sn)
map('n', '\'-', ':lua require("harpoon.ui").nav_file(5)<CR>', opt_sn)
map('n', '\'#', ':lua require("harpoon.ui").nav_file(6)<CR>', opt_sn)
-- map('n', '\'g', ':lua require("harpoon.ui").nav_file(7)<CR>', opt_sn)
map('n', '\'m', ':lua require("harpoon.term").gotoTerminal(1)<CR>', opt_sn)
-- map('n', '\'m', '<CMD>lua require("FTerm").toggle()<CR>', opt_sn)             -- returns any externally-required keymaps for usage
map('n', '\'w', ':lua _G.__fterm_gitui()<CR>', opt_sn)

-- }}}

-- {{{ buffer management

map('n', '\\k', ':bn<CR>', { noremap = true })
map('n', '\\j', ':bp<CR>', { noremap = true })

-- }}}

-- {{{ terminal commands

map('t', '<esc>', '<C-\\><C-n>', opt_sn)

-- }}}
--
map('c', '<C-j>', '<Down>', opt_e)
map('c', '<C-k>', '<Up>', opt_e)

-- {{{ [g] - Aerial 

map('n', 'g}', ':AerialNext<CR>', opt_sn)
map('n', 'g{', ':AerialPrev<CR>', opt_sn)
map('n', 'g]', ':AerialNextUp<CR>', opt_sn)
map('n', 'g[', ':AerialPrevUp<CR>', opt_sn)

-- }}}

config = {
   default_keybindings = true, -- Set to false to disable default keybindings

   -- 'none', "single", "double", "rounded", "solid", 'shadow' or table
   -- For explanation see: :help nvim_open_win()
   border = {'', '', '', '', '', '', '', ''},
}




-- {{{ [Ctrl]

map('n', '<C-h>', ':winc h<CR>', opt_sn)
map('n', '<C-l>', ':winc l<CR>', opt_sn)
map('n', '<C-j>', ':winc j<CR>', opt_sn)
map('n', '<C-k>', ':winc k<CR>', opt_sn)
map('n', '<C-\\>', ':w<CR>', opt_sn)
map('i', '<C-o>', '<C-x><C-o>', opt_sn)
map('i', '<C-f>', '<C-x><C-f>', opt_sn)
map('v', '<C-y>', '"+y', opt_sn)
map('v', '<C-p>', '"+p', opt_sn)
map('i', '<C-a>', '<Esc>Ea', opt_sn)
map('i', '<C-l>', '<Esc>la', opt_sn)
map('i', '<C-d>', 'jjj', opt_sn)
map('i', '<C-u>', 'kkk', opt_sn)


-- }}}

-- {{{ <F-Nr>
map('n', '<F1>', ':w<CR>', opt_n)
-- local function F2er(input)
--     if F
--     map('n', '<F2>' ":set laststatus=3<CR>")
-- end
--
map('n', '<leader>es2', ':set laststatus=2<CR>', opt_e)
map('n', '<leader>es3', ':set laststatus=3<CR>', opt_e)
-- map('n', '<F2>', ':w<CR>:winc l<CR>ipython main.py<CR>', opt_sn)

-- }}}

-- {{{ ?

map('n', '<leader><F1>', ':%s/\//g<CR>', opt_sn)

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

return M
