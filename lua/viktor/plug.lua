-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd([[packadd packer.nvim]])

return require("packer").startup(function(use)
	use("neovim/nvim-lspconfig")
	use("nvim-lua/plenary.nvim")

	-- {{{ Package Managers
	use("wbthomason/packer.nvim")
	use("williamboman/mason.nvim")

	-- use("SirVer/ultisnips")

	-- }}}
	-- {{{ color-schemas
	use({ "catppuccin/nvim", as = "catppuccin" })
	use({ "dracula/vim", as = "dracula" })
	use("marko-cerovac/material.nvim")
	use("ellisonleao/gruvbox.nvim")
	use("jacoborus/tender.vim")
	use("folke/tokyonight.nvim")
	use("sainnhe/gruvbox-material")
	use("rebelot/kanagawa.nvim")
	-- }}}
	-- {{{ Looks
	use("nvim-tree/nvim-web-devicons")
	use("nvim-treesitter/playground")
	use({
		"nvim-lualine/lualine.nvim",
		requires = { "kyazdani42/nvim-web-devicons", opt = true },
	})
	--}}}
	-- tools
	use("stevearc/aerial.nvim")
	use("ThePrimeagen/harpoon")
	use("numToStr/Comment.nvim")
	use({
		"anuvyklack/windows.nvim",
		requires = {
			"anuvyklack/middleclass",
			"anuvyklack/animation.nvim",
		},
		config = function()
			vim.o.winwidth = 10
			vim.o.winminwidth = 10
			vim.o.equalalways = false
			require("windows").setup()
		end,
	})

	use("cbochs/grapple.nvim")
	use("anuvyklack/pretty-fold.nvim")
	use({ "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" })
	use({
		"nvim-treesitter/nvim-treesitter-textobjects",
		after = "nvim-treesitter",
		-- requires = "nvim-treesitter/nvim-treesitter",
	})

	-- completions
	use({ "hrsh7th/cmp-nvim-lsp" })
	use({ "hrsh7th/cmp-buffer" })
	use({ "hrsh7th/cmp-path" })
	use({ "hrsh7th/cmp-cmdline" })

	use({ "hrsh7th/nvim-cmp" })
	use({ "onsails/lspkind-nvim" }) --}}}
	use({ "hrsh7th/cmp-nvim-lsp-document-symbol" })
	use("hrsh7th/cmp-nvim-lsp-signature-help")
	-- use({'hrsh7th/cmp-nvim-lua'})

	-- lsp

	use("ray-x/lsp_signature.nvim")

	use({
		"folke/trouble.nvim",
		requires = "kyazdani42/nvim-web-devicons",
	})
	use("kevinhwang91/nvim-bqf")
	use("folke/which-key.nvim")
	use({
		"nvim-telescope/telescope.nvim",
		tag = "0.1.1",
		requires = {
			{ "nvim-lua/plenary.nvim" },
		},
	})
	use("nvim-telescope/telescope-live-grep-args.nvim")
	use({
		"nvim-telescope/telescope-fzf-native.nvim",
		run = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build",
	})
	use({ "nvim-telescope/telescope-file-browser.nvim" })

	use("simrat39/rust-tools.nvim")
	use({
		"saecki/crates.nvim",
		tag = "v0.3.0",
		requires = { "nvim-lua/plenary.nvim" },
		config = function()
			require("crates").setup()
		end,
	})

	use("windwp/nvim-autopairs")

	-- use {
	--     'nvim-tree/nvim-tree.lua',
	--     requires = {
	--         'nvim-tree/nvim-web-devicons', -- optional, for file icons
	--     },
	--     tag = 'nightly'                    -- optional, updated every week. (see issue #1193)
	-- }

	use("mbbill/undotree")
	-- use {
	--     'VonHeikemen/lsp-zero.nvim',
	--     requires = {
	--         -- LSP Support
	--         { 'neovim/nvim-lspconfig' },
	--         { 'williamboman/mason.nvim' },
	--         { 'williamboman/mason-lspconfig.nvim' },
	--         -- Autocompletion
	--         { 'hrsh7th/nvim-cmp' },
	--         { 'hrsh7th/cmp-buffer' },
	--         { 'hrsh7th/cmp-path' },
	--         { 'saadparwaiz1/cmp_luasnip' },
	--         { 'hrsh7th/cmp-nvim-lsp' },
	--         { 'hrsh7th/cmp-nvim-lua' },
	--         -- Snippets
	--         { 'L3MON4D3/LuaSnip' },
	--         { 'rafamadriz/friendly-snippets' },
	--     }
	-- }

	-- Lua
	use({
		"folke/zen-mode.nvim",
		config = function()
			require("zen-mode").setup({
				-- your configuration comes here
				-- or leave it empty to use the default settings
				-- refer to the configuration section below
			})
		end,
	})

	--- task runner for typescript
	--
	use("Shatur/neovim-tasks")
	use({ "CRAG666/code_runner.nvim", requires = "nvim-lua/plenary.nvim" })
	use({
		"akinsho/toggleterm.nvim",
		tag = "*",
		config = function()
			require("toggleterm").setup()
		end,
	})
	use({
		"jedrzejboczar/toggletasks.nvim",
		requires = {
			"nvim-lua/plenary.nvim",
			"akinsho/toggleterm.nvim",
		},
		-- To enable YAML config support
		rocks = "lyaml",
	})
	use("lewis6991/hover.nvim")
	use("folke/neodev.nvim")

	use("untitled-ai/jupyter_ascending.vim")

	use("nvim-neotest/neotest-plenary")

	use({
		"nvim-neotest/neotest",
		requires = {
			"nvim-lua/plenary.nvim",
			"nvim-treesitter/nvim-treesitter",
			"antoinemadec/FixCursorHold.nvim",
		},
	})
	use("nvim-neotest/neotest-python")
	use("rouge8/neotest-rust")

	use({
		"gbataille/nvim-test",
		branch = "rust_tests",
		config = function()
			require("nvim-test").setup()
		end,
	})

	-- use {
	--   "klen/nvim-test",
	--   config = function()
	--     require('nvim-test').setup()
	--   end
	-- }
	use("nvim-treesitter/nvim-treesitter-context")

	use("mfussenegger/nvim-lint")

	use("Vimjas/vim-python-pep8-indent")

	-- code action
	use({
		"kosayoda/nvim-lightbulb",
		requires = "antoinemadec/FixCursorHold.nvim",
	})
	use({
		"weilbith/nvim-code-action-menu",
		cmd = "CodeActionMenu",
	})
	vim.cmd([[packadd nvim-code-action-menu]])

	use("jose-elias-alvarez/null-ls.nvim")

	use({ "j-hui/fidget.nvim", tag = "legacy" })

	use({
		"mhartington/formatter.nvim",
	})

	use("tpope/vim-projectionist")

	-- GIT
	use("lewis6991/gitsigns.nvim")

	use("axkirillov/easypick.nvim")

	use({
		"stevearc/overseer.nvim",
		config = function()
			require("overseer").setup()
		end,
	})
	-- use 'cdelledonne/vim-cmake'
	use("civitasv/cmake-tools.nvim")

	use("sindrets/diffview.nvim")

	use({
		"nvim-neorg/neorg",
		run = ":Neorg sync-parsers", -- This is the important bit!
		config = function()
			require("neorg").setup({
				load = {
					["core.keybinds"] = {
						config = {
							neorg_leader = "<Leader>",
						},
					},
					["core.defaults"] = {
						-- journal_folder = "~/neovim/neorg/journal",
						-- config = {
						-- 	workspace = "~/neovim/neorg/default/",
						-- },
					}, -- Loads default behaviour
					["core.concealer"] = {}, -- Adds pretty icons to your documents
					["core.esupports.hop"] = {}, -- "Hop" between Neorg links, following them with a single keypress.
					["core.dirman"] = { -- Manages Neorg workspaces
						config = {
							-- default_workspace = "default",
							open_last_workspace = false,
							workspaces = {
								general = "/home/viktorhg/notes/default",
								research = "/home/viktorhg/notes/research",
								rust = "/home/viktorhg/notes/rust",
								linux = "/home/viktorhg/notes/linux/",
							},
						},
					},
					["core.completion"] = {
						config = {
							engine = "nvim-cmp",
						},
					},
				},
			})
		end,
	})

	-- use({
	-- 	"nvim-neorg/neorg",
	-- 	-- ft = "norg",
	-- 	-- after = "nvim-treesitter", -- You may want to specify Telescope here as well
	-- 	config = require("viktor.config.plugin.neorg").setup,
	-- 	run = ":Neorg sync-parsers",
	-- 	requires = "nvim-lua/plenary.nvim",
	-- })
	use("stevearc/profile.nvim")

	use("windwp/nvim-ts-autotag")
	use("ttibsi/pre-commit.nvim")
	use("tpope/vim-fugitive")

	use({
		"cseickel/diagnostic-window.nvim",
		requires = { "MunifTanjim/nui.nvim" },
	})

	use("puremourning/vimspector")

	use({
		"simrat39/inlay-hints.nvim",
		config = function()
			require("inlay-hints").setup()
		end,
	})

	use("danymat/neogen")

	-- use 'shivamashtikar/tmuxjump.vim'
	-- use 'junegunn/fzf.vim'
	-- use 'dmmulroy/tsc.nvim'
	-- use 'jose-elias-alvarez/typescript.nvim'

	-- MINIS
	use({ "echasnovski/mini.cursorword", branch = "stable" })
	use({ "echasnovski/mini.files", branch = "stable" })
end)
