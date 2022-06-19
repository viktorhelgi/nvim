--vim.cmd [[packadd packer.nvim]]
require('packer').startup({
	function(use)
        -- Packer{{{
		use({ 'wbthomason/packer.nvim'})--}}}
        -- nvim-lspconfig{{{
		use({ 'neovim/nvim-lspconfig'})--}}}
        -- lsp-kind* {{{
		use({ 'onsails/lspkind-nvim', commit = '57e5b5d' })--}}}
		-- nvim-cmp* - [cmp-nvim-lsp*, cmp-path*, cmp-buffer*]{{{
		use({
			'hrsh7th/nvim-cmp',
			requires = {
				{ 'hrsh7th/cmp-nvim-lsp', commit = 'ebdfc20' },
				{ 'hrsh7th/cmp-path', commit = '466b6b8' },
				{ 'hrsh7th/cmp-buffer', commit = 'd66c4c2' },
			},
			commit = '2aa7eee',
		})--}}}
        -- cmp-nvim-ultisnips{{{
		use({ 'quangnguyen30192/cmp-nvim-ultisnips', commit = 'c6ace8c' })--}}}

		-- UTILITY PLUGINS
		-- these plugins are all realted to editor configs
        -- lualine* - nvim-web-devicons {{{
		use({
			'nvim-lualine/lualine.nvim',
			requires = { 'kyazdani42/nvim-web-devicons', opt = true },
			commit = '18a07f7',
		})--}}}
        -- tabline* {{{
		use({ 'kdheepak/tabline.nvim', commit = 'b080ed3' })--}}}
        -- telescope* - popup* - plenary*{{{
		use({
			'nvim-telescope/telescope.nvim',
			requires = {
				-- { 'nvim-lua/popup.nvim', commit = 'b7404d3' },
				-- { 'nvim-lua/plenary.nvim', commit = '9069d14' },
				{ 'nvim-lua/popup.nvim' },
				{ 'nvim-lua/plenary.nvim' },
			},
			-- commit = '6e7ed1b',
		})--}}}
        -- telescope-fzf-native{{{
		use({ 'nvim-telescope/telescope-fzf-native.nvim', run = 'make'})--}}}
        -- nvim-autopairs* {{{
		use({ 'windwp/nvim-autopairs', commit = '38d486a' })--}}}
        -- nvim-comment* {{{
		use({ 'terrortylor/nvim-comment', commit = '8619217' })--}}}
        -- neoformat* {{{
		use({ 'sbdchd/neoformat', commit = '06920fa' })--}}}
        -- hop.nvim* {{{
		use({ 'phaazon/hop.nvim', commit = 'e2f978b' })--}}}
        -- gitsigns* - plenary {{{
		use({ 'lewis6991/gitsigns.nvim', requires = { 'nvim-lua/plenary.nvim' }, commit = '565b94d' })--}}}
        -- which-key*{{{
		use({ 'folke/which-key.nvim', commit = 'a3c19ec' })--}}}

		-- IMPORVED SYNTAX PLUGINS
        -- nvim-treesitter*{{{
		use({ 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' , commit = '9425591' })--}}}
        -- nvim-treesitter-textobjects{{{
		use({'nvim-treesitter/nvim-treesitter-textobjects'})--}}}
        -- dashboard {{{
		use({ 'glepnir/dashboard-nvim'})--}}}
        -- nvim-colorizer.lua{{{
		use({'norcalli/nvim-colorizer.lua', commit = '36c610a'})--}}}

		-- {{{ THEMES
        -- onedark{{{
		use({'joshdick/onedark.vim'})--}}}
        -- gruvbox{{{
		use({'morhetz/gruvbox'})--}}}
        -- gruvbox-material{{{
		use({'sainnhe/gruvbox-material'})--}}}
        -- nord{{{
		use({'shaunsingh/nord.nvim'})--}}}
        -- everforest{{{
		use({'sainnhe/everforest'})--}}}
        -- bluewery{{{
		use({'relastle/bluewery.vim'})--}}}
        -- night-owl{{{
		use({'haishanh/night-owl.vim'})--}}}
        -- melange{{{
		use({"savq/melange"})--}}}
        -- aldiun{{{
		use({"AlessandroYorba/Alduin"})--}}}
        -- nvcode-color-schemes.vim{{{
		use({"ChristianChiarulli/nvcode-color-schemes.vim"})--}}}
        -- monokai.nvim{{{
		use({"tanvirtin/monokai.nvim"})--}}}
		-- }}}

        -- aerial.nvim{{{
		use({'stevearc/aerial.nvim'})--}}}
        -- impatient.nvim{{{
		use({'lewis6991/impatient.nvim'})--}}}
        -- lsp_signature{{{
		use({"ray-x/lsp_signature.nvim"})--}}}
        -- vim-python-pep8-indent{{{
		-- use({"Vimjas/vim-python-pep8-indent", ft="py"})
		use({"Vimjas/vim-python-pep8-indent"})--}}}
        -- harpoon{{{
		use({'ThePrimeagen/harpoon', commit = 'b5cc65c731817faa5a505917b01de6a5ff0f2860'})--}}}
        -- vim-fugitive{{{
		use({'tpope/vim-fugitive'})--}}}

		use({"rust-lang/rust-analyzer"})
        -- rust-tools.nvim{{{
        use({"simrat39/rust-tools.nvim"})
		-- use({
		-- 	"simrat39/rust-tools.nvim",
		-- 	config = function()
		-- 		-- local lsp_installer_servers = require("nvim-lsp-installer.servers")
		-- 		-- local _, requested_server = lsp_installer_servers.get_server("rust_analyzer")
		-- 		require("rust-tools").setup({
		-- 			tools = {
		-- 				autoSetHints = false,
		-- 				hover_with_actions = true,
		-- 				inlay_hints = {
		-- 					highlight = "DiagnosticInfo",
		-- 				},
		-- 				runnables = {
		-- 					use_telescope = true,
		-- 				},
		-- 			},
		-- 			server = {
		-- 				standalone = false
		-- 				-- cmd = requested_server._default_options.cmd,
		-- 				-- on_attach = require("lvim.lsp").common_on_attach,
		-- 				-- on_init = require("lvim.lsp").common_on_init,
		-- 			},
		-- 			on_attach = on_attach_rust,
		-- 			checkOnSave = {
		-- 				enable = true,
		-- 			},
		-- 		})
		-- 		end
		-- })
--}}}
        -- vim-rust-syntax-ext{{{
    	use({ "arzg/vim-rust-syntax-ext"})--}}}
        -- pytrize {{{
		use { 
		  'AckslD/nvim-pytrize.lua', ft="py",
		  -- uncomment if you want to lazy load
		  -- cmd = {'Pytrize', 'PytrizeClear', 'PytrizeJump'},
		  -- uncomment if you want to lazy load but not use the commands
		  -- module = 'pytrize',
		  config = 'require("pytrize").setup()',
		} -- }}}
        -- vim-test{{{
		use({"vim-test/vim-test"})--}}}
		--         -- FTerm.nvim{{{
		-- use({"numToStr/FTerm.nvim"})--}}}
        -- vim-projectionist{{{
		use({"tpope/vim-projectionist"})--}}}
        -- telescope-file-browser.nvim{{{
        use({ "nvim-telescope/telescope-file-browser.nvim" })--}}}
        -- diffview.nvim [plenary]{{{
		use({ 'sindrets/diffview.nvim', requires = 'nvim-lua/plenary.nvim' })--}}}
        -- pretty-fold.nvim {{{
        -- use({ 'anuvyklack/pretty-fold.nvim',
        --     -- requires = 'anuvyklack/nvim-keymap-amend', -- only for preview
        --     config = function()
        --         require('pretty-fold').setup()
        --         -- require('pretty-fold.preview').setup({
        --         --     default_keybindings = false,
        --         --     border = {'', '', '', '', '', '', '', ''},
        --         -- })
        --    end
        -- })--}}}

        -- use({'famiu/nvim-reload'})
        -- Debuggor: [one-small-step-for-vimkind] - [nvim-dap]
        -- use({'jbyuki/one-small-step-for-vimkind'})
        -- use({'mfussenegger/nvim-dap'})
        -- use {
        --     'chipsenkbeil/distant.nvim',
        --     config = function()
        --     require('distant').setup {
        --         -- Applies Chip's personal settings to every machine you connect to
        --         --
        --         -- 1. Ensures that distant servers terminate with no connections
        --         -- 2. Provides navigation bindings for remote directories
        --         -- 3. Provides keybinding to jump into a remote file's parent directory
        --         ['*'] = require('distant.settings').chip_default()
        --     }
        --     end
        -- }
        use({'kevinhwang91/nvim-bqf'})
        -- use({'ryanoasis/vim-devicons'})
        -- use({
        --     "folke/trouble.nvim",
        --     requires = "kyazdani42/nvim-web-devicons",
        --     config = function()
        --         require("trouble").setup {
        --         -- your configuration comes here
        --         -- or leave it empty to use the default settings
        --         -- refer to the configuration section below
        --         }
        --     end
        -- })

        use({"nathom/filetype.nvim"})

	end,

	-- display packer dialouge in the center in a floating window{{{
	config = {
		display = {
			open_fn = require('packer.util').float,
		},
	},--}}}
})

-- # vim foldmethod=marker
