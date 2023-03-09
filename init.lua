-- nmea/pgn/129026

require('impatient')
require('plug') -- ~/AppData/Local/nvim/lua/plug.lua

require('keymap') -- ~/AppData/Local/nvim/lua/keymap.lua
require('options') -- ~/AppData/Local/nvim/lua/options.lua
require('autocmds') -- ~/AppData/Local/nvim/lua/autocmds.lua

require('config.plug')
require('config.lsp')
require('config.plug.cmp')
require('config.modules') -- ~/AppData/Local/nvim/lua/autocmds.lua

if vim.g.neovide ~= nil then --{{{
    -- set guifont=FiraCode\ Nerd\ Font\ Mono\ Retina:h11
    -- vim.opt.guifont='JetBrainsMonoNL Nerd Font Mono:h12'
    vim.g.neovide_transparency = 0.9
    -- vim.opt.guifont='JetBrainsMonoNL Nerd Font Mono:h10'
    vim.opt.guifont = 'FiraCode Nerd Font:h11'
    vim.api.nvim_set_keymap('n', '<F11>', ':let g:neovide_transparency-=0.01<CR>', {})
    vim.api.nvim_set_keymap('n', '<F12>', ':let g:neovide_transparency+=0.01<CR>', {})
end --}}}

require('matchparen').setup({})

require('lib.cmake_testing')

-- -- require('themes.rose-pine')
-- -- require('themes.nightfox')
--
--
--
vim.g.material_style="palenight"
vim.g.gruvbox_material_foreground="mix"
-- local scheme = require('lib.scheme')
-- scheme.load_scheme('rose-pine')
-- vim.cmd('colorscheme duskfox')
-- vim.cmd('colorscheme material')
-- vim.cmd('colorscheme gruvbox-material')
-- vim.cmd('colorscheme catppuccin-frappe')
-- require("catppuccin").load("frappe")
require('themes.gruvbox-material-dark')

-- vim.g.jupyter_ascending_python_executable = "python3"

local find = require('viktor.lib.find')

-- local out = find.root("/home/viktor/hm/research/wbv-analysis/external/MK2-embedded/device/wbv/include/commons/CMakeLists.txt", {"README.md"})
-- print("out "..out)

-- vim.cmd('let g:test#cpp#catch2#bin_dir = "tests"')
-- vim.cmd('let g:test#cpp#catch2#bin_dir = "./tests"')
-- vim.cmd('let g:test#cpp#catch2#suite_command = "cd tests && ctest --ouput-on-failure"')


-- %:~:.:h


-- local fold_snippets = require'foldmethods.snippets'
-- fold_snippets.setup_folding()
