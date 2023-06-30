
vim.g.mapleader = ' ' -- Map leader key to space

vim.o.rnu = true         	-- relative line numbers
vim.o.nu = true         	-- line numbers
vim.o.mouse = 'a'       	-- mouse controls
vim.o.cursorline = true 	-- highlight line cursor is in
vim.o.modeline = true   	-- enable modlines for files
vim.o.modelines = 5			-- number of modelines
vim.o.signcolumn = 'yes'

vim.o.tabstop = 4 			-- 4 tabstop
vim.o.shiftwidth = 4
vim.o.expandtab = true    	-- tabs -> spaces
vim.o.swapfile = false
vim.o.wrap = false
vim.o.splitright = true


vim.opt.ignorecase = true
vim.opt.undofile = true		-- file undo history preserved outside current session


vim.api.nvim_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

-- opt.completeopt = {'menu', 'menuone', 'noselect'}


-- cmd('let test#rust#runner = \'cargonextest\'')
-- cmd('let test#strategy = "harpoon"')
-- cmd('let g:test#harpoon_term = 1')
-- cmd('let g:test#harpoon#gototerminal = 0')
vim.cmd('let test#python#runner = \'pytest\'')
vim.cmd('let test#rust#runner = \'cargotest\'')
vim.cmd('let g:test#echo_command = 0')
vim.cmd('let g:test#preserve_screen = 1')
vim.cmd("let test#strategy = 'vimux'")

vim.cmd("let g:ftplugin_sql_omni_key = '<C-o>'")

-- vim.g.python3_host_prog = "/usr/bin/python"
vim.g.python3_host_prog = "/usr/bin/python3.9"

vim.cmd('au TextYankPost * silent! lua vim.highlight.on_yank()')

vim.cmd("let g:cmake_root_markers=['build']")

-- vim.g.UltiSnipsSnippetDirectories = { "~/.config/nvim/ultisnippets" }
-- vim.g.UltiSnipsExpandTrigger = "<C-y>"
-- vim.g.UltiSnipsJumpForwardTrigger="<c-l>"
-- vim.g.UltiSnipsJumpBackwardTrigger="<c-b>"

