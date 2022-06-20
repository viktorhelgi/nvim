--[[
This init file loads all of the plugin configuration files

* means a plug in is not loaded
--]]

return {
    -- {{{ [A] - autopairs - aerial
	require('config.plug.autopairs'),
	require('config.plug.aerial'),
    -- }}}
    -- {{{ [B]
    -- }}}
    -- {{{ [C] - cmp 
	require('config.plug.cmp'),
    -- }}}
    -- {{{ [D] - dashboard - diffview
	require('config.plug.dashboard'),
	require('config.plug.diffview'),
    -- }}}
    -- {{{ [E]
    -- }}}
    -- {{{ [F] - fterm
	-- require('config.plug.fterm'),
    -- }}}
    -- {{{ [G] - gitsigns
	require('config.plug.gitsigns'),
    -- }}}
    -- {{{ [H] - harpoon - hop
	require('config.plug.harpoon'),
	require('config.plug.hop'),
    -- }}}
    -- {{{ [I]
    -- }}}
    -- {{{ [J]
    -- }}}
    -- {{{ [J]
    -- }}}
    -- {{{ [L] - lspkind - lualine
	require('config.plug.lspkind'),
	require('config.plug.lualine'),
    -- }}}
    -- {{{ [J]
    -- }}}
    -- {{{ [M]
    -- }}}
    -- {{{ [N] - nvimcolorizer - nvimcomment - *nvimreload
	require('config.plug.nvimcolorizer'),
	require('config.plug.nvimcomment'),
    -- require('config.plug.nvim-bqf'),
	-- require('config.plug.nvimreload'),
    -- }}}
    -- {{{ [O] - *one-small-step-for-vimkind
	-- require('config.plug.one-small-step-for-vimkind'),
    -- }}}
    -- {{{ [P] - pretty-fold
	-- require('config.plug.pretty-fold'),
    -- }}}
    -- {{{ [Q]
    -- }}}
    -- {{{ [R]
    -- }}}
    -- {{{ [S]
    -- }}}
    -- {{{ [T] - tabline - telescope - treesitter
	require('config.plug.tabline'),
	require('config.plug.telescope'),
	require('config.plug.treesitter'),
    -- }}}
    -- {{{ [U]
    -- }}}
    -- {{{ [V]
    -- }}}
    -- {{{ [W] - which-key
	require('config.plug.which-key'),
    -- }}}
    -- {{{ [X]
    -- }}}
    -- {{{ [Y]
    -- }}}
    -- {{{ [Z]
    -- }}}

	-- require('config.plug.nvimtree'),
	-- require('config.plug.ultisnips'),
	-- Additional Plugins
}

-- # vim foldmethod=marker
