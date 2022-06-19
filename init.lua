
require('impatient')
require('plug') -- ~/AppData/Local/nvim/lua/plug.lua

require('keymap') -- ~/AppData/Local/nvim/lua/keymap.lua
require('options') -- ~/AppData/Local/nvim/lua/options.lua
require('autocmds') -- ~/AppData/Local/nvim/lua/autocmds.lua

-- {{{ colorscheme 
-- load theme loading library
local scheme = require('lib.scheme')

-- Load Themes (loads everforest theme by default)
-- load editor color theme
-- scheme.load_scheme('everforest')

-- load statusline theme
-- bluewery.lua custom.lua everforest.lua gruvbox-material.lua gruvbox.lua
-- minimaldark.lua monokai.lua night-owl.lua nord.lua onedark.lua
-- scheme.load_lualine_scheme('everforest')

-- if you don't  want to specify the theme for each component,
-- you can use the following function
-- scheme.load_shared_scheme('everforest')
-- scheme.load_scheme('alduin')
-- scheme.load_scheme('everforest_tp')
-- vim.cmd('colorscheme alduin')
-- scheme.load_shared_scheme('alduin')
scheme.load_shared_scheme('gruvbox-material')
-- vim.cmd('colorscheme aurora')
-- vim.cmd('colorscheme nvcode')
-- vim.cmd('colorscheme metanoia')
-- vim.cmd('colorscheme lunar')


-- set the statusline and tabline style
-- you can change the characters used
-- for seperators in the statusline and tabline
-- for instance, we can use bubble characters
scheme.load_global_style({'', ''}, {'', ''})
-- }}}

require('config.lsp')
require('config.plug')
require('config.modules') -- ~/AppData/Local/nvim/lua/autocmds.lua

if vim.g.neovide ~= nil then--{{{
    -- vim.opt.guifont = FiraCode\ Nerd\ Font:h11
    -- set guifont=FiraCode\ Nerd\ Font\ Mono\ Retina:h11
    -- vim.opt.guifont='JetBrainsMonoNL Nerd Font Mono:h12'
	vim.g.neovide_transparency=0.9
    vim.opt.guifont='JetBrainsMonoNL Nerd Font Mono:h10'
    vim.api.nvim_set_keymap('n', '<F11>', ':let g:neovide_transparency-=0.01<CR>', {})
    vim.api.nvim_set_keymap('n', '<F12>', ':let g:neovide_transparency+=0.01<CR>', {})
end--}}}









