--vim.cmd [[packadd packer.nvim]]
require('packer').startup({
    function(use)
        use({ 'wbthomason/packer.nvim' })
        use({ 'williamboman/mason.nvim' })
        use({ 'williamboman/mason-lspconfig.nvim' })
        use({ "williamboman/nvim-lsp-installer" })
        use({ 'neovim/nvim-lspconfig' })
        use({ 'onsails/lspkind-nvim', commit = '57e5b5d' })
        use({ 'onsails/diaglist.nvim' })
        use({ 'hrsh7th/nvim-cmp' })
        --
        use({ 'hrsh7th/cmp-nvim-lsp' })
        use({ 'hrsh7th/cmp-path' })
        use({ 'hrsh7th/cmp-buffer' })
        use({ 'L3MON4D3/LuaSnip' })
        use({ 'saadparwaiz1/cmp_luasnip' })
        use({ 'hrsh7th/cmp-nvim-lsp-document-symbol' })
        use({ 'hrsh7th/cmp-nvim-lua' })
        use 'hrsh7th/cmp-omni'

        use({ 'SirVer/ultisnips' })
        use({ 'quangnguyen30192/cmp-nvim-ultisnips' })
        -- UTILITY PLUGINS: realted to editor configs
        use({
            'nvim-lualine/lualine.nvim',
            requires = { 'kyazdani42/nvim-web-devicons', opt = true },
            commit = '18a07f7',
        })
        use({ 'kdheepak/tabline.nvim', commit = 'b080ed3' })
        use({
            'nvim-telescope/telescope.nvim',
            requires = {
                { 'nvim-lua/popup.nvim' },
                { 'nvim-lua/plenary.nvim' },
            },
        })
        use({ 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' })
        use({ 'windwp/nvim-autopairs', commit = '38d486a' })
        use({ 'sbdchd/neoformat', commit = '06920fa' })
        use({ 'phaazon/hop.nvim', commit = 'e2f978b' })
        use({ 'lewis6991/gitsigns.nvim', requires = { 'nvim-lua/plenary.nvim' } })
        use({ 'folke/which-key.nvim', commit = 'a3c19ec' })

        -- IMPORVED SYNTAX PLUGINS
        use({ 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' })
        use({ 'nvim-treesitter/nvim-treesitter-textobjects' })
        use 'nvim-treesitter/playground'
        use 'kevinhwang91/nvim-bqf'
        use({ 'glepnir/dashboard-nvim' })
        use({ 'norcalli/nvim-colorizer.lua', commit = '36c610a' })

        -- {{{ THEMES
        use({ 'joshdick/onedark.vim' })
        use({ 'morhetz/gruvbox' })
        use({ 'sainnhe/gruvbox-material' })
        use({ 'sainnhe/edge' })
        use({ 'shaunsingh/nord.nvim' })
        use({ 'relastle/bluewery.vim' })
        use({ 'haishanh/night-owl.vim' })
        use({ "savq/melange" })
        use({ "AlessandroYorba/Alduin" })
        use({ "ChristianChiarulli/nvcode-color-schemes.vim" })
        use({ "tanvirtin/monokai.nvim" })
        use { "catppuccin/nvim", as = "catppuccin" }
        use({
            'rose-pine/neovim',
            as = 'rose-pine',
        })
        use "EdenEast/nightfox.nvim" -- Packer
        use "marko-cerovac/material.nvim"
        use "folke/tokyonight.nvim"
        -- THEMES END }}} 

        use({ 'stevearc/aerial.nvim' })
        use({ 'lewis6991/impatient.nvim' })
        use({ "ray-x/lsp_signature.nvim" })
        use({ "Vimjas/vim-python-pep8-indent" })
        use({ 'ThePrimeagen/harpoon' })
        use({ 'tpope/vim-fugitive' })

        use({ 'JuliaEditorSupport/julia-vim' })

        use({ "rust-lang/rust-analyzer" })
        use({ "simrat39/rust-tools.nvim" })

        use({ "arzg/vim-rust-syntax-ext" })
        use {
            'AckslD/nvim-pytrize.lua', ft = "py",
            config = 'require("pytrize").setup()',
        }
        use({ "vim-test/vim-test" })
        use({ "preservim/vimux" })
        use({ "tpope/vim-projectionist" })
        use({ "nvim-telescope/telescope-file-browser.nvim" })
        use({ 'sindrets/diffview.nvim', requires = 'nvim-lua/plenary.nvim' })
        use({ 'puremourning/vimspector' })
        -- Lua
        use { "folke/trouble.nvim",
            requires = "kyazdani42/nvim-web-devicons",
            config = function()
                require("trouble").setup()
            end
        }
        use({ 'monkoose/matchparen.nvim' })
        use({ 'liuchengxu/graphviz.vim' })
        use({ 'derekwyatt/vim-fswitch' })
        use({ 'mhartington/formatter.nvim' })
        use({ 'p00f/clangd_extensions.nvim' })
        use {
            "lewis6991/hover.nvim",
            config = function()
                require("hover").setup {
                    init = function()
                        -- Require providers
                        require("hover.providers.lsp")
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
        use { 'stevearc/overseer.nvim', config = function() require('overseer').setup() end }

        use 'Shatur/neovim-tasks'
        use { 'weilbith/nvim-code-action-menu', cmd = 'CodeActionMenu' }

        use { 'numToStr/Comment.nvim', config = function() require('Comment').setup() end }

        use { 'terror/chatgpt.nvim', run = 'pip3 install -r requirements.txt' }
        use 'mfussenegger/nvim-lint'
        use { "ThePrimeagen/refactoring.nvim",
            requires = {
                { "nvim-lua/plenary.nvim" },
                { "nvim-treesitter/nvim-treesitter" }
            }
        }
        use { "axkirillov/telescope-changed-files" }
        use { "untitled-ai/jupyter_ascending.vim"}
        use 'nanotee/sqls.nvim'
        -- use 'vim-scripts/dbext.vim'

        -- use {'romgrk/barbar.nvim', requires = 'nvim-web-devicons'}

    end,


    -- display packer dialouge in the center in a floating window
    config = {
        display = {
            open_fn = require('packer.util').float,
        },
    },
})


require("mason").setup({
    PATH = "prepend", -- "skip" seems to cause the spawning error
})
require("mason-lspconfig").setup()

-- old plugins
-- 'terrortylor/nvim-comment'
-- 'nvim-neotest/neotest-plenary'
-- 'nvim-neotest/neotest-python'
-- 'nvim-neotest/neotest-vim-test'
-- 'nvim-neotest/neotest'
-- 'klen/nvim-test'
-- 'numToStr/FTerm.nvim'
-- 'anuvyklack/pretty-fold.nvim'
-- 'romgrk/barbar.nvim'
-- 'famiu/nvim-reload'
-- 'jbyuki/one-small-step-for-vimkind'
-- 'mfussenegger/nvim-dap'
-- 'chipsenkbeil/distant.nvim'
-- 'kevinhwang91/nvim-bqf'
-- 'ryanoasis/vim-devicons'
-- 'jose-elias-alvarez/null-ls.nvim'
-- 'euclio/vim-markdown-composer'
-- 'vimwiki/vimwiki'
-- 'nathom/filetype.nvim'
-- 'ellisonleao/glow.nvim'
-- 'JASONews/glow-hover'
-- 'alexghergh/nvim-tmux-navigation'
-- 'aserowy/tmux.nvim'
-- 'alexghergh/nvim-tmux-navigation'
-- 'nathom/filetype.nvim'
