-- Simple standalone neovim config. Lives in this repo for versioning only —
-- nvim must NOT load it from here (this dir is on the runtimepath), so copy it
-- out before use, e.g.: cp simple.lua ~/.config/nvim-simple.lua
-- Then: nvim --clean -u ~/.config/nvim-simple.lua
vim.o.termguicolors = true
for _, g in ipairs({ "Normal", "NormalNC", "NormalFloat", "SignColumn", "EndOfBuffer" }) do
	vim.api.nvim_set_hl(0, g, { bg = "none" })
end

vim.g.mapleader = ' '
local map = vim.keymap.set

-- windows / movement
map('n', '<C-h>', '<CMD>wincmd h<CR>')
map('n', '<C-l>', '<CMD>wincmd l<CR>')
map('n', '<C-k>', '<CMD>wincmd k<CR>')
map('n', '<C-j>', '<CMD>wincmd j<CR>')
map('n', '<C-space>', 'zz')
map('n', "'b", '<CMD>b#<CR>')

-- count word under cursor
vim.cmd("nnoremap <expr> <leader>! ':%s/'.expand('<cword>').'//gn<CR>``'")

-- diagnostics
map('n', ']d', vim.diagnostic.goto_next)
map('n', '[d', vim.diagnostic.goto_prev)
map('n', 'cd', vim.diagnostic.setqflist)
map('n', 'do', vim.diagnostic.open_float)
map('n', '<leader>ds', vim.diagnostic.open_float)
map('n', '<leader>cd', vim.diagnostic.setqflist)

-- lsp (builtin, dead until a server attaches)
map('n', 'cs', vim.lsp.buf.signature_help)
map('n', 'gd', vim.lsp.buf.definition)
map('n', 'gD', vim.lsp.buf.declaration)
map('n', 'gh', vim.lsp.buf.hover)
map('n', 'gi', vim.lsp.buf.implementation)
map('n', 'gt', vim.lsp.buf.type_definition)
map('n', 'gr', vim.lsp.buf.references)
map('n', '<leader>la', vim.lsp.buf.code_action)
map('n', '<leader>ldh', vim.lsp.buf.document_highlight)
map('n', '<leader>lds', vim.lsp.buf.document_symbol)
map('n', '<leader>lh', vim.lsp.buf.hover)
map('n', '<leader>li', vim.lsp.buf.implementation)
map('n', '<leader>lI', vim.lsp.buf.incoming_calls)
map('n', '<leader>lo', vim.lsp.buf.outgoing_calls)
map('n', '<leader>lr', vim.lsp.buf.rename)
map('n', '<leader>lsh', vim.lsp.buf.signature_help)
map('n', '<leader>lwa', vim.lsp.buf.add_workspace_folder)
map('n', '<leader>lwr', vim.lsp.buf.remove_workspace_folder)
map('n', '<leader>lwl', vim.lsp.buf.list_workspace_folders)
map('n', '<leader>lti', function()
	local status = vim.lsp.inlay_hint.is_enabled()
	vim.lsp.inlay_hint.enable(not status)
	print('Toggle Inlay hints: ' .. (status and 'off' or 'on'))
end)

-- misc normal
map('n', 'gc', '<CMD>e Cargo.toml<CR>')
map('n', 'cq', '<CMD>cclose<CR>')
map('n', 'ys', 'viw"ly')

-- leader: basics
map('n', '<leader>|', '<CMD>messages<CR>')
map('n', '<leader>-', '<CMD>b#<CR>')
map('n', '<leader>q', '<CMD>q<CR>')
map('n', '<leader>Q', '<CMD>confirm qa<CR>')
map('n', '<leader>s', '<CMD>w<CR>')

-- leader: lists
map('n', '<leader>cP', vim.cmd.colder)
map('n', '<leader>cN', vim.cmd.cnewer)
map('n', '<leader>cn', '<CMD>cn<CR>')
map('n', '<leader>cp', '<CMD>cp<CR>')
map('n', '<leader>cq', function()
	vim.cmd('cclose')
	vim.cmd('lclose')
end)

-- leader: extras
map('n', '<leader>ebs', '<CMD>set scrollbind<CR><CMD>set cursorbind<CR>')
map('n', '<leader>ebx', '<CMD>set noscrollbind<CR><CMD>set nocursorbind<CR>')
map('n', '<leader>ec', '<CMD>cd %:p:h<CR>')
map('n', '<leader>e-', '<CMD>cd ..<CR>')
map('n', '<leader>efi', '<CMD>set foldmethod=indent<CR>')
map('n', '<leader>efs', '<CMD>set foldmethod=syntax<CR>')
map('n', '<leader>efm', '<CMD>set foldmethod=manual<CR>')
map('n', '<leader>eF', function() vim.print(vim.fn.expand('%:p')) end)
map('n', '<leader>eh', '<CMD>set hlsearch!<CR>')
map('n', '<leader>ep', '"+p')
map('n', '<leader>es', '<CMD>so %<CR>')
map('n', '<leader>etv', '<CMD>vs | terminal<CR>i')
map('n', '<leader>ets', '<CMD>sp | terminal<CR>i')

-- leader: replace word (prompted)
map('n', '<leader>rw', function()
	local current_word, new_word
	vim.ui.input({ prompt = 'current word: ' }, function(input) current_word = input end)
	vim.ui.input({ prompt = 'new word: ' }, function(input) new_word = input end)
	vim.cmd('%s/' .. current_word .. '/' .. new_word .. '/g')
end)

-- visual
map('v', '<leader>ey', '"+y')

-- insert
map('i', '<C-f>', '<C-x><C-f>')

-- terminal
map('t', '<esc>', '<C-\\><C-n>')
map('t', '<C-q>', '<C-\\><C-n>')
map('t', '<C-j>', '<Down>')
map('t', '<C-k>', '<Up>')

-- command
map('c', '<C-j>', '<Down>')
map('c', '<C-k>', '<Up>')
