-- This init file loads all of the plugin configuration files

 -- means a plug in is not loaded

return {

	require('config.plug.ultisnips'),
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
	-- require('config.plug._diffview_plug'),
	-- require('config.plug.nvim-dap'),
    -- }}}
    -- {{{ [E]
    -- }}}
    -- {{{ [F] - fterm
	-- require('config.plug._filetype_'),
    require('config.plug.formatter'),
    -- }}}
    -- {{{ [G] - gitsigns
	require('config.plug.gitsigns'),
    require('config.plug._glow-hover_'),
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
	require('config.plug._lualine_'),
	require('config.plug.luasnip'),
    require("config.plug.diaglist"),
    -- }}}
    -- {{{ [J]
    -- }}}
    -- {{{ [M]
    -- }}}
    -- {{{ [N] - nvimcolorizer - nvimcomment - *nvimreload
	require('config.plug.nvimcolorizer'),
	-- require('config.plug.nvimcomment'),
    require('config.plug._comment_'),
    require('config.plug._nvim-tmux-navigation_'),
	-- require('config.plug.neotest'),

    -- require('config.plug._klen-nvim-test'),
    require('config.plug.vim-test'),

    require('config.plug._clangd_extensions'),

    -- require('config.plug.nvim-bqf'),
	-- require('config.plug.nvimreload'),
    -- }}}
    -- {{{ [O] - *one-small-step-for-vimkind
	-- require('config.plug.one-small-step-for-vimkind'),
	require('config.plug._overseer_'),
    -- }}}
    -- {{{ [P] - pretty-fold
	-- require('config.plug.pretty-fold'),
    -- }}}
    -- {{{ [Q]
    -- }}}
    -- {{{ [R]
    require('config.plug.refactoring'),
    -- }}}
    -- {{{ [S]
    -- }}}
    -- {{{ [T] - tabline - telescope - treesitter
	-- require('config.plug.tabline'),
	require('config.plug._neovim-tasks_'),
	require('config.plug.telescope'),
	require('config.plug.treesitter'),
	require('config.plug._trouble_'),
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
	-- Additional Plugins
}

-- # vim foldmethod=marker
