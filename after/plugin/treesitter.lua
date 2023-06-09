local ts_config = require('nvim-treesitter.configs')


vim.keymap.set('n', ']t', ":TSTextobjectRepeatLastMoveNext<CR>zz", {})
vim.keymap.set('n', '[t', ":TSTextobjectRepeatLastMovePrevious<CR>zz", {})


ts_config.setup({
	-- A list of parser names, or "all"
	ensure_installed = { 'lua', 'python', 'cpp', 'fish', 'rust', 'typescript', 'tsx'},
    -- 
    -- parser_install_dir = "/home/viktor/.config/treesitter/parsers",

	-- Install languages synchronously (only applied to `ensure_installed`)
	sync_install = true,

	-- List of parsers to ignore installing
	ignore_install = {},
    autotag = {
        enable = true
    },

	highlight = {
		-- `false` will disable the whole extension
		enable = true,

		-- list of language that will be disabled
		disable = {},

		-- Setting this to true will run `:h syntax` and tree-sitter at the same time.
		-- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
		-- Using this option may slow down your editor, and you may see some duplicate highlights.
		-- Instead of true it can also be a list of languages
		additional_vim_regex_highlighting = false,
	},
    indent = {
        enable = {'tsx', 'typescript'}
    },
	-- #########################################
	-- Viktor Configs
	textobjects = {
        move = {
            enable = true,
            set_jumps = true,
            goto_next_start = {
              ["]n"] = "@number.inner",
              ["]a"] = "@assignment.lhs",
              -- ["]al"] = "@assignment.rhs",
              ["]r"] = "@return.inner",
              ["]p"] = "@parameter.inner",
              ["]h"] = "@function.outer",
              ["]c"] = "@class.outer",
              ["]im"] = "@function.inner",
              ["]ic"] = "@class.inner",
            },
            goto_next_end = {
              ["]R"] = "@return.inner",
              ["]H"] = "@function.outer",
              ["]C"] = "@class.outer",
              ["]iM"] = "@function.inner",
              ["]iC"] = "@class.inner",
            },
            goto_previous_start = {
              ["[n"] = "@number.inner",
              ["[a"] = "@assignment.lhs",
              -- ["[al"] = "@assignment.rhs",
              ["[r"] = "@return.inner",
              ["[p"] = "@parameter.inner",
              ["[h"] = "@function.outer",
              ["[c"] = "@class.outer",
              ["[im"] = "@function.inner",
              ["[ic"] = "@class.inner",
            },
            goto_previous_end = {
              ["[R"] = "@return.inner",
              ["[H"] = "@function.outer",
              ["[C"] = "@class.outer",
              ["[iM"] = "@function.inner",
              ["[iC"] = "@class.inner",
            },
        },
        swap = {
           enable = true,
           swap_previous = {["[<leader>p"] = "@parameter.inner"},
           swap_next = {["]<leader>p"] = "@parameter.inner"},
        },
		lsp_interop = {
			enable = true,
			border = 'single',
			peek_definition_code = {
				-- ["<leader>pd"] = "@function.outer",
				["<leader>lh"] = "@function.outer",
				["gp"] = "@function.outer",
				["<leader>lc"] = "@class.outer"
			}
		}
	},
})
