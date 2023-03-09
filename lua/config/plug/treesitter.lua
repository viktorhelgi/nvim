local ts_config = require('nvim-treesitter.configs')


vim.keymap.set('n', 'ga', ":TSTextobjectRepeatLastMove<CR>", {})

ts_config.setup({
	-- A list of parser names, or "all"
	ensure_installed = { 'lua', 'python', 'cpp', 'fish'},

	-- Install languages synchronously (only applied to `ensure_installed`)
	sync_install = true,

	-- List of parsers to ignore installing
	ignore_install = {},

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
	-- #########################################
	-- Viktor Configs
	textobjects = {
        move = {
            enable = true,
            set_jumps = true,
            goto_next_start = {
              ["]n"] = "@number.inner",
              ["]ah"] = "@assignment.lhs",
              ["]al"] = "@assignment.rhs",
              ["]r"] = "@return.inner",
              ["]p"] = "@parameter.inner",
              ["]m"] = "@function.outer",
              ["]c"] = "@class.outer",
              ["]im"] = "@function.inner",
              ["]ic"] = "@class.inner",
            },
            goto_next_end = {
              ["]R"] = "@return.inner",
              ["]M"] = "@function.outer",
              ["]C"] = "@class.outer",
              ["]iM"] = "@function.inner",
              ["]iC"] = "@class.inner",
            },
            goto_previous_start = {
              ["[n"] = "@number.inner",
              ["[ah"] = "@assignment.lhs",
              ["[al"] = "@assignment.rhs",
              ["[r"] = "@return.inner",
              ["[p"] = "@parameter.inner",
              ["[m"] = "@function.outer",
              ["[c"] = "@class.outer",
              ["[im"] = "@function.inner",
              ["[ic"] = "@class.inner",
            },
            goto_previous_end = {
              ["[R"] = "@return.inner",
              ["[M"] = "@function.outer",
              ["[C"] = "@class.outer",
              ["[iM"] = "@function.inner",
              ["[iC"] = "@class.inner",
            },
        },
		lsp_interop = {
			enable = true,
			border = 'none',
			peek_definition_code = {
				-- ["<leader>pd"] = "@function.outer",
				["<leader>pm"] = "@function.outer",
				["<leader>pc"] = "@class.outer"
			}
		}
	},
})
