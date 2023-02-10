--vim.cmd [[packadd packer.nvim]]
require('packer').startup({
    function(use)
        -- Packer{{{
        use({ 'wbthomason/packer.nvim' }) --}}}
        -- nvim-lspconfig{{{
        use({ 'williamboman/mason.nvim' })
        use({ 'williamboman/mason-lspconfig.nvim' })
        use({ "williamboman/nvim-lsp-installer" })
        use({ 'neovim/nvim-lspconfig' }) --}}}
        -- lsp-kind* {{{
        use({ 'onsails/lspkind-nvim', commit = '57e5b5d' }) --}}}
        use({ 'onsails/diaglist.nvim' })
        -- nvim-cmp* - [cmp-nvim-lsp*, cmp-path*, cmp-buffer*]{{{
        use({ 'hrsh7th/nvim-cmp' })
        --
        use({ 'hrsh7th/cmp-nvim-lsp' })
        use({ 'hrsh7th/cmp-path' })
        use({ 'hrsh7th/cmp-buffer' })
        use({ 'L3MON4D3/LuaSnip' })
        use({ 'saadparwaiz1/cmp_luasnip' })
        use({ 'hrsh7th/cmp-nvim-lsp-document-symbol' })
        use({ 'hrsh7th/cmp-nvim-lua' })
        --}}}
        use({ 'SirVer/ultisnips' })
        use({ 'quangnguyen30192/cmp-nvim-ultisnips' })
        -- cmp-nvim-ultisnips{{{
        -- use({ 'quangnguyen30192/cmp-nvim-ultisnips', commit = 'c6ace8c' })--}}}
        -- UTILITY PLUGINS
        -- these plugins are all realted to editor configs
        -- lualine* - nvim-web-devicons {{{
        use({
            'nvim-lualine/lualine.nvim',
            requires = { 'kyazdani42/nvim-web-devicons', opt = true },
            commit = '18a07f7',
        }) --}}}
        -- tabline* {{{
        use({ 'kdheepak/tabline.nvim', commit = 'b080ed3' }) --}}}
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
        }) --}}}
        -- use { 'sindrets/diffview.nvim', requires = 'nvim-lua/plenary.nvim' }
        -- Packer
        -- telescope-fzf-native{{{
        use({ 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }) --}}}
        -- nvim-autopairs* {{{
        use({ 'windwp/nvim-autopairs', commit = '38d486a' }) --}}}
        -- nvim-comment* {{{
        -- use({ 'terrortylor/nvim-comment', commit = '8619217' }) --}}}
        -- neoformat* {{{
        use({ 'sbdchd/neoformat', commit = '06920fa' }) --}}}
        -- hop.nvim* {{{
        use({ 'phaazon/hop.nvim', commit = 'e2f978b' }) --}}}
        -- gitsigns* - plenary {{{
        use({ 'lewis6991/gitsigns.nvim', requires = { 'nvim-lua/plenary.nvim' } }) --}}}
        -- which-key*{{{
        use({ 'folke/which-key.nvim', commit = 'a3c19ec' }) --}}}

        -- IMPORVED SYNTAX PLUGINS
        -- nvim-treesitter*{{{
        -- use({ 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate', commit = '9425591' }) --}}}
        use({ 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }) --}}}
        -- nvim-treesitter-textobjects{{{
        use({ 'nvim-treesitter/nvim-treesitter-textobjects' }) --}}}
        use 'nvim-treesitter/playground'
        use 'kevinhwang91/nvim-bqf'
        -- dashboard {{{
        use({ 'glepnir/dashboard-nvim' }) --}}}
        -- nvim-colorizer.lua{{{
        use({ 'norcalli/nvim-colorizer.lua', commit = '36c610a' }) --}}}

        -- {{{ THEMES
        -- onedark{{{
        use({ 'joshdick/onedark.vim' }) --}}}
        -- gruvbox{{{
        use({ 'morhetz/gruvbox' }) --}}}
        -- gruvbox-material{{{
        use({ 'sainnhe/gruvbox-material' }) --}}}
        -- edge{{{
        use({ 'sainnhe/edge' }) --}}}
        -- nord{{{
        use({ 'shaunsingh/nord.nvim' }) --}}}
        -- everforest{{{
        --use({ 'sainnhe/everforest' }) --}}}
        -- bluewery{{{
        use({ 'relastle/bluewery.vim' }) --}}}
        -- night-owl{{{
        use({ 'haishanh/night-owl.vim' }) --}}}
        -- melange{{{
        use({ "savq/melange" }) --}}}
        -- aldiun{{{
        use({ "AlessandroYorba/Alduin" }) --}}}
        -- nvcode-color-schemes.vim{{{
        use({ "ChristianChiarulli/nvcode-color-schemes.vim" }) --}}}
        -- monokai.nvim{{{
        use({ "tanvirtin/monokai.nvim" }) --}}}
        use { "catppuccin/nvim", as = "catppuccin" }
        use({
            'rose-pine/neovim',
            as = 'rose-pine',
        })
        use "EdenEast/nightfox.nvim" -- Packer
        use "marko-cerovac/material.nvim"
        use "folke/tokyonight.nvim"
        -- use "yunlingz/equinusocio-material.vim"
        -- use "w0ng/vim-hybrid"
        -- use "voidekh/kyotonight.vim"

        -- }}}
        --

        -- aerial.nvim{{{
        use({ 'stevearc/aerial.nvim' }) --}}}
        -- use {
        --   'stevearc/aerial.nvim',
        --   config = function() require('aerial').setup() end
        -- } -- }}}
        -- impatient.nvim{{{
        use({ 'lewis6991/impatient.nvim' }) --}}}
        -- lsp_signature{{{
        use({ "ray-x/lsp_signature.nvim" }) --}}}
        -- vim-python-pep8-indent{{{
        -- use({"Vimjas/vim-python-pep8-indent", ft="py"})
        use({ "Vimjas/vim-python-pep8-indent" }) --}}}
        -- harpoon{{{
        -- use({ 'ThePrimeagen/harpoon', commit = 'b5cc65c731817faa5a505917b01de6a5ff0f2860' })
        use({ 'ThePrimeagen/harpoon' }) --}}}
        -- vim-fugitive{{{
        use({ 'tpope/vim-fugitive' }) --}}}

        use({ 'JuliaEditorSupport/julia-vim' })

        use({ "rust-lang/rust-analyzer" })
        -- rust-tools.nvim{{{
        use({ "simrat39/rust-tools.nvim" })
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
        use({ "arzg/vim-rust-syntax-ext" }) --}}}
        -- pytrize {{{
        use {
            'AckslD/nvim-pytrize.lua', ft = "py",
            -- uncomment if you want to lazy load
            -- cmd = {'Pytrize', 'PytrizeClear', 'PytrizeJump'},
            -- uncomment if you want to lazy load but not use the commands
            -- module = 'pytrize',
            config = 'require("pytrize").setup()',
        } -- }}}
        -- vim-test{{{
        use({ "vim-test/vim-test" }) --}}}
        -- neotest{{{
        -- use({"nvim-neotest/neotest-plenary"})
        -- use({"nvim-neotest/neotest-python"})
        -- use({"nvim-neotest/neotest-vim-test"})
        -- use({
        --     "nvim-neotest/neotest",
        --     requires = {
        --         "nvim-lua/plenary.nvim",
        --         "nvim-treesitter/nvim-treesitter",
        --         "antoinemadec/FixCursorHold.nvim"
        --     }
        -- })

        -- use {
        --   "klen/nvim-test",
        --   config = function()
        --     require('nvim-test').setup()
        --   end
        -- }
        --}}}
        --         -- FTerm.nvim{{{
        -- use({"numToStr/FTerm.nvim"})--}}}
        -- vim-projectionist{{{
        use({ "tpope/vim-projectionist" }) --}}}
        -- telescope-file-browser.nvim{{{
        use({ "nvim-telescope/telescope-file-browser.nvim" }) --}}}
        -- diffview.nvim [plenary]{{{
        use({ 'sindrets/diffview.nvim', requires = 'nvim-lua/plenary.nvim' }) --}}}
        -- pretty-fold.nvim {{{
        -- use { 'anuvyklack/pretty-fold.nvim',
        --     config = function()
        --         require('pretty-fold').setup()
        --     end
        -- }
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
        -- use({
        --   'romgrk/barbar.nvim',
        --   requires = {'kyazdani42/nvim-web-devicons'}
        -- })
        -- use({'famiu/nvim-reload'})
        -- Debuggor: [one-small-step-for-vimkind] - [nvim-dap]
        -- use({'jbyuki/one-small-step-for-vimkind'})
        -- use({'mfussenegger/nvim-dap'})
        use({ 'puremourning/vimspector' })
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
        -- use({'kevinhwang91/nvim-bqf'})
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
        -- Lua
        use { "folke/trouble.nvim", -- {{{
            requires = "kyazdani42/nvim-web-devicons",
            config = function()
                require("trouble").setup()
            end
        } --- }}}
        use({ 'monkoose/matchparen.nvim' })

        use({ 'liuchengxu/graphviz.vim' })

        use({ 'derekwyatt/vim-fswitch' })

        -- use({ 'jose-elias-alvarez/null-ls.nvim' })

        use({ 'mhartington/formatter.nvim' })

        use({ 'p00f/clangd_extensions.nvim' })
        use {
            "lewis6991/hover.nvim",
            config = function()
                require("hover").setup {
                    init = function()
                        -- Require providers
                        require("hover.providers.lsp")
                        -- require('hover.providers.gh')
                        -- require('hover.providers.jira')
                        -- require('hover.providers.man')
                        -- require('hover.providers.dictionary')
                    end,
                    preview_opts = {
                        border = nil
                    },
                    -- Whether the contents of a currently open hover window should be moved
                    -- to a :h preview-window when pressing the hover keymap.
                    preview_window = false,
                    title = true
                }

                -- Setup keymaps
                vim.keymap.set("n", "K", require("hover").hover, { desc = "hover.nvim" })
                vim.keymap.set("n", "gK", require("hover").hover_select, { desc = "hover.nvim (select)" })
            end
        }
        use { 'stevearc/overseer.nvim', -- commit = "82ed207195b58a73b9f7d013d6eb3c7d78674ac9",
            config = function() require('overseer').setup() end }

        use 'Shatur/neovim-tasks'
        use {
            'weilbith/nvim-code-action-menu',
            cmd = 'CodeActionMenu'
        }

        use {
            'numToStr/Comment.nvim',
            config = function()
                require('Comment').setup()
            end
        }

        -- use 'euclio/vim-markdown-composer'

        -- use({ 'vimwiki/vimwiki' })

        -- use({"nathom/filetype.nvim"})
        -- use {"ellisonleao/glow.nvim"}
        -- use 'JASONews/glow-hover'
        use({
            'terror/chatgpt.nvim',
            run = 'pip3 install -r requirements.txt'
        })
        use 'mfussenegger/nvim-lint'

        -- use 'ThePrimeagen/refactoring.nvim'
        use { "ThePrimeagen/refactoring.nvim",
            requires = {
                { "nvim-lua/plenary.nvim" },
                { "nvim-treesitter/nvim-treesitter" }
            }
        }
        use { "axkirillov/telescope-changed-files" }

        -- use { "alexghergh/nvim-tmux-navigation" }
        -- use({
        --     "aserowy/tmux.nvim",
        --     config = function() return require("tmux").setup() end
        -- })
        -- use { 'alexghergh/nvim-tmux-navigation', config = function()
        --     require 'nvim-tmux-navigation'.setup {
        --         disable_when_zoomed = true, -- defaults to false
        --         keybindings = {
        --             left = "<C-h>",
        --             down = "<C-j>",
        --             up = "<C-k>",
        --             right = "<C-l>",
        --             last_active = "<C-\\>",
        --             next = "<C-Space>",
        --         }
        --     }
        -- end
        -- }
        -- use("nathom/filetype.nvim")
    end,


    -- display packer dialouge in the center in a floating window{{{
    config = {
        display = {
            open_fn = require('packer.util').float,
        },
    }, --}}}
})


require("mason").setup({
    PATH = "prepend", -- "skip" seems to cause the spawning error
})
require("mason-lspconfig").setup()

-- # vim foldmethod=marker
--
