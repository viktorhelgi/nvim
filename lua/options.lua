--[[
	File for setting vim options

	vim.cmd is like executing a whole command
	vim.opt is like setting an opt
--]]
local cmd = vim.cmd
local opt = vim.opt
local g = vim.g
local o = vim.o

-- cmd('syntax enable') 	-- syntax highlighting

-- g.matchparen_timeout = 2
-- g.matchparen_insert_timeout = 2
cmd('autocmd User TelescopePreviewerLoaded set number relativenumber wrap list')
cmd('autocmd User TelescopePreviewerLoaded redraw')
cmd('set autowrite')
-- cmd('set laststatus=3')
-- cmd('set winhighlight=Normal:FTerm')
-- cmd('hi FTerm guibg=#2b3339')

-- cmd('set shellslash')
-- cmd('set completeslash=backslash')
cmd('set completeslash=slash')
o.rnu = true         	-- relative line numbers
o.nu = true         	-- line numbers
o.mouse = 'a'       	-- mouse controls
o.cursorline = true 	-- highlight line cursor is in
o.modeline = true   	-- enable modlines for files
o.modelines = 5			-- number of modelines
o.signcolumn = 'yes'
o.smartcase = true

--@type vim.
-- vim.diagnostic({
--     config = {
--
--     }
-- })
-- vim.diagnostic.config({
--     virtual_text = false,
-- })
-- o.updatetime = 250
-- cmd [[autocmd! CursorHold,CursorHoldI * lua vim.diagnostic.open_float(nil, {focus=false})]]

o.errorbells = false 	-- auditory stimulation annoying

opt.ruler = false		-- how line number/column
opt.hidden = true 		-- keeps buffers loaded in the background
opt.ignorecase = true
opt.scrolloff = 8   	-- buffer starts scrolling 8 lines from the end of view
opt.incsearch = true
opt.wrap = false


-- Tab settings
o.tabstop = 4 			-- 4 tabstop
o.shiftwidth = 4
o.expandtab = true    	-- tabs -> spaces
-- o.smartindent = true    -- nice indenting

o.foldmethod = 'marker' -- set fold method to marker

-- backup/swap files
opt.swapfile = false  	-- have files saved to swap
opt.undofile = true		-- file undo history preserved outside current session

-- new win split options
opt.splitbelow = true
opt.splitright = true
-- o.completeopt = 'menuone,noselect'
opt.completeopt = {'menu', 'menuone', 'noselect'}


vim.opt.termguicolors = true

-- # vim foldmethod=marker

g.python3_host_prog = "/usr/bin/python3"

-- https://github.com/rcarriga/vim-ultest
-- g.ultest_use_pty = 1
cmd('let test#python#runner = \'pytest\'')
cmd('let g:test#preserve_screen = 1')
cmd('let test#strategy = "harpoon"')
cmd('let g:test#harpoon_term = 1')
cmd('let g:test#harpoon#gototerminal = 0')



-- g.do_filetype_lua = 1

-- vim.filetype.add({
--     filename = {
--         [".json"] = "json"
--     }
-- })



